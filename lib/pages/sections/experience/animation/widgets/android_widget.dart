import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/animated_levitation.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/effects/outlined_text.dart';

class AndroidWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AndroidWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return AnimatedTranslation(
      origin: .fromRight,
      scrollController: scrollController,
      child: AnimatedLevitation(
        child: OutlinedText(
          text: 'Android',
          strokeWidth: 2,
          strokeColor: ColorPaletteConstants.tertiary,
          fontSize: ResponsiveFontSize.linear(100, context.viewportSize),
          fontWeight: TextWeightConstants.bold,
          fontFamily: TextFamilyConstants.tertiary,
        ),
      ),
    );
  }
}
