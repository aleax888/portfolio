import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/domain/experience/experience_enum.dart';
import 'package:portfolio/pages/sections/experience/section/widgets/amount_label.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/layout/custom_container.dart';

class ExperienceDataPanel extends StatelessWidget {
  final ScrollController scrollController;
  const ExperienceDataPanel({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return AnimatedTranslation(
      origin: .fromRight,
      scrollController: scrollController,
      child: CustomContainer(
        padding: EdgeInsetsGeometry.symmetric(
          vertical: SpacingConstants.xxl,
          horizontal: SpacingConstants.xl,
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            AmountLabel(
              amount:
                  '+${ExperienceEnum.values.map((e) => e.durationInMonths).reduce((a, b) => a + b) ~/ 12}',
              label: 'Productive years',
            ),
            AmountLabel(
              amount: '${ExperienceEnum.values.length}',
              label: 'Professional roles',
            ),
            AmountLabel(amount: '2', label: 'Published apps'),
            AmountLabel(amount: '∞', label: 'Lines of code written'),
          ],
        ),
      ),
    );
  }
}
