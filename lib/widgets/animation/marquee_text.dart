import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// WIDGET: MarqueeText
// ---------------------------------------------------------------------------
// Anima un [String] en bucle continuo de derecha a izquierda (marquee/ticker).
//
// Primera iteracion:
//   El texto parte desde [startOffsetFraction] * containerWidth.
//   Util para que el texto sea visible de inmediato sin esperar a que
//   entre desde el borde derecho.
//
// Iteraciones siguientes (loop continuo):
//   El texto siempre entra desde fuera del borde derecho, garantizando
//   una animacion fluida e ininterrumpida.
//
// Uso basico (comportamiento clasico):
//
//   MarqueeText(
//     text: 'Oferta especial hoy! Envio gratis en compras mayores a S/ 50',
//   )
//
// Comenzar desde el centro y luego loopar normalmente:
//
//   MarqueeText(
//     text: 'Breaking news - Flutter 4.0 released',
//     startOffsetFraction: 0.5,
//     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//     speedPixelsPerSecond: 120,
//   )
// ---------------------------------------------------------------------------
class MarqueeText extends StatefulWidget {
  const MarqueeText({
    super.key,

    // --- Contenido ---
    required this.text,

    // --- Estilo ---
    /// Estilo del texto. Si es null se hereda del [DefaultTextStyle] del contexto.
    this.style,

    // --- Animacion ---
    /// Velocidad de desplazamiento en pixels logicos por segundo.
    this.speedPixelsPerSecond = 80.0,

    /// Pausa antes de que el texto comience a moverse por primera vez.
    this.initialDelay = Duration.zero,

    /// Fraccion [0.0 - 1.0] del ancho del contenedor desde donde arranca
    /// SOLO la primera iteracion. Las siguientes siempre entran desde fuera
    /// del borde derecho para mantener la continuidad del loop.
    ///
    ///   * 0.0 - visible desde el borde izquierdo desde el primer frame.
    ///   * 0.5 - comienza en el centro del contenedor.
    ///   * 1.0 - comienza fuera del borde derecho (igual que todas las demas).
    ///
    /// Valores fuera del rango se recortan automaticamente con clamp.
    this.startOffsetFraction = 1.0,
  });

  final String text;
  final TextStyle? style;
  final double speedPixelsPerSecond;
  final Duration initialDelay;
  final double startOffsetFraction;

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  /// Ancho del contenedor, obtenido via [LayoutBuilder].
  double _containerWidth = 0.0;

  /// Ancho real del texto medido con [TextPainter] en pixels logicos.
  double _textWidth = 0.0;

  // ---------------------------------------------------------------------------
  // Getters de geometria
  // ---------------------------------------------------------------------------

  /// Posicion de inicio de la PRIMERA iteracion en pixels.
  double get _firstStartLeft =>
      _containerWidth * widget.startOffsetFraction.clamp(0.0, 1.0);

  /// Posicion de inicio de las iteraciones del LOOP (siempre desde fuera).
  double get _loopStartLeft => _containerWidth;

  /// Recorrido de la primera iteracion: desde [_firstStartLeft] hasta salir.
  double get _firstTravel => _firstStartLeft + _textWidth;

  /// Recorrido de cada iteracion del loop: entrada completa desde la derecha.
  double get _loopTravel => _loopStartLeft + _textWidth;

  /// Duracion de la primera iteracion, proporcional a su recorrido.
  Duration get _firstDuration => _durationForTravel(_firstTravel);

  /// Duracion de cada iteracion del loop, proporcional a su recorrido.
  Duration get _loopDuration => _durationForTravel(_loopTravel);

  Duration _durationForTravel(double travel) => Duration(
        milliseconds: (travel / widget.speedPixelsPerSecond * 1000).round(),
      );

  /// Posicion `left` actual del texto.
  ///
  /// Durante la primera iteracion el controller va de 0.0 a 1.0 cubriendo
  /// [_firstTravel]. Durante el loop cubre [_loopTravel]. La formula es
  /// identica en ambos casos porque [_currentStart] y [_currentTravel] cambian
  /// entre fases; el getter siempre refleja la fase activa.
  double get _leftPosition =>
      _currentStart - (_controller.value * _currentTravel);

  /// Inicio y recorrido de la fase activa: se actualizan en [_enterLoopPhase].
  double _currentStart = 0.0;
  double _currentTravel = 0.0;

  // ---------------------------------------------------------------------------
  // Ciclo de vida
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addStatusListener(_onAnimationStatus);
  }

  /// Listener de estado: cuando termina la primera iteracion, cambia a loop.
  void _onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _enterLoopPhase();
    }
  }

  /// Callback del [LayoutBuilder].
  void _onLayoutKnown(double containerWidth) {
    if (containerWidth == _containerWidth && _textWidth != 0.0) return;

    _containerWidth = containerWidth;

    if (_textWidth == 0.0) {
      _textWidth = _measureTextWidth();
      _startFirstIteration();
    } else {
      // Cambio de ancho en caliente (rotacion, resize): reiniciar desde loop.
      _enterLoopPhase();
    }
  }

  /// Arranca la primera iteracion con [startOffsetFraction] como origen.
  Future<void> _startFirstIteration() async {
    _currentStart = _firstStartLeft;
    _currentTravel = _firstTravel;
    _controller.duration = _firstDuration;

    if (widget.initialDelay > Duration.zero) {
      await Future.delayed(widget.initialDelay);
    }

    if (mounted) {
      _controller.forward(from: 0.0);
    }
  }

  /// Cambia a la fase de loop: el texto siempre entra desde fuera del borde
  /// derecho y se repite indefinidamente.
  void _enterLoopPhase() {
    _currentStart = _loopStartLeft;
    _currentTravel = _loopTravel;

    _controller
      ..duration = _loopDuration
      ..repeat(min: 0.0);
  }

  @override
  void didUpdateWidget(covariant MarqueeText oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool textOrStyleChanged =
        oldWidget.text != widget.text || oldWidget.style != widget.style;

    final bool animationParamsChanged =
        oldWidget.speedPixelsPerSecond != widget.speedPixelsPerSecond ||
        oldWidget.startOffsetFraction != widget.startOffsetFraction;

    if (textOrStyleChanged || animationParamsChanged) {
      if (textOrStyleChanged) _textWidth = _measureTextWidth();
      // Ante cualquier cambio de parametros, retomar el loop con los
      // nuevos valores sin saltar (preservar progreso relativo).
      final double progress = _controller.value;
      _currentStart = _loopStartLeft;
      _currentTravel = _loopTravel;
      _controller
        ..duration = _loopDuration
        ..value = progress
        ..repeat();
    }
  }

  // ---------------------------------------------------------------------------
  // Medicion y estilo
  // ---------------------------------------------------------------------------

  double _measureTextWidth() {
    final painter = TextPainter(
      text: TextSpan(text: widget.text, style: _resolvedStyle()),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return painter.width;
  }

  TextStyle _resolvedStyle() {
    return const TextStyle(fontSize: 14).merge(widget.style);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _onLayoutKnown(constraints.maxWidth);
        });

        return ClipRect(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    left: _leftPosition,
                    top: 0,
                    bottom: 0,
                    child: child!,
                  ),
                ],
              );
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.text,
                maxLines: 1,
                softWrap: false,
                style: _resolvedStyle(),
              ),
            ),
          ),
        );
      },
    );
  }
}