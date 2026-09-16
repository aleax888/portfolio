import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/helpers/assets/images/me_enum.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/layout/custom_padding.dart';

class HumanSide extends StatelessWidget {
  final ScrollController scrollController;
  const HumanSide({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPaletteConstants.secondary,
      child: Stack(
        alignment: .centerEnd,
        children: [
          CustomPadding(
            child: Row(
              crossAxisAlignment: .start,
              mainAxisAlignment: .spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: const Text(
                    'Creating fast, intuitive and scalable mobile experiences.',
                    style: TextStyle(
                      fontFamily: TextFamilyConstants.secondary,
                      color: TextColorConstants.light,
                      fontSize: TextSizeConstants.l,
                      fontWeight: TextWeightConstants.regular,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Flexible(flex: 2, child: Container()),
                Flexible(
                  flex: 2,
                  child: AnimatedTranslation(
                    origin: .fromRight,
                    scrollController: scrollController,
                    child: Text(
                      'Mobile Software\nEngineer',
                      style: TextStyle(
                        fontFamily:  TextFamilyConstants.primary,
                        color: ColorPaletteConstants.quaternary,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: TextWeightConstants.black,
                      ),
                      textAlign: TextAlign.end,
                    ),
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
                child: Image.asset(MeEnum.software.path),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
