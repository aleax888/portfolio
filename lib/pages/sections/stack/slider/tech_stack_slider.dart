import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/domain/tech_stack/complementary_stack_enum.dart';
import 'package:portfolio/domain/tech_stack/dev_stack_enum.dart';
import 'package:portfolio/domain/tech_stack/flutter_stack_enum.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';
import 'package:portfolio/widgets/animation/flip_card.dart';
import 'package:portfolio/widgets/content/section_title.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';
import 'package:portfolio/widgets/layout/custom_padding.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_slider.dart';

class TechStackSlider extends StatelessWidget {
  final ScrollController scrollController;
  const TechStackSlider({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomConstrain(
          child: CustomPadding(
            child: SectionTitle(
              index: 2,
              scrollController: scrollController,
              title: 'SKILLS',
            ),
          ),
        ),
        Column(
          spacing: SpacingConstants.m,
          children: [
            ...const <List<TechStackItem>>[
              FlutterStackEnum.values,
              DevStackEnum.values,
              ComplementaryStackEnum.values,
              // AIStackEnum.values,
            ].asMap().entries.map(
              (stack) => ScrollDrivenSlider(
                direction: stack.key % 2 == 0 ? .toLeft : .toRight,
                scrollController: scrollController,
                itemSize: max(150, MediaQuery.of(context).size.width * 0.15),
                itemSpacing: SpacingConstants.m,
                items: stack.value
                    .map(
                      (e) => FlipCard(
                        front: Image.asset(e.image),
                        back: Center(
                          child: Text(
                            e.name,
                            style: const TextStyle(
                              fontFamily: TextFamilyConstants.secondary,
                              color: TextColorConstants.light,
                              fontSize: TextSizeConstants.m,
                              fontWeight: TextWeightConstants.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
