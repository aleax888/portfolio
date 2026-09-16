import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/border_constants.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/domain/experience/experience_enum.dart';
import 'package:portfolio/widgets/content/tag.dart';

class ExperienceCard extends StatelessWidget {
  final ExperienceEnum data;
  const ExperienceCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: SpacingConstants.l,
      crossAxisAlignment: .end,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                data.begin,
                style: const TextStyle(
                  fontFamily: TextFamilyConstants.primary,
                  color: ColorPaletteConstants.tertiary,
                  fontSize: TextSizeConstants.l,
                  fontWeight: TextWeightConstants.extraBold,
                ),
              ),
              Text(
                data.end,
                style: const TextStyle(
                  fontFamily: TextFamilyConstants.primary,
                  color: ColorPaletteConstants.tertiary,
                  fontSize: TextSizeConstants.l,
                  fontWeight: TextWeightConstants.extraBold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: const TextStyle(
                  fontFamily: TextFamilyConstants.secondary,
                  fontStyle: .italic,
                  color: TextColorConstants.light,
                  fontSize: TextSizeConstants.l,
                  fontWeight: TextWeightConstants.regular,
                ),
              ),
              SizedBox(height: SpacingConstants.s),
              CustomTag(
                text: data.position,
                color: ColorPaletteConstants.quinary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(BorderRadiusConstants.xl),
                ),
              ),
              SizedBox(height: SpacingConstants.l),
              Text(
                data.description,
                style: const TextStyle(
                  fontFamily: TextFamilyConstants.secondary,
                  color: BasicColorConstants.gray,
                  fontSize: TextSizeConstants.m,
                  fontWeight: TextWeightConstants.regular,
                ),
              ),
              SizedBox(height: SpacingConstants.m),
              Wrap(
                spacing: SpacingConstants.s,
                children: [
                  ...data.technologies.map(
                    (tech) => Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                      child: CustomTag(text: tech),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
