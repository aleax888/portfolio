import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';

class CrossPlatformMessage extends StatelessWidget {
  const CrossPlatformMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: SpacingConstants.xl,
      children: [
        Column(
          children: [
            Text(
              "Cross-platform specialist",
              textAlign: .center,
              style: TextStyle(
                color: TextColorConstants.light,
                fontSize: TextSizeConstants.xl,
                fontWeight: TextWeightConstants.black,
              ),
            ),
            Text(
              "Ship Faster. Scale Smarter.",
              textAlign: .center,
              style: TextStyle(
                color: ColorPaletteConstants.quinary,
                fontSize: TextSizeConstants.xxl,
                fontWeight: TextWeightConstants.black,
              ),
            ),
          ],
        ),
        Text(
          'Mobile experiences designed for retention, performance and growth.',
          textAlign: .center,
          style: TextStyle(
            color: TextColorConstants.light,
            fontSize: TextSizeConstants.m,
            fontWeight: TextWeightConstants.black,
          ),
        ),
      ],
    );
  }
}
