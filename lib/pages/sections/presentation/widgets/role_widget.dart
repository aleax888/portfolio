import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/effects/outlined_text.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';

class RoleWidget extends StatelessWidget {
  const RoleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveFontSize.logarithmic(
      TextSizeConstants.heroMax,
      context.viewportSize,
    );
    return AnimatedTranslation(
      origin: .fromRight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: CustomColumn(
            spacing: 0.0,
            children: [
              Text(
                "SOFTWARE",
                style: TextStyle(
                  height: 0.8,
                  fontFamily: TextFamilyConstants.primary,
                  color: TextColorConstants.light,
                  fontSize: size,
                  fontWeight: TextWeightConstants.bold,
                ),
              ),
              OutlinedText(
                text: "ENGINEER",
                height: 0.8,
                fontFamily: TextFamilyConstants.primary,
                fillColor: Colors.transparent,
                strokeColor: ColorPaletteConstants.tertiary,
                strokeWidth: 1,
                fontSize: size,
                fontWeight: TextWeightConstants.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
