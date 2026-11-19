import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/layout_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/helpers/assets/animation_enum.dart';
import 'package:portfolio/pages/sections/experience/animation/widgets/android_widget.dart';
import 'package:portfolio/pages/sections/experience/animation/widgets/cross_platform_message.dart';
import 'package:portfolio/pages/sections/experience/animation/widgets/ios_widget.dart';
import 'package:portfolio/widgets/layout/custom_padding.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_animation.dart';

class CrossPlatformAnimation extends StatelessWidget {
  final ScrollController scrollController;
  const CrossPlatformAnimation({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ScrollDrivenAnimation(
      scrollController: scrollController,
      animationPath: AnimationEnum.iPhone.path,
      child: CustomPadding(
        child: LayoutBuilder(
          builder: (context, constraints) => FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: constraints.maxWidth,
              child: Column(
                spacing:
                    (constraints.maxHeight * LayoutConstants.pageInsetFraction)
                        .clamp(SpacingConstants.xs, SpacingConstants.xl),
                mainAxisAlignment: .center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: IosWidget(scrollController: scrollController),
                    ),
                  ),
                  CrossPlatformMessage(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: AndroidWidget(scrollController: scrollController),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
