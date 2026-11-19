import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/effects/outlined_text.dart';

class RoleWidget extends StatelessWidget {
  const RoleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final fontSize = ResponsiveFontSize.logarithmic(200, context.viewportSize);
    return AnimatedTranslation(
      origin: .fromRight,
      child: FittedBox(
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Text(
              "SOFTWARE",
              style: TextStyle(
                height: 0.8,
                fontSize: fontSize,
                color: TextColorConstants.light,
                fontFamily: TextFamilyConstants.primary,
                fontWeight: TextWeightConstants.bold,
              ),
            ),
            OutlinedText(
              text: "ENGINEER",
              height: 0.8,
              fontSize: fontSize,
              strokeWidth: 1,
              strokeColor: ColorPaletteConstants.tertiary,
              fillColor: Colors.transparent,
              fontFamily: TextFamilyConstants.primary,
              fontWeight: TextWeightConstants.black,
            ),
          ],
        ),
      ),
    );
  }
}
