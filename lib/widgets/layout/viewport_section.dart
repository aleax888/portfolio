import 'package:flutter/widgets.dart';
import 'package:portfolio/design_system/constants/layout_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/design_system/extensions/context_extensions.dart';

/// Fills one safe viewport. In short windows or with enlarged text the page
/// may grow by the space the content actually needs, using the same scroll view.
class ViewportSection extends StatelessWidget {
  const ViewportSection({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = context.viewportSize;
    final minimumHeight = size.width < LayoutConstants.tabletWidth
        ? LayoutConstants.minPortraitSectionHeight
        : LayoutConstants.minSectionHeight;
    final textScale =
        MediaQuery.textScalerOf(context).scale(TextSizeConstants.s) /
        TextSizeConstants.s;
    final needsRoom =
        size.height < minimumHeight ||
        textScale > LayoutConstants.largeTextScale;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: size.height,
        maxHeight: needsRoom ? double.infinity : size.height,
      ),
      child: child,
    );
  }
}
