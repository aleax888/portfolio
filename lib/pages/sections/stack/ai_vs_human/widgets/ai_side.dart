import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/helpers/assets/images/me_enum.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/layout/custom_padding.dart';

class AiSide extends StatelessWidget {
  final ScrollController scrollController;
  const AiSide({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPaletteConstants.quaternary,
      child: Stack(
        children: [
          CustomPadding(
            child: Row(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: AnimatedTranslation(
                    origin: .fromLeft,
                    scrollController: scrollController,
                    child: Text(
                      'AI-Augmented Software Engineer',
                      style: TextStyle(
                        fontFamily:  TextFamilyConstants.primary,
                        color: ColorPaletteConstants.secondary,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: TextWeightConstants.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Building autonomous AI systems, LLM workflows and intelligent automations.',
                    style: TextStyle(
                      fontFamily: TextFamilyConstants.secondary,
                      color: TextColorConstants.light,
                      fontSize: TextSizeConstants.l,
                      fontWeight: TextWeightConstants.regular,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: AnimatedTranslation(
              origin: .fromBottom,
              scrollController: scrollController,
              child: Align(
                alignment: .bottomCenter,
                child: Image.asset(MeEnum.ai.path),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
