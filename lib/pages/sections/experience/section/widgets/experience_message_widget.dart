import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_reveal.dart';

class ExperienceMessageWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ExperienceMessageWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      scrollController: scrollController,
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontFamily: TextFamilyConstants.secondary,
            fontStyle: .italic,
            fontSize: ResponsiveFontSize.logarithmic(
              TextSizeConstants.statement,
              context.viewportSize,
            ),
          ),
          children: [
            TextSpan(
              text: "Engineering ",
              style: TextStyle(
                color: TextColorConstants.light,
                fontWeight: TextWeightConstants.regular,
              ),
            ),
            TextSpan(
              text: "software products ",
              style: TextStyle(
                color: ColorPaletteConstants.tertiary,
                fontWeight: TextWeightConstants.black,
              ),
            ),
            TextSpan(
              text: "for scale and impact.",
              style: TextStyle(
                color: TextColorConstants.light,
                fontWeight: TextWeightConstants.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
