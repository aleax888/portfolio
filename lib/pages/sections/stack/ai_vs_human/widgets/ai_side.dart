import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
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
          // AI Image ------------------------------------------------------
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

          // Hidden Content ------------------------------------------------------
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              // Title ------------------------------------------------------
              Expanded(
                flex: 2,
                child: AnimatedTranslation(
                  origin: .fromLeft,
                  scrollController: scrollController,
                  child: CustomPadding(
                    child: Text(
                      'AGENTIC-AI',
                      style: TextStyle(
                        fontFamily: TextFamilyConstants.primary,
                        color: ColorPaletteConstants.secondary,
                        fontSize: ResponsiveFontSize.logarithmic(
                          TextSizeConstants.statement,
                          context.viewportSize,
                        ),
                        fontWeight: TextWeightConstants.black,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),

              // AI Hand ------------------------------------------------------
              Expanded(
                flex: 1,
                child: Image.asset(MeEnum.aiHand.path, fit: .scaleDown),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
