import 'package:flutter/material.dart';
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
      fontSize: 80,
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
        Text(amount, style: amountLabel),
        Text(label, style: labelStyle),
      ],
    );
  }
}
