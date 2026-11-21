import 'package:flutter/gestures.dart';
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

  static const _referenceHz = 60;
  Duration _lastTick = Duration.zero;
  double _remainingStep = 0;

  void _stopWheel() {
    _ticker?.stop();
    _lastTick = Duration.zero;
    _remainingStep = 0;
    _currentVelocity = 0;
    _targetVelocity = 0;
  }

  @override
  void pointerScroll(double delta) {
    if (delta == 0) {
      _stopWheel();
      super.pointerScroll(delta);
      return;
    }

    if ((delta > 0 && pixels >= maxScrollExtent) ||
        (delta < 0 && pixels <= minScrollExtent)) {
      _stopWheel();
      return;
    }

    if (_currentVelocity * delta < 0 || _targetVelocity * delta < 0) {
      _stopWheel();
    }
    _targetVelocity += delta * multiplier;
    _ticker ??= context.vsync.createTicker(_onTick);
    if (!_ticker!.isActive) _ticker!.start();
  }

  void _onTick(Duration elapsed) {
    var steps = (elapsed - _lastTick).inMicroseconds *
        _referenceHz / Duration.microsecondsPerSecond;
    _lastTick = elapsed;
    var next = pixels;

    // Integra la curva original en pasos de 1/60 s. Entre pasos se
    // recorre la fracci?n correspondiente al tiempo real del fotograma.
    while (steps > 0) {
      if (_remainingStep == 0) {
        _currentVelocity += (_targetVelocity - _currentVelocity) * smoothing;
        _targetVelocity *= deceleration;
        if (_currentVelocity.abs() < 0.02 && _targetVelocity.abs() < 0.02) {
          _stopWheel();
          break;
        }
        _remainingStep = 1;
      }
      final fraction = steps < _remainingStep ? steps : _remainingStep;
      next += _currentVelocity * fraction;
      if (next <= minScrollExtent || next >= maxScrollExtent) {
        next = next.clamp(minScrollExtent, maxScrollExtent).toDouble();
        _stopWheel();
        break;
      }
      steps -= fraction;
      _remainingStep -= fraction;
    }
    if (next != pixels) super.jumpTo(next);
  }

  @override
  ScrollHoldController hold(VoidCallback holdCancelCallback) {
    _stopWheel();
    return super.hold(holdCancelCallback);
  }

  @override
  Drag drag(DragStartDetails details, VoidCallback dragCancelCallback) {
    _stopWheel();
    return super.drag(details, dragCancelCallback);
  }

  @override
  void jumpTo(double value) {
    _stopWheel();
    super.jumpTo(value);
  }

  @override
  Future<void> animateTo(double to, {required Duration duration, required Curve curve}) {
    _stopWheel();
    return super.animateTo(to, duration: duration, curve: curve);
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
