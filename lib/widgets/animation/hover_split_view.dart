import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Un widget que presenta dos hijos en "solapamiento horizontal animado".
///
/// Ambos hijos siempre ocupan el 100% del ancho disponible, pero cada uno
/// tiene un [ClipRect] que limita cuánto de él es visible. La división
/// visible cambia animadamente según dónde esté el cursor del ratón:
///
/// - En reposo: cada hijo muestra exactamente la mitad ([initialSplitRatio] = 0.5).
/// - Al hacer hover sobre el izquierdo: la división crece hacia [hoveredSplitRatio].
/// - Al hacer hover sobre el derecho: la división decrece hacia 1 - [hoveredSplitRatio].
/// - Al retirar el cursor: vuelve suavemente a [initialSplitRatio].
///
/// ### Por qué el MouseRegion vive FUERA de los clips
///
/// Si los [MouseRegion] están dentro del [ClipRect], cuando el área recortada
/// se reduce a 0 el widget deja de ser "hittable" y `onExit` nunca se dispara.
/// La solución es usar un único [MouseRegion] que envuelve el [Stack] completo:
/// siempre es visible, siempre recibe eventos, y la posición del puntero
/// determina sobre qué mitad está el cursor.
class SplitOverlapView extends StatefulWidget {
  const SplitOverlapView({
    super.key,
    required this.leftChild,
    required this.rightChild,
    this.initialSplitRatio = 0.5,
    this.hoveredSplitRatio = 1.0,
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationCurve = Curves.easeInOut,
  })  : assert(
          initialSplitRatio > 0.0 && initialSplitRatio < 1.0,
          'initialSplitRatio debe estar en el rango abierto (0, 1).',
        ),
        assert(
          hoveredSplitRatio > 0.0 && hoveredSplitRatio <= 1.0,
          'hoveredSplitRatio debe estar en el rango (0, 1].',
        );

  /// Hijo que se renderiza a la izquierda (siempre ocupa el 100% del ancho).
  final Widget leftChild;

  /// Hijo que se renderiza a la derecha (siempre ocupa el 100% del ancho).
  final Widget rightChild;

  /// Fracción del ancho total asignada al área visible del hijo izquierdo
  /// cuando ningún cursor está encima. Por defecto 0.5 (mitad a cada uno).
  final double initialSplitRatio;

  /// Fracción máxima que el hijo con foco llega a ocupar. Por defecto 1.0
  /// (cubre completamente al hermano).
  final double hoveredSplitRatio;

  /// Duración de la animación de transición entre estados.
  final Duration animationDuration;

  /// Curva de la animación de transición.
  final Curve animationCurve;

  @override
  State<SplitOverlapView> createState() => _SplitOverlapViewState();
}

class _SplitOverlapViewState extends State<SplitOverlapView>
    with SingleTickerProviderStateMixin {
  // ─── Controlador ──────────────────────────────────────────────────────────

  late final AnimationController _controller;

  /// Valor desde el que parte la próxima animación (capturado al interrumpir).
  double _animationFrom = 0.5;

  /// Destino de la animación en curso.
  double _animationTo = 0.5;

  /// Valor interpolado actual de splitRatio (0 = derecho cubre todo, 1 = izquierdo).
  double get _splitRatio =>
      _animationFrom + (_animationTo - _animationFrom) * _curvedValue;

  /// Valor de la curva aplicada al progreso lineal del controller.
  double get _curvedValue =>
      widget.animationCurve.transform(_controller.value);

  // ─── Estado del hover ─────────────────────────────────────────────────────

  _HoveredSide? _hoveredSide;

  // ─── Ciclo de vida ────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();

    _animationFrom = widget.initialSplitRatio;
    _animationTo = widget.initialSplitRatio;

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    // Forzamos un rebuild en cada tick del controller.
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ─── Animación ────────────────────────────────────────────────────────────

  /// Lanza la animación hacia [target] partiendo desde el valor actual.
  ///
  /// Si hay una animación en curso, captura el valor interpolado presente
  /// como nuevo punto de partida, evitando cualquier salto visual.
  void _animateTo(double target) {
    if (_animationTo == target && _controller.isAnimating) return;

    // Captura el split actual (mid-animation o en reposo).
    final currentSplit = _splitRatio;

    _controller.stop();

    _animationFrom = currentSplit;
    _animationTo = target;

    // Calcula cuánto "recorrido" queda proporcionalmente para mantener
    // la velocidad percibida constante cuando se interrumpe a mitad.
    final totalDelta = (_animationTo - _animationFrom).abs();
    if (totalDelta < 1e-6) return; // Ya estamos en el destino.

    _controller.duration = widget.animationDuration;
    _controller
      ..reset()
      ..forward();
  }

  // ─── Handlers de mouse ────────────────────────────────────────────────────

  void _onHover(PointerHoverEvent event, double totalWidth) {
    final isLeft = event.localPosition.dx < totalWidth / 2;
    final side = isLeft ? _HoveredSide.left : _HoveredSide.right;

    if (side == _hoveredSide) return;
    _hoveredSide = side;

    _animateTo(
      side == _HoveredSide.left
          ? widget.hoveredSplitRatio
          : 1.0 - widget.hoveredSplitRatio,
    );
  }

  void _onExit() {
    if (_hoveredSide == null) return;
    _hoveredSide = null;
    _animateTo(widget.initialSplitRatio);
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final splitRatio = _splitRatio.clamp(0.0, 1.0);

        // El MouseRegion envuelve TODO el stack, por lo que siempre está
        // disponible para recibir eventos, independientemente de los clips.
        return MouseRegion(
          onHover: (event) => _onHover(event, totalWidth),
          onExit: (_) => _onExit(),
          child: SizedBox(
            height: 500,
            width: totalWidth,
            child: Stack(
              children: [
                // ── Hijo IZQUIERDO ────────────────────────────────────────
                // Anclado al borde izquierdo; ClipRect recorta por la derecha.
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: splitRatio,
                      child: SizedBox(
                        width: totalWidth,
                        child: widget.leftChild,
                      ),
                    ),
                  ),
                ),

                // ── Hijo DERECHO ──────────────────────────────────────────
                // Anclado al borde derecho; ClipRect recorta por la izquierda.
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerRight,
                      widthFactor: 1.0 - splitRatio,
                      child: SizedBox(
                        width: totalWidth,
                        child: widget.rightChild,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Identifica cuál de los dos hijos tiene el cursor encima.
enum _HoveredSide { left, right }