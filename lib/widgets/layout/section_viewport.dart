import 'package:flutter/widgets.dart';

/// Geometry of the vertical scroll view, measured inside its safe area.
class SectionViewport extends InheritedWidget {
  const SectionViewport({
    super.key,
    required this.size,
    required this.contentExtent,
    required super.child,
  });

  final Size size;
  final double contentExtent;

  static Size sizeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SectionViewport>()?.size ??
      MediaQuery.sizeOf(context);

  @override
  bool updateShouldNotify(SectionViewport oldWidget) =>
      size != oldWidget.size || contentExtent != oldWidget.contentExtent;
}
