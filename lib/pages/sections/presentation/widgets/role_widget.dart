import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/effects/outlined_text.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';

class RoleWidget extends StatefulWidget {
  const RoleWidget({super.key});

  @override
  State<RoleWidget> createState() => _RoleWidgetState();
}

class _RoleWidgetState extends State<RoleWidget> {
  double get _fontSize => min(MediaQuery.of(context).size.width * 0.25, 200);

  @override
  Widget build(BuildContext context) {
    return AnimatedTranslation(
      origin: .fromRight,
      child: CustomColumn(
        spacing: 0.0,
        children: [
          Text(
            "MOBILE",
            style: TextStyle(
              height: 0.8,
              fontFamily:  TextFamilyConstants.primary,
              color: TextColorConstants.light,
              fontSize: _fontSize,
              fontWeight: TextWeightConstants.bold,
            ),
          ),
          OutlinedText(
            text: "ENGINEER",
            height: 0.8,
            fontFamily:  TextFamilyConstants.primary,
            fillColor: Colors.transparent,
            strokeColor: ColorPaletteConstants.tertiary,
            strokeWidth: 1,
            fontSize: _fontSize,
            fontWeight: TextWeightConstants.black,
          ),
        ],
      ),
    );
  }
}
