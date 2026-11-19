import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTranslation(
      origin: .fromLeft,
      child: FittedBox(
        child: Text.rich(
          TextSpan(
            style: TextStyle(
              wordSpacing: ResponsiveFontSize.linear(10, context.viewportSize),
              color: ColorPaletteConstants.quinary,
              fontSize: ResponsiveFontSize.logarithmic(
                30,
                context.viewportSize,
              ),
              fontFamily: TextFamilyConstants.secondary,
            ),
            children: [
              TextSpan(
                text: "--- ALEX MAGLIO ",
                style: TextStyle(fontWeight: TextWeightConstants.medium),
              ),
              TextSpan(
                text: "NEYRA HERRADA",
                style: TextStyle(fontWeight: TextWeightConstants.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
