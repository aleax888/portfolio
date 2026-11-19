import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:portfolio/widgets/layout/section_viewport.dart';

/// Measures the leading edge relative to the scroll viewport after layout.
class ViewportObserver extends StatefulWidget {
  const ViewportObserver({
    super.key,
    required this.controller,
    required this.onPosition,
    required this.child,
  });

  final ScrollController controller;
  final void Function(double top, ScrollPosition position) onPosition;
  final Widget child;

  @override
  State<ViewportObserver> createState() => _ViewportObserverState();
}

class _ViewportObserverState extends State<ViewportObserver> {
  bool _scheduled = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scheduleMeasurement);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SectionViewport.sizeOf(context);
    _scheduleMeasurement();
  }

  @override
  void didUpdateWidget(ViewportObserver oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_scheduleMeasurement);
      widget.controller.addListener(_scheduleMeasurement);
    }
    _scheduleMeasurement();
  }

  void _scheduleMeasurement() {
    if (_scheduled) return;
    _scheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scheduled = false;
      if (!mounted || !widget.controller.hasClients) return;
      final box = context.findRenderObject();
      if (box is! RenderBox || !box.attached || !box.hasSize) return;
      final viewport = RenderAbstractViewport.maybeOf(box);
      final position = widget.controller.position;
      if (viewport == null || !position.hasContentDimensions) return;
      final top = viewport.getOffsetToReveal(box, 0).offset - position.pixels;
      widget.onPosition(top, position);
    });
    WidgetsBinding.instance.ensureVisualUpdate();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scheduleMeasurement);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(child: widget.child);
}
