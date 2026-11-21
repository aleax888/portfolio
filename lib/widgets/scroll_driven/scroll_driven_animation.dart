import 'package:portfolio/widgets/scroll_driven/section_activity.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/widgets/scroll_driven/pinned_scroll_scene.dart';
import 'package:portfolio/widgets/effects/shadowed_container.dart';

class ScrollDrivenAnimation extends StatefulWidget {
  final String animationPath;
  final double pixelsPerFrame;
  final double initialFrames;
  final ScrollController scrollController;
  final Widget? child;

  const ScrollDrivenAnimation({
    super.key,
    required this.animationPath,
    required this.scrollController,
    this.pixelsPerFrame = 16.0,
    this.child,
    this.initialFrames = 0,
  }) : assert(pixelsPerFrame > 0);

  @override
  State<ScrollDrivenAnimation> createState() => _ScrollDrivenAnimationState();
}

class _ScrollDrivenAnimationState extends State<ScrollDrivenAnimation> {
  double? _frames;

  @override
  void didUpdateWidget(ScrollDrivenAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationPath != oldWidget.animationPath) _frames = null;
  }

  @override
  Widget build(BuildContext context) => PinnedScrollScene(
    controller: widget.scrollController,
    distance: (_frames ?? widget.initialFrames) * widget.pixelsPerFrame,
    builder: (context, progress) {
      if (!SectionActivity.assetsReady(context)) return const SizedBox.expand();
      return Stack(
        fit: StackFit.expand,
        children: [
          ShadowedContainer(
            shadowColor: const Color(0xFF763CAC),
            shadowColorEnd: const Color(0xFF320F85),
            shadowBlurRadius: 500,
            shadowSpreadRadius: 5,
            child: Positioned.fill(
              child: Opacity(
                opacity: 0.5,
                child: Lottie.asset(
                  widget.animationPath,
                  controller: AlwaysStoppedAnimation(progress),
                  fit: BoxFit.contain,
                  onLoaded: (composition) {
                    if (mounted && _frames != composition.durationFrames) {
                      setState(() => _frames = composition.durationFrames);
                    }
                  },
                ),
              ),
            ),
          ),
          if (widget.child != null) Center(child: widget.child),
        ],
      );
    },
  );
}
