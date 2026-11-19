import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';

class AmountLabel extends StatelessWidget {
  final String amount;
  final String label;
  final TextStyle amountLabel;
  final TextStyle labelStyle;
  const AmountLabel({
    super.key,
    required this.amount,
    required this.label,
    this.amountLabel = const TextStyle(
      fontFamily: TextFamilyConstants.primary,
      color: ColorPaletteConstants.tertiary,
      fontSize: TextSizeConstants.statistic,
      fontWeight: TextWeightConstants.black,
    ),
    this.labelStyle = const TextStyle(
      fontFamily: TextFamilyConstants.secondary,
      color: TextColorConstants.light,
      fontSize: TextSizeConstants.l,
      fontWeight: TextWeightConstants.bold,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        // Amount -------------------------------------------------------
        Text(
          amount,
          style: amountLabel.copyWith(
            fontSize: ResponsiveFontSize.logarithmic(
              amountLabel.fontSize!,
              context.viewportSize,
              minScale: 0.8,
            ),
          ),
        ),

        // Label -------------------------------------------------------
        Text(
          label,
          style: labelStyle.copyWith(
            fontSize: ResponsiveFontSize.logarithmic(
              labelStyle.fontSize!,
              context.viewportSize,
              minScale: 0.8,
            ),
          ),
        ),
      ],
    );
  }
}
