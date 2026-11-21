import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/motion_constants.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_geometry.dart';

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
    this.duration = MotionConstants.revealDuration,
    this.threshold = 0.5,
    this.slideBegin = const Offset(0, 0.06),
    this.curve = Curves.easeOut,
  }) : assert(threshold > 0 && threshold <= 1);

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
    return ScrollGeometry(
      controller: widget.scrollController,
      onPosition: (top, position, _) {
        final atEnd = position.pixels >= position.maxScrollExtent;
        if (top <=
                position.viewportDimension * (atEnd ? 1 : widget.threshold) &&
            _controller.isDismissed) {
          _onThresholdCrossed();
        }
      },
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(opacity: _fade, child: widget.child),
      ),
    );
  }
}
