import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/domain/experience/experience_enum.dart';
import 'package:portfolio/pages/sections/experience/section/widgets/experience_data_panel.dart';
import 'package:portfolio/pages/sections/experience/section/widgets/experience_message_widget.dart';
import 'package:portfolio/pages/widgets/experience_card.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/content/section_title.dart';
import 'package:portfolio/widgets/content/split_view.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';

class ExperienceSection extends StatelessWidget {
  final ScrollController scrollController;
  const ExperienceSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomConstrain(
        child: CustomColumn(
          children: [
            // Title -------------------------------------------------------
            SectionTitle(
              index: 1,
              scrollController: scrollController,
              title: 'EXPERIENCE',
            ),

            // Content -------------------------------------------------------
            SplitView(
              split: 0.7,
              gap: SpacingConstants.xxl,
              left: CustomColumn(
                spacing: SpacingConstants.l,
                children: [
                  // Hook -------------------------------------------------------
                  ExperienceMessageWidget(scrollController: scrollController),

                  // Experience Cards -------------------------------------------------------
                  Column(
                    spacing: SpacingConstants.xxl,
                    children: ExperienceEnum.values
                        .map(
                          (e) => AnimatedTranslation(
                            origin: .fromLeft,
                            scrollController: scrollController,
                            child: ExperienceCard(data: e),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),

              // Data Panel -------------------------------------------------------
              right: ExperienceDataPanel(scrollController: scrollController),
            ),
          ],
        ),
      ),
    );
  }
}
