import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// WIDGET: AnimatedLevitation
// ---------------------------------------------------------------------------
// Widget que aplica una animación continua de levitación a cualquier [child].
// El widget se mueve suavemente hacia arriba y hacia abajo en un loop infinito,
// creando una ilusión de levitación o flotación.
//
// La animación funciona en dos fases dentro de cada ciclo:
//   1. Posición central → Elevarse (arriba)
//   2. Arriba → Posición central (reversa)
//
// Ejemplo básico:
//
//   AnimatedLevitation(
//     child: Icon(Icons.favorite, size: 48),
//   )
//
// Con parámetros personalizados:
//
//   AnimatedLevitation(
//     amplitude: 30,
//     duration: Duration(milliseconds: 2000),
//     delay: Duration(milliseconds: 500),
//     curve: Curves.easeInOut,
//     child: MyCard(),
//   )
//
// Con control externo:
//
//   AnimatedLevitation(
//     amplitude: 20,
//     controller: _myController,
//     child: FloatingElement(),
//   )
// ---------------------------------------------------------------------------
class AnimatedLevitation extends StatefulWidget {
  const AnimatedLevitation({
    super.key,

    // --- Contenido (cualquier widget) ---
    required this.child,

    // --- Parámetros de animación ---
    /// Amplitud del movimiento en píxeles (distancia hacia arriba).
    /// Por ejemplo, 8 significa que el widget subirá 8px desde su posición.
    this.amplitude = 0.1,

    /// Duración de un ciclo completo (arriba, abajo, regreso).
    this.duration = const Duration(milliseconds: 1200),

    /// Retraso antes de que comience la animación.
    /// Se ignora si se proporciona un [controller] externo.
    this.delay = Duration.zero,

    /// Curva de animación para determinar la suavidad del movimiento.
    /// Recomendado: Curves.easeInOut para un movimiento natural y fluido.
    this.curve = Curves.easeInOut,

    /// Si es true, la animación se lanza automáticamente al montar el widget.
    /// Se ignora si se proporciona un [controller] externo.
    this.autoPlay = true,

    /// Controller externo opcional. Permite sincronizar esta animación con
    /// otras o controlarla desde el widget padre.
    /// Si se proporciona, [autoPlay] y [delay] son ignorados.
    this.controller,
  });

  // ---- Contenido ----
  final Widget child;

  // ---- Parámetros de animación ----
  final double amplitude;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final bool autoPlay;
  final AnimationController? controller;

  @override
  State<AnimatedLevitation> createState() => _AnimatedLevitationState();
}

class _AnimatedLevitationState extends State<AnimatedLevitation>
    with SingleTickerProviderStateMixin {
  // Controller interno, usado solo cuando no se proporciona uno externo.
  late final AnimationController _internalController;

  // Referencia al controller activo (externo o interno).
  late final AnimationController _activeController;

  // Animación de levitación (traslación vertical).
  late final Animation<Offset> _levitationAnimation;

  @override
  void initState() {
    super.initState();

    _internalController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Preferir el controller externo si fue inyectado.
    _activeController = widget.controller ?? _internalController;

    // --- Construcción de la animación de levitación ---
    // La animación describe el movimiento vertical en un ciclo completo:
    // 0.0 → 0.5: Posición central (0) → Elevarse (-amplitude)
    // 0.5 → 1.0: Arriba (-amplitude) → Posición central (0, reversa)
    _levitationAnimation = TweenSequence<Offset>([
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: Offset(0, -widget.amplitude),
        ),
        weight: 50,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(
          begin: Offset(0, -widget.amplitude),
          end: Offset.zero,
        ),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(parent: _activeController, curve: widget.curve),
    );

    // Lanzar automáticamente solo si no hay controller externo.
    if (widget.autoPlay && widget.controller == null) {
      _playWithDelay();
    }
  }

  /// Lanza la animación en loop, respetando el [delay] configurado.
  Future<void> _playWithDelay() async {
    if (widget.delay > Duration.zero) {
      await Future.delayed(widget.delay);
    }
    // Verificar que el widget siga en el árbol antes de animar.
    if (mounted) {
      _activeController.repeat();
    }
  }

  @override
  void dispose() {
    // Solo destruir el controller interno; el externo es responsabilidad del padre.
    _internalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _levitationAnimation,
      child: widget.child,
    );
  }
}
