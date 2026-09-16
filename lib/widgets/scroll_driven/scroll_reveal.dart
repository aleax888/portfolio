import 'package:flutter/material.dart';
import 'package:portfolio/widgets/scroll_driven/viewport_threshold_notifier.dart';

class ScrollReveal extends StatefulWidget {
  final ScrollController scrollController;
  final Widget child;
  final Duration duration;
  final double threshold;
  final Offset slideBegin;
  final Curve curve;

  const ScrollReveal({
    super.key,
    required this.child,
    required this.scrollController,
    this.duration = const Duration(milliseconds: 600),
    this.threshold = 0.5,
    this.slideBegin = const Offset(0, 0.06),
    this.curve = Curves.easeOut,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);
    _fade = curved;
    _slide = Tween<Offset>(
      begin: widget.slideBegin,
      end: Offset.zero,
    ).animate(curved);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onThresholdCrossed() {
    if (!_controller.isCompleted) _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ViewportThresholdNotifier(
      controller: widget.scrollController,
      threshold: widget.threshold,
      onThresholdCrossed: _onThresholdCrossed,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(opacity: _fade, child: widget.child),
      ),
    );
  }
}
