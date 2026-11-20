import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/effects/outlined_text.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';

class ContactMessage extends StatelessWidget {
  final ScrollController scrollController;
  const ContactMessage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final size = ResponsiveFontSize.logarithmic(150, context.viewportSize);
    final style = TextStyle(
      height: 0.7,
      color: TextColorConstants.light,
      fontSize: size,
      fontFamily: TextFamilyConstants.primary,
      fontWeight: TextWeightConstants.regular,
    );
    return AnimatedTranslation(
      origin: .fromLeft,
      scrollController: scrollController,
      child: Align(
        alignment: .centerLeft,
        child: CustomColumn(
          children: [
            Text("LET'S", style: style),
            OutlinedText(
              text: "WORK",
              height: 0.7,
              fillColor: Colors.transparent,
              strokeWidth: 1,
              strokeColor: ColorPaletteConstants.tertiary,
              fontSize: size,
              fontWeight: TextWeightConstants.black,
              fontFamily: TextFamilyConstants.primary,
            ),
            Text("TOGETHER", style: style),
          ],
        ),
      ),
    );
  }
}
