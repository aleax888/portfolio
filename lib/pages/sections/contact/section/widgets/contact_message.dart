import 'dart:math';

import 'package:flutter/material.dart';
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
    final size = min(MediaQuery.of(context).size.width * 0.25, 150).toDouble();
    return AnimatedTranslation(
      origin: .fromLeft,
      scrollController: scrollController,
      child: CustomColumn(
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
    );
  }
}
