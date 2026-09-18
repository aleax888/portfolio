import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';

/// Controla la inercia al SOLTAR un drag (dedo o thumb de la scrollbar).
class InertiaScrollPhysics extends ClampingScrollPhysics {
  /// Más bajo = desliza más lejos (más "resbaloso"). Default de Flutter: 0.015
  final double friction;

  const InertiaScrollPhysics({this.friction = 0.015, super.parent});

  @override
  InertiaScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return InertiaScrollPhysics(friction: friction, parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final tolerance = toleranceFor(position);

    // fuera de rango (overscroll): dejamos el rebote por defecto
    if (position.outOfRange) {
      return super.createBallisticSimulation(position, velocity);
    }

    if (velocity.abs() < tolerance.velocity) return null;
    if (velocity > 0 && position.pixels >= position.maxScrollExtent) return null;
    if (velocity < 0 && position.pixels <= position.minScrollExtent) return null;

    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      friction: friction,
      tolerance: tolerance,
    );
  }
}

/// ScrollPosition custom: intercepta SOLO la rueda del mouse/trackpad
/// para darle velocidad, smoothing y desaceleración propios.
class InertiaScrollPosition extends ScrollPositionWithSingleContext {
  InertiaScrollPosition({
    required super.physics,
    required super.context,
    super.initialPixels,
    super.keepScrollOffset,
    super.oldPosition,
    super.debugLabel,
    required this.multiplier,
    required this.smoothing,
    required this.deceleration,
  });

  final double multiplier;   // sensibilidad de la rueda
  final double smoothing;    // filtro de ruido (low-pass)
  final double deceleration; // 0-1, qué tan rápido se frena el momentum

  double _currentVelocity = 0;
  double _targetVelocity = 0;
  Ticker? _ticker;

  @override
  void pointerScroll(double delta) {
    _targetVelocity += delta * multiplier;
    _ticker ??= context.vsync.createTicker(_onTick);
    if (!_ticker!.isTicking) _ticker!.start();
  }

  void _onTick(Duration elapsed) {
    _currentVelocity += (_targetVelocity - _currentVelocity) * smoothing;
    _targetVelocity *= deceleration;

    if (_currentVelocity.abs() < 0.02 && _targetVelocity.abs() < 0.02) {
      _currentVelocity = 0;
      _targetVelocity = 0;
      _ticker?.stop();
      return;
    }

    jumpTo((pixels + _currentVelocity).clamp(minScrollExtent, maxScrollExtent));
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }
}

/// Controller que "inyecta" el InertiaScrollPosition de arriba.
class InertiaScrollController extends ScrollController {
  InertiaScrollController({
    this.wheelMultiplier = 0.1,
    this.wheelSmoothing = 0.1,
    this.wheelDeceleration = 0.94,
    super.initialScrollOffset = 0.0,
    super.keepScrollOffset = true,
    super.debugLabel,
  });

  final double wheelMultiplier;
  final double wheelSmoothing;
  final double wheelDeceleration;

  @override
  ScrollPositionWithSingleContext createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return InertiaScrollPosition(
      physics: physics,
      context: context,
      initialPixels: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      oldPosition: oldPosition,
      debugLabel: debugLabel,
      multiplier: wheelMultiplier,
      smoothing: wheelSmoothing,
      deceleration: wheelDeceleration,
    );
  }
}

/// Widget final: sin Listener, sin gesture-hacking, sin bloquear nada.
class SmoothScrollView extends StatelessWidget {
  final Widget child;
  final InertiaScrollController inertiaController;
  final double friction; // inercia del fling en touch / scrollbar
  final bool showScrollbar;

  const SmoothScrollView({
    super.key,
    required this.child,
    required this.inertiaController,
    this.friction = 0.015,
    this.showScrollbar = true,
  });

  @override
  Widget build(BuildContext context) {
    final view = SingleChildScrollView(
      controller: inertiaController,
      physics: InertiaScrollPhysics(friction: friction),
      child: child,
    );

    if (!showScrollbar) return view;

    return Scrollbar(
      controller: inertiaController,
      thumbVisibility: true,
      child: view,
    );
  }
}