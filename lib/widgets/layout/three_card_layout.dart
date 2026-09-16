import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';

class ThreeCardLayout extends StatelessWidget {
  final Widget left;
  final Widget topRight;
  final Widget bottomRight;
  final double spacing;

  const ThreeCardLayout({
    super.key,
    required this.left,
    required this.topRight,
    required this.bottomRight,
    this.spacing = SpacingConstants.xs,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint móvil
        if (constraints.maxWidth < 768) {
          return Column(
            spacing: spacing,
            children: [
              Expanded(child: left),
              Expanded(child: topRight),
              Expanded(child: bottomRight),
            ],
          );
        }

        return Row(
          spacing: spacing,
          children: [
            Expanded(flex: 3, child: left),
            Expanded(
              flex: 4,
              child: Column(
                spacing: spacing,
                children: [
                  Expanded(child: topRight),
                  Expanded(child: bottomRight),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
