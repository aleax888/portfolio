import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/border_constants.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';

class CustomTag extends StatelessWidget {
  final String text;
  final Color color;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsets padding;
  const CustomTag({
    super.key,
    required this.text,
    this.color = ColorPaletteConstants.secondary,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(BorderRadiusConstants.xs),
    ),
    this.padding = const EdgeInsets.symmetric(
      horizontal: SpacingConstants.m,
      vertical: SpacingConstants.xs,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).size.width > 700
          ? padding
          : EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(51),
        border: Border.all(color: color, width: BorderWidthConstants.xxs),
        borderRadius: MediaQuery.of(context).size.width > 700
            ? borderRadius
            : BorderRadius.all(Radius.circular(BorderRadiusConstants.s)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: TextFamilyConstants.secondary,
          color: color,
          fontSize: TextSizeConstants.xs,
          fontWeight: TextWeightConstants.bold,
        ),
      ),
    );
  }
}
