import 'package:flutter/material.dart';
import 'package:portfolio/widgets/scroll_driven/viewport_threshold_notifier.dart';

// ---------------------------------------------------------------------------
// ENUM: TranslationOrigin
// ---------------------------------------------------------------------------
enum TranslationOrigin {
  fromLeft,
  fromRight,
  fromTop,
  fromBottom,
  fromTopLeft,
  fromTopRight,
  fromBottomLeft,
  fromBottomRight,
}

extension TranslationOriginExtension on TranslationOrigin {
  Offset toOffset({double distance = 1.0}) {
    switch (this) {
      case TranslationOrigin.fromLeft:
        return Offset(-distance, 0);
      case TranslationOrigin.fromRight:
        return Offset(distance, 0);
      case TranslationOrigin.fromTop:
        return Offset(0, -distance);
      case TranslationOrigin.fromBottom:
        return Offset(0, distance);
      case TranslationOrigin.fromTopLeft:
        return Offset(-distance, -distance);
      case TranslationOrigin.fromTopRight:
        return Offset(distance, -distance);
      case TranslationOrigin.fromBottomLeft:
        return Offset(-distance, distance);
      case TranslationOrigin.fromBottomRight:
        return Offset(distance, distance);
    }
  }
}

// ---------------------------------------------------------------------------
// WIDGET: AnimatedTranslation
// ---------------------------------------------------------------------------
class AnimatedTranslation extends StatefulWidget {
  const AnimatedTranslation({
    super.key,
    required this.child,
    required this.origin,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
    this.curve = Curves.easeOut,
    this.distance = 1.5,
    this.autoPlay = true,
    this.controller,
    this.withFade = false,
    // --- Scroll-reveal opcional ---
    /// Si se provee, la animación se dispara cuando el widget cruza [threshold]
    /// del viewport al hacer scroll. Cuando está activo, [autoPlay] y [delay]
    /// son ignorados (a menos que no haya controller externo).
    this.scrollController,
    this.threshold = 0.85,
  });

  final Widget child;
  final TranslationOrigin origin;
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double distance;
  final bool autoPlay;
  final AnimationController? controller;
  final bool withFade;

  // Scroll-reveal
  final ScrollController? scrollController;
  final double threshold;

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

    // Sin scroll controller → comportamiento original.
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

  void _onThresholdCrossed() {
    if (!_activeController.isCompleted) _activeController.forward();
  }

  @override
  void dispose() {
    _internalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animated = SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(opacity: _fadeAnimation, child: widget.child),
    );

    if (widget.scrollController == null) return animated;

    return ViewportThresholdNotifier(
      controller: widget.scrollController!,
      threshold: widget.threshold,
      onThresholdCrossed: _onThresholdCrossed,
      child: animated,
    );
  }
}

// ---------------------------------------------------------------------------
// WIDGET: AnimatedTranslationGroup
// ---------------------------------------------------------------------------
class AnimatedTranslationItem {
  const AnimatedTranslationItem({
    required this.child,
    required this.origin,
    this.curve = Curves.easeOut,
    this.distance = 1.5,
    this.withFade = false,
  });

  final Widget child;
  final TranslationOrigin origin;
  final Curve curve;
  final double distance;
  final bool withFade;
}

class AnimatedTranslationGroup extends StatelessWidget {
  const AnimatedTranslationGroup({
    super.key,
    required this.items,
    this.duration = const Duration(milliseconds: 500),
    this.staggerDelay = const Duration(milliseconds: 120),
    this.initialDelay = Duration.zero,
    this.spacing = 8.0,
    this.direction = Axis.vertical,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    // --- Scroll-reveal opcional ---
    /// Si se provee, todos los ítems del grupo se revelan al cruzar [threshold].
    /// El stagger sigue aplicando: cada ítem arranca con su delay incremental
    /// desde el momento en que el grupo cruza el umbral.
    this.scrollController,
    this.threshold = 0.85,
  });

  final List<AnimatedTranslationItem> items;
  final Duration duration;
  final Duration staggerDelay;
  final Duration initialDelay;
  final double spacing;
  final Axis direction;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  // Scroll-reveal
  final ScrollController? scrollController;
  final double threshold;

  @override
  Widget build(BuildContext context) {
    final animatedChildren = List.generate(items.length, (index) {
      final item = items[index];

      // Con scroll controller el delay es siempre el stagger puro,
      // sin initialDelay (el umbral ya actúa como el "inicio").
      final itemDelay = scrollController != null
          ? staggerDelay * index
          : initialDelay + (staggerDelay * index);

      final spacer = index < items.length - 1
          ? (direction == Axis.vertical
                ? SizedBox(height: spacing)
                : SizedBox(width: spacing))
          : const SizedBox.shrink();

      return [
        AnimatedTranslation(
          origin: item.origin,
          duration: duration,
          delay: itemDelay,
          curve: item.curve,
          distance: item.distance,
          withFade: item.withFade,
          autoPlay: true,
          // Solo el primer ítem lleva el notifier; él dispara a los demás
          // mediante el delay escalonado. Los demás tienen scrollController=null
          // para no crear N listeners redundantes.
          scrollController: index == 0 ? scrollController : null,
          threshold: threshold,
          child: item.child,
        ),
        spacer,
      ];
    }).expand((pair) => pair).toList();

    return direction == Axis.vertical
        ? Column(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: animatedChildren,
          )
        : Row(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: animatedChildren,
          );
  }
}
