import 'package:flutter/material.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_geometry.dart';
import 'package:portfolio/design_system/constants/motion_constants.dart';

// ---------------------------------------------------------------------------
// ENUM: TranslationOrigin
// ---------------------------------------------------------------------------
enum TranslationOrigin {
  fromLeft(Offset(-1, 0)),
  fromRight(Offset(1, 0)),
  fromTop(Offset(0, -1)),
  fromBottom(Offset(0, 1)),
  fromTopLeft(Offset(-1, -1)),
  fromTopRight(Offset(1, -1)),
  fromBottomLeft(Offset(-1, 1)),
  fromBottomRight(Offset(1, 1));

  const TranslationOrigin(this._direction);
  final Offset _direction;
}

extension TranslationOriginExtension on TranslationOrigin {
  Offset toOffset({double distance = 1.0}) => _direction * distance;
}

// ---------------------------------------------------------------------------
// WIDGET: AnimatedTranslation
// ---------------------------------------------------------------------------
class AnimatedTranslation extends StatefulWidget {
  const AnimatedTranslation({
    super.key,
    required this.child,
    required this.origin,
    this.duration = MotionConstants.translationDuration,
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.distance = 1.5,
    this.autoPlay = true,
    this.scrollController,
    this.threshold = 0.85,
    this.controller,
    this.withFade = false,
  });

  final Widget child;
  final TranslationOrigin origin;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double distance;
  final bool autoPlay;
  final ScrollController? scrollController;
  final double threshold;
  final AnimationController? controller;
  final bool withFade;

  @override
  State<AnimatedTranslation> createState() => _AnimatedTranslationState();
}

class _AnimatedTranslationState extends State<AnimatedTranslation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _internalController;
  late final AnimationController _activeController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _internalController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _activeController = widget.controller ?? _internalController;

    _slideAnimation = Tween<Offset>(
      begin: widget.origin.toOffset(distance: widget.distance),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _activeController, curve: widget.curve));

    _fadeAnimation = Tween<double>(
      begin: widget.withFade ? 0.0 : 1.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _activeController, curve: widget.curve));

    if (widget.scrollController == null &&
        widget.autoPlay &&
        widget.controller == null) {
      _playWithDelay();
    }
  }

  Future<void> _playWithDelay() async {
    if (widget.delay > Duration.zero) await Future.delayed(widget.delay);
    if (mounted) _activeController.forward();
  }

  @override
  void dispose() {
    _internalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transition = SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(opacity: _fadeAnimation, child: widget.child),
    );
    final scroll = widget.scrollController;
    if (scroll == null) return transition;
    return ScrollGeometry(
      controller: scroll,
      onPosition: (top, position, _) {
        final threshold = position.pixels >= position.maxScrollExtent
            ? 1.0
            : widget.threshold;
        if (top <= position.viewportDimension * threshold &&
            _activeController.isDismissed) {
          _activeController.forward();
        }
      },
      child: transition,
    );
  }
}
