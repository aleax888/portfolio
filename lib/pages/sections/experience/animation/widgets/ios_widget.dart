import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/animated_levitation.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/effects/outlined_text.dart';

class IosWidget extends StatelessWidget {
  final ScrollController scrollController;
  const IosWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return AnimatedTranslation(
      origin: .fromLeft,
      scrollController: scrollController,
      child: AnimatedLevitation(
        child: OutlinedText(
          text: 'iOS',
          fontFamily: TextFamilyConstants.tertiary,
          strokeColor: TextColorConstants.light,
          fontSize: 100,
          fontWeight: TextWeightConstants.bold,
        ),
      ),
    );
  }
}
