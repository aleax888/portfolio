import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTranslation(
      origin: .fromLeft,
      child: Text(
        "Arequipa, Perú (UTC-5)",
        style: TextStyle(
          height: 0.8,
          fontFamily:  TextFamilyConstants.primary,
          color: TextColorConstants.light,
          fontSize: TextSizeConstants.m,
          fontWeight: TextWeightConstants.regular,
        ),
      ),
    );
  }
}
