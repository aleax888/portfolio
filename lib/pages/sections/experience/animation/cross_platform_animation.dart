import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/helpers/assets/animation_enum.dart';
import 'package:portfolio/pages/sections/experience/animation/widgets/android_widget.dart';
import 'package:portfolio/pages/sections/experience/animation/widgets/cross_platform_message.dart';
import 'package:portfolio/pages/sections/experience/animation/widgets/ios_widget.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_animation.dart';

class CrossPlatformAnimation extends StatelessWidget {
  final ScrollController scrollController;
  const CrossPlatformAnimation({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ScrollDrivenAnimation(
      scrollController: scrollController,
      // Reserve the exported frame range before loading the composition.
      initialFrames: 138.99,
      animationPath: AnimationEnum.iPhone.path,
      child: CustomConstrain(
        child: LayoutBuilder(
          builder: (context, constraints) => FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: constraints.maxWidth,
              child: Column(
                spacing: SpacingConstants.xl,
                mainAxisAlignment: .center,
                mainAxisSize: .min,
                children: [
                  // iOS -------------------------------------------------------
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IosWidget(scrollController: scrollController),
                  ),

                  // Message -------------------------------------------------------
                  CrossPlatformMessage(scrollController: scrollController),

                  // Android -------------------------------------------------------
                  Align(
                    alignment: Alignment.centerRight,
                    child: AndroidWidget(scrollController: scrollController),
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
