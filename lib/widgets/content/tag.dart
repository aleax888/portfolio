import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/layout_constants.dart';
import 'package:portfolio/design_system/extensions/context_extensions.dart';
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
      padding: context.viewportSize.width >= LayoutConstants.tabletWidth
          ? padding
          : const EdgeInsets.symmetric(
              horizontal: SpacingConstants.xxs,
              vertical: SpacingConstants.xxxs,
            ),
      decoration: BoxDecoration(
        color: color.withAlpha(51),
        border: Border.all(color: color, width: BorderWidthConstants.xxs),
        borderRadius: context.viewportSize.width >= LayoutConstants.tabletWidth
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
