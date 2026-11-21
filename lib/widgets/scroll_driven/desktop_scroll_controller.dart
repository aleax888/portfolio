import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class _DesktopScrollPosition extends ScrollPositionWithSingleContext {
  _DesktopScrollPosition({
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
    if (delta == 0) {
      _ticker?.stop();
      _currentVelocity = _targetVelocity = 0;
      super.pointerScroll(delta);
      return;
    }
    _targetVelocity += delta * multiplier;
    _ticker ??= context.vsync.createTicker(_onTick);
    if (!_ticker!.isActive) _ticker!.start();
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

/// Controller que "inyecta" el _DesktopScrollPosition de arriba.
class DesktopScrollController extends ScrollController {
  DesktopScrollController({
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
    return _DesktopScrollPosition(
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
