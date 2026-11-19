import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/border_constants.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/domain/experience/experience_enum.dart';
import 'package:portfolio/widgets/content/tag.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';

final TextStyle _dateTextStyle = const TextStyle(
  color: ColorPaletteConstants.tertiary,
  fontSize: TextSizeConstants.l,
  fontWeight: TextWeightConstants.extraBold,
  fontFamily: TextFamilyConstants.primary,
);

class ExperienceCard extends StatelessWidget {
  final ExperienceEnum data;
  const ExperienceCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: SpacingConstants.l,
      crossAxisAlignment: .end,
      children: [
        // Duration (Dates) -------------------------------------------------------
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(data.begin, style: _dateTextStyle),
              Text(data.end, style: _dateTextStyle),
            ],
          ),
        ),

        // Experience Details -------------------------------------------------------
        Expanded(
          flex: 8,
          child: CustomColumn(
            children: [
              // Company Name -------------------------------------------------------
              Text(
                data.name,
                style: const TextStyle(
                  color: TextColorConstants.light,
                  fontSize: TextSizeConstants.l,
                  fontWeight: TextWeightConstants.regular,
                  fontFamily: TextFamilyConstants.secondary,
                  fontStyle: .italic,
                ),
              ),

              // Position -------------------------------------------------------
              CustomTag(
                text: data.position,
                color: ColorPaletteConstants.quinary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(BorderRadiusConstants.xl),
                ),
              ),

              // Description -------------------------------------------------------
              Text(
                data.description,
                style: const TextStyle(
                  fontFamily: TextFamilyConstants.secondary,
                  color: BasicColorConstants.gray,
                  fontSize: TextSizeConstants.m,
                  fontWeight: TextWeightConstants.regular,
                ),
              ),

              // Technologies -------------------------------------------------------
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
