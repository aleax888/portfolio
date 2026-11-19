import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/layout/custom_container.dart';

class AmountLabelContainer extends StatelessWidget {
  final String amount;
  final String label;
  const AmountLabelContainer({
    super.key,
    required this.amount,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsetsGeometry.zero,
      child: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              amount,
              style: TextStyle(
                height: 0.8,
                fontFamily: TextFamilyConstants.primary,
                color: ColorPaletteConstants.quinary,
                fontSize: ResponsiveFontSize.linear(
                  TextSizeConstants.displayNumber,
                  context.viewportSize,
                ),
                fontWeight: TextWeightConstants.black,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                height: 0.8,
                fontFamily: TextFamilyConstants.secondary,
                color: TextColorConstants.light.withAlpha(150),
                fontSize: ResponsiveFontSize.logarithmic(
                  TextSizeConstants.m,
                  context.viewportSize,
                  minScale: 0.8,
                ),
                fontWeight: TextWeightConstants.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
