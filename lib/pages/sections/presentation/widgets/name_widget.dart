import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTranslation(
      origin: .fromLeft,
      child: RichText(
        text: TextSpan(
          style: TextStyle(wordSpacing: 10),
          children: [
            TextSpan(
              text: "--- ALEX MAGLIO ",
              style: TextStyle(
                wordSpacing: 10,
                fontFamily: TextFamilyConstants.secondary,
                color: ColorPaletteConstants.quinary,
                fontSize: TextSizeConstants.m,
                fontWeight: TextWeightConstants.medium,
              ),
            ),
            TextSpan(
              text: "NEYRA HERRADA",
              style: TextStyle(
                fontFamily: TextFamilyConstants.secondary,
                color: ColorPaletteConstants.quinary,
                fontSize: TextSizeConstants.m,
                fontWeight: TextWeightConstants.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
