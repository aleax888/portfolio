import 'dart:math' as math;

import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:portfolio/design_system/constants/motion_constants.dart';

/// Smooths pointer-wheel deltas on the same position used by the scrollbar,
/// touch gestures, navigation and scroll-driven scenes.
class InertiaScrollController extends ScrollController {
  InertiaScrollController({super.initialScrollOffset, super.keepScrollOffset});

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) => _WheelScrollPosition(
    physics: physics,
    context: context,
    oldPosition: oldPosition,
    initialPixels: initialScrollOffset,
    keepScrollOffset: keepScrollOffset,
  );
}

class _WheelScrollPosition extends ScrollPositionWithSingleContext {
  _WheelScrollPosition({
    required super.physics,
    required super.context,
    required super.oldPosition,
    required super.initialPixels,
    required super.keepScrollOffset,
  });

  @override
  void pointerScroll(double delta) {
    if (delta == 0 ||
        WidgetsBinding
            .instance
            .platformDispatcher
            .accessibilityFeatures
            .disableAnimations) {
      super.pointerScroll(delta);
      return;
    }
    final current = activity;
    final continuing = current is _WheelScrollActivity;
    final base = continuing && (current.target - pixels) * delta > 0
        ? current.target
        : pixels;
    final target = (base + delta).clamp(minScrollExtent, maxScrollExtent);
    if (target == pixels) {
      if (continuing) goIdle();
      return;
    }
    updateUserScrollDirection(
      delta > 0 ? ScrollDirection.reverse : ScrollDirection.forward,
    );
    if (continuing) {
      current.target = target;
    } else {
      beginActivity(_WheelScrollActivity(this, target));
    }
  }
}

class _WheelScrollActivity extends ScrollActivity {
  _WheelScrollActivity(_WheelScrollPosition position, this.target)
    : super(position) {
    _ticker = position.context.vsync.createTicker(_tick)..start();
  }

  late final Ticker _ticker;
  Duration _lastTick = Duration.zero;
  double target;
  _WheelScrollPosition get _position => delegate as _WheelScrollPosition;

  @override
  bool get isScrolling => true;

  @override
  bool get shouldIgnorePointer => false;

  @override
  double get velocity =>
      (target - _position.pixels) *
      Duration.microsecondsPerSecond /
      MotionConstants.wheelResponseTime.inMicroseconds;

  void _tick(Duration elapsed) {
    final dt = elapsed - _lastTick;
    _lastTick = elapsed;
    target = target.clamp(_position.minScrollExtent, _position.maxScrollExtent);
    final remaining = target - _position.pixels;
    final decay = math.exp(
      -dt.inMicroseconds / MotionConstants.wheelResponseTime.inMicroseconds,
    );
    final done =
        remaining.abs() * decay <=
        _position.physics.toleranceFor(_position).distance;
    final next = done ? target : target - remaining * decay;
    final overscroll = delegate.setPixels(next);
    if (done || overscroll != 0) delegate.goBallistic(0);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
