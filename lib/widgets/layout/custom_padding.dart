import 'dart:math';

import 'package:flutter/material.dart';
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
          MediaQuery.of(context).size.width * 0.05,
          horizontalPadding!,
        ),
        vertical: min(
          MediaQuery.of(context).size.height * 0.05,
          verticalPadding!,
        ),
      ),
      child: child,
    );
  }
}
