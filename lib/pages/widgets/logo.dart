import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/effects/outlined_text.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "<ALEX",
          style: TextStyle(
            fontFamily: TextFamilyConstants.primary,
            color: ColorPaletteConstants.tertiary,
            fontSize: TextSizeConstants.xxl,
            fontWeight: TextWeightConstants.black,
          ),
        ),
        OutlinedText(
          text: "N/",
          strokeWidth: 0.2,
          fontFamily: TextFamilyConstants.primary,
          strokeColor: ColorPaletteConstants.quinary,
          fontSize: TextSizeConstants.xxl,
          fontWeight: TextWeightConstants.black,
        ),
        Text(
          ">",
          style: TextStyle(
            fontFamily: TextFamilyConstants.primary,
            color: ColorPaletteConstants.tertiary,
            fontSize: TextSizeConstants.xxl,
            fontWeight: TextWeightConstants.black,
          ),
        ),
      ],
    );
  }
}
