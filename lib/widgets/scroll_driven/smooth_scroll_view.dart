import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SmoothScrollView extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final double friction; // desaceleración (0.9–0.98)
  final double smoothing; // filtro de ruido
  final double multiplier; // sensibilidad del scroll
  const SmoothScrollView({
    super.key,
    required this.child,
    required this.scrollController,
    this.friction = 0.92,
    this.smoothing = 0.15,
    this.multiplier = 0.04,
  });

  @override
  State<SmoothScrollView> createState() => _SmoothScrollViewState();
}

class _SmoothScrollViewState extends State<SmoothScrollView>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;

  double _velocity = 0.0;
  double _targetVelocity = 0.0;

  @override
  void initState() {
    super.initState();

    _ticker = createTicker(_tick)..start();
  }

  void _tick(Duration elapsed) {
    // 🎯 1. Suavizado (low-pass filter)
    _velocity += (_targetVelocity - _velocity) * widget.smoothing;

    // 🎯 2. Aplicar movimiento
    if (_velocity.abs() > 0.01) {
      widget.scrollController.jumpTo(
        _clampScroll(widget.scrollController.offset + _velocity),
      );

      // 🎯 3. Fricción (desaceleración)
      _targetVelocity *= widget.friction;
    } else {
      _velocity = 0;
      _targetVelocity = 0;
    }
  }

  double _clampScroll(double value) {
    if (!widget.scrollController.hasClients) return value;

    final min = widget.scrollController.position.minScrollExtent;
    final max = widget.scrollController.position.maxScrollExtent;

    return math.min(max, math.max(min, value));
  }

  void _onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      // 📉 Convertimos la “sierra” en input acumulativo
      _targetVelocity += event.scrollDelta.dy * widget.multiplier;
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _onPointerSignal,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        physics: const NeverScrollableScrollPhysics(),
        child: widget.child,
      ),
    );
  }
}
