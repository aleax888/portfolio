import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';

class SectionTitle extends StatelessWidget {
  final int index;
  final String title;
  final Color color;
  final ScrollController? scrollController;
  const SectionTitle({
    super.key,
    required this.index,
    required this.title,
    this.color = ColorPaletteConstants.secondary,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedTranslation(
        origin: .fromLeft,
        scrollController: scrollController,
        child: Stack(
          alignment: .centerLeft,
          children: [
            Text(
              index.toString().padLeft(2, '0'),
              style: TextStyle(
                fontFamily: TextFamilyConstants.primary,
                color: color.withAlpha(51),
                fontSize: ResponsiveFontSize.linear(
                  TextSizeConstants.sectionNumberMax,
                  context.viewportSize,
                ),
                fontWeight: TextWeightConstants.black,
              ),
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
            ),
            Text(
              '/  /  $title',
              style: TextStyle(
                fontFamily: TextFamilyConstants.secondary,
                color: color,
                fontSize: TextSizeConstants.s,
                fontWeight: TextWeightConstants.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
