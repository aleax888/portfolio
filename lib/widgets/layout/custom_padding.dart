import 'dart:math';

import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/layout_constants.dart';
import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';

class CustomPadding extends StatelessWidget {
  final double? horizontalPadding;
  final double? verticalPadding;
  final Widget child;
  const CustomPadding({
    super.key,
    this.horizontalPadding = SpacingConstants.xxl,
    this.verticalPadding = SpacingConstants.xl,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: min(
          context.viewportSize.width * LayoutConstants.pageInsetFraction,
          horizontalPadding!,
        ),
        vertical: min(
          context.viewportSize.height * LayoutConstants.pageInsetFraction,
          verticalPadding!,
        ),
      ),
      child: child,
    );
  }
}
