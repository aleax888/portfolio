import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/effects/outlined_text.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';

class ContactMessage extends StatelessWidget {
  final ScrollController scrollController;
  const ContactMessage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveFontSize.logarithmic(
      TextSizeConstants.contactHeadlineMax,
      context.viewportSize,
    );
    return AnimatedTranslation(
      origin: .fromLeft,
      scrollController: scrollController,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: CustomColumn(
            spacing: SpacingConstants.xxs,
            children: [
              Text(
                "LET'S",
                style: TextStyle(
                  height: 0.7,
                  fontFamily: TextFamilyConstants.primary,
                  color: TextColorConstants.light,
                  fontSize: size,
                  fontWeight: TextWeightConstants.regular,
                ),
              ),
              OutlinedText(
                text: "WORK",
                height: 0.7,
                fillColor: Colors.transparent,
                fontFamily: TextFamilyConstants.primary,
                strokeColor: ColorPaletteConstants.tertiary,
                strokeWidth: 1,
                fontSize: size,
                fontWeight: TextWeightConstants.black,
              ),
              Text(
                "TOGETHER",
                style: TextStyle(
                  height: 0.7,
                  fontFamily: TextFamilyConstants.primary,
                  color: TextColorConstants.light,
                  fontSize: size,
                  fontWeight: TextWeightConstants.regular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
