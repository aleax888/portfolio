import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Fires [onThresholdCrossed] each time the child's leading edge crosses
/// [threshold] (a fraction of the viewport height, e.g. 0.7 → 70 % from top)
/// **while scrolling upward** (content moving up → scroll offset increasing).
///
/// Example:
/// ```dart
/// ViewportThresholdNotifier(
///   controller: _scrollController,
///   threshold: 0.7,
///   onThresholdCrossed: () => print('crossed!'),
///   child: MyCard(),
/// )
/// ```
class ViewportThresholdNotifier extends StatefulWidget {
  const ViewportThresholdNotifier({
    super.key,
    required this.controller,
    required this.threshold,
    required this.onThresholdCrossed,
    required this.child,
  }) : assert(threshold > 0 && threshold <= 1, 'threshold must be in (0, 1]');

  /// The [ScrollController] driving the parent [Scrollable].
  final ScrollController controller;

  /// Fraction of the viewport height that defines the threshold line.
  /// Must be in the range (0, 1].
  final double threshold;

  /// Called each time the child's leading edge crosses the threshold line
  /// while the user scrolls **upward** (offset increasing).
  final VoidCallback onThresholdCrossed;

  final Widget child;

  @override
  State<ViewportThresholdNotifier> createState() =>
      _ViewportThresholdNotifierState();
}

class _ViewportThresholdNotifierState extends State<ViewportThresholdNotifier> {
  final _key = GlobalKey();

  /// Last known scroll offset — used to detect scroll direction.
  double _lastOffset = 0;

  /// Whether the child was **below** the threshold line on the previous frame.
  /// `null` means we haven't measured yet.
  bool? _wasBelow;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(ViewportThresholdNotifier old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller.removeListener(_onScroll);
      widget.controller.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final offset = widget.controller.offset;
    final scrollingUp = offset > _lastOffset; // content moves upward
    _lastOffset = offset;

    if (!scrollingUp) return; // only care about upward scrolls

    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    // Position of the child's top edge in the viewport coordinate space.
    final viewportOffset = _childTopInViewport(renderBox);
    if (viewportOffset == null) return;

    final viewportHeight = _viewportHeight(renderBox);
    if (viewportHeight == null) return;

    final thresholdY = viewportHeight * widget.threshold;
    final isBelow = viewportOffset > thresholdY;

    if (_wasBelow == true && !isBelow) {
      // Leading edge just crossed the threshold line upward → fire callback.
      widget.onThresholdCrossed();
    }

    _wasBelow = isBelow;
  }

  /// Returns the child's top-edge Y position relative to the nearest
  /// [RenderAbstractViewport], or `null` if unavailable.
  double? _childTopInViewport(RenderBox renderBox) {
    final viewport = RenderAbstractViewport.maybeOf(renderBox);
    if (viewport == null) return null;

    // getOffsetToReveal gives us the scroll offset needed to reveal the
    // object; the difference with the current offset is the visual position.
    final revealOffset = viewport
        .getOffsetToReveal(renderBox, 0)
        .offset; // 0 = leading edge

    return revealOffset - widget.controller.offset;
  }

  /// Returns the visible height of the nearest viewport, or `null`.
  double? _viewportHeight(RenderBox renderBox) {
    final viewport = RenderAbstractViewport.maybeOf(renderBox);
    if (viewport == null) return null;
    final size = (viewport as RenderObject).paintBounds;
    return size.height;
  }

  @override
  Widget build(BuildContext context) =>
      KeyedSubtree(key: _key, child: widget.child);
}
