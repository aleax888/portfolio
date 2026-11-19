import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/layout_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';

class CustomConstrain extends StatelessWidget {
  final Widget child;
  const CustomConstrain({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingConstants.l,
        vertical: SpacingConstants.xl,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: LayoutConstants.contentWidth,
        ),
        child: child,
      ),
    );
  }
}
