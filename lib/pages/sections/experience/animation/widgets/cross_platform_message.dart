import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_reveal.dart';

class CrossPlatformMessage extends StatelessWidget {
  final ScrollController scrollController;
  const CrossPlatformMessage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      scrollController: scrollController,
      child: Column(
        spacing: SpacingConstants.xl,
        children: [
          Column(
            children: [
              Text(
                "Cross-platform specialist",
                textAlign: .center,
                style: TextStyle(
                  color: TextColorConstants.light,
                  fontSize: TextSizeConstants.xl,
                  fontWeight: TextWeightConstants.black,
                ),
              ),
              Text(
                "Ship Faster. Scale Smarter.",
                textAlign: .center,
                style: TextStyle(
                  color: ColorPaletteConstants.quinary,
                  fontSize: TextSizeConstants.xxl,
                  fontWeight: TextWeightConstants.black,
                ),
              ),
            ],
          ),
          Text(
            'Mobile experiences designed for retention, performance and growth.',
            textAlign: .center,
            style: TextStyle(
              color: TextColorConstants.gray,
              fontSize: TextSizeConstants.m,
              fontWeight: TextWeightConstants.black,
            ),
          ),
        ],
      ),
    );
  }
}
