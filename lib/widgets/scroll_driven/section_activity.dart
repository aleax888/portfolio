import 'package:flutter/widgets.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_geometry.dart';

/// Keeps section layout available to navigation while delaying heavy assets.
class SectionActivity extends StatefulWidget {
  const SectionActivity({
    super.key,
    required this.controller,
    required this.child,
  });

  final ScrollController controller;
  final Widget child;

  static bool assetsReady(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_AssetState>()?.ready ?? true;

  @override
  State<SectionActivity> createState() => _SectionActivityState();
}

class _SectionActivityState extends State<SectionActivity> {
  bool ready = false;
  bool visible = false;

  void _onPosition(double top, ScrollPosition position, double boxHeight) {
    final height = position.viewportDimension;
    final bottom = top + boxHeight;
    final nextVisible = top < height && bottom > 0;
    final nextReady = ready || (top < height * 1.5 && bottom > -height * 0.5);
    if (nextVisible == visible && nextReady == ready) return;
    setState(() {
      ready = nextReady;
      visible = nextVisible;
    });
  }

  @override
  Widget build(BuildContext context) => ScrollGeometry(
    controller: widget.controller,
    onPosition: _onPosition,
    child: TickerMode(
      enabled: visible,
      child: _AssetState(ready: ready, child: widget.child),
    ),
  );
}

class _AssetState extends InheritedWidget {
  const _AssetState({required this.ready, required super.child});
  final bool ready;

  @override
  bool updateShouldNotify(_AssetState oldWidget) => ready != oldWidget.ready;
}
