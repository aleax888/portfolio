import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_reveal.dart';

class ExperienceMessageWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ExperienceMessageWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      scrollController: scrollController,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: TextFamilyConstants.secondary,
            fontStyle: .italic,
          ),
          children: [
            TextSpan(
              text: "Engineering ",
              style: TextStyle(
                color: TextColorConstants.light,
                fontSize: 60,
                fontWeight: TextWeightConstants.regular,
              ),
            ),
            TextSpan(
              text: "mobile products ",
              style: TextStyle(
                color: ColorPaletteConstants.tertiary,
                fontSize: 60,
                fontWeight: TextWeightConstants.black,
              ),
            ),
            TextSpan(
              text: "for scale and impact.",
              style: TextStyle(
                color: TextColorConstants.light,
                fontSize: 60,
                fontWeight: TextWeightConstants.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
