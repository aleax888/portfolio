import 'package:flutter/widgets.dart';
import 'package:portfolio/design_system/extensions/context_extensions.dart';

/// Fills one viewport and expands vertically when the content needs more room.
class GrowingViewportSection extends StatelessWidget {
  const GrowingViewportSection({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(
      minWidth: double.infinity,
      minHeight: context.viewportSize.height,
    ),
    child: child,
  );
}
