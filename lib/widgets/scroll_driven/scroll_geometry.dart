import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Local geometry for a box inside the controller's vertical viewport.
class ScrollGeometry extends SingleChildRenderObjectWidget {
  const ScrollGeometry({
    super.key,
    required this.controller,
    required this.onPosition,
    required super.child,
  });

  final ScrollController controller;
  final void Function(double, ScrollPosition) onPosition;

  @override
  RenderProxyBox createRenderObject(BuildContext context) =>
      _ScrollGeometryBox(controller, onPosition);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderProxyBox renderObject,
  ) {
    (renderObject as _ScrollGeometryBox).configure(controller, onPosition);
  }
}

class _ScrollGeometryBox extends RenderProxyBox {
  _ScrollGeometryBox(this.controller, this.onPosition);

  ScrollController controller;
  void Function(double, ScrollPosition) onPosition;
  double? anchor;
  bool scheduled = false;

  void configure(
    ScrollController next,
    void Function(double, ScrollPosition) callback,
  ) {
    if (controller != next) {
      if (attached) controller.removeListener(_onScroll);
      controller = next;
      anchor = null;
      if (attached) controller.addListener(_onScroll);
    }
    onPosition = callback;
    markNeedsPaint();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    controller.addListener(_onScroll);
  }

  @override
  void detach() {
    controller.removeListener(_onScroll);
    anchor = null;
    super.detach();
  }

  void _onScroll() {
    if (anchor == null || controller.positions.length != 1) return;
    final position = controller.position;
    if (position.hasContentDimensions) {
      onPosition(anchor! - position.pixels, position);
    }
  }

  // Layout may move this box even when the user's scroll offset is unchanged.
  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    if (scheduled) return;
    scheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scheduled = false;
      if (!attached || !hasSize || controller.positions.length != 1) return;
      final viewport = RenderAbstractViewport.maybeOf(this);
      if (viewport == null) return;
      anchor = viewport.getOffsetToReveal(this, 0).offset;
      _onScroll();
    });
  }
}
