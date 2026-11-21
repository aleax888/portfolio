import 'package:portfolio/widgets/scroll_driven/section_activity.dart';
import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/domain/tech_stack/complementary_stack_enum.dart';
import 'package:portfolio/domain/tech_stack/dev_stack_enum.dart';
import 'package:portfolio/domain/tech_stack/flutter_stack_enum.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';
import 'package:portfolio/pages/sections/stack/ai_vs_human/ai_vs_human_split_screen.dart';
import 'package:portfolio/widgets/animation/flip_card.dart';
import 'package:portfolio/widgets/content/section_title.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_slider.dart';

class TechStackSlider extends StatelessWidget {
  final ScrollController scrollController;
  const TechStackSlider({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title -------------------------------------------------------
        Center(
          child: CustomConstrain(
            child: Align(
              alignment: .centerLeft,
              child: SectionTitle(
                index: 2,
                scrollController: scrollController,
                title: 'SKILLS',
              ),
            ),
          ),
        ),
        Column(
          spacing: SpacingConstants.m,
          children: [
            // Stack Sliders -------------------------------------------------------
            ...const <List<TechStackItem>>[
              FlutterStackEnum.values,
              DevStackEnum.values,
              ComplementaryStackEnum.values,
              // AIStackEnum.values,
            ].asMap().entries.map(
              (stack) => ScrollDrivenSlider(
                direction: stack.key % 2 == 0 ? .toLeft : .toRight,
                scrollController: scrollController,
                itemSize: ResponsiveFontSize.exponential(
                  300,
                  context.viewportSize,
                ),
                itemSpacing: SpacingConstants.m,
                items: stack.value
                    .map(
                      (e) => FlipCard(
                        front: SectionActivity.assetsReady(context)
                            ? Image.asset(e.image)
                            : const SizedBox.shrink(),
                        back: FittedBox(
                          child: Center(
                            child: Text(
                              e.name,
                              style: const TextStyle(
                                color: TextColorConstants.light,
                                fontSize: TextSizeConstants.m,
                                fontFamily: TextFamilyConstants.secondary,
                                fontWeight: TextWeightConstants.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            // AI vs Human -------------------------------------------------------
            AiVsHumanSplitScreen(scrollController: scrollController),
          ],
        ),
      ],
    );
  }
}
