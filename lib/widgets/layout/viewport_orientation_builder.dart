import 'package:flutter/widgets.dart';
import 'package:portfolio/design_system/extensions/context_extensions.dart';

/// Uses landscape layout for square viewports.
class ViewportOrientationBuilder extends StatelessWidget {
  const ViewportOrientationBuilder({super.key, required this.builder});

  final OrientationWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final size = context.viewportSize;
    return builder(context, size.height > size.width ? .portrait : .landscape);
  }
}
