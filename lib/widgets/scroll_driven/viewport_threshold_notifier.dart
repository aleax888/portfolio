import 'package:flutter/widgets.dart';
import 'package:portfolio/widgets/scroll_driven/viewport_observer.dart';

/// Fires on entry, including an initial position already past the threshold.
/// Returning below the activation line arms the next crossing.
class ViewportThresholdNotifier extends StatefulWidget {
  const ViewportThresholdNotifier({
    super.key,
    required this.controller,
    required this.threshold,
    required this.onThresholdCrossed,
    required this.child,
  }) : assert(threshold > 0 && threshold <= 1);

  final ScrollController controller;
  final double threshold;
  final VoidCallback onThresholdCrossed;
  final Widget child;

  @override
  State<ViewportThresholdNotifier> createState() =>
      _ViewportThresholdNotifierState();
}

class _ViewportThresholdNotifierState extends State<ViewportThresholdNotifier> {
  bool _pastThreshold = false;

  @override
  void didUpdateWidget(ViewportThresholdNotifier oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) _pastThreshold = false;
  }

  @override
  Widget build(BuildContext context) => ViewportObserver(
    controller: widget.controller,
    onPosition: (top, position) {
      final atEnd = position.pixels >= position.maxScrollExtent;
      final line = position.viewportDimension * (atEnd ? 1 : widget.threshold);
      final entered = top <= line;
      if (entered && !_pastThreshold) widget.onThresholdCrossed();
      _pastThreshold = entered;
    },
    child: widget.child,
  );
}
