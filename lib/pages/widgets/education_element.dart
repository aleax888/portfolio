import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/domain/education/education_enum.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';

class EducationElement extends StatelessWidget {
  final EducationEnum data;
  const EducationElement({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .start,
      mainAxisAlignment: .center,
      spacing: SpacingConstants.l,
      children: [
        Image.asset(
          data.logo,
          semanticLabel: data.fullName,
          width: 80,
          height: 80,
        ),
        Expanded(
          child: CustomColumn(
            spacing: SpacingConstants.s,
            children: [
              CustomColumn(
                children: [
                  Text(
                    data.degree,
                    style: TextStyle(
                      height: 0.95,
                      color: TextColorConstants.light,
                      fontWeight: TextWeightConstants.bold,
                      fontSize: TextSizeConstants.l,
                    ),
                  ),
                  Text(
                    data.description,
                    style: TextStyle(
                      height: 0.95,
                      color: BasicColorConstants.gray,
                      fontWeight: TextWeightConstants.regular,
                      fontSize: TextSizeConstants.m,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: .end,
                children: [
                  Text(
                    data.period,
                    style: TextStyle(
                      color: ColorPaletteConstants.secondary,
                      fontWeight: TextWeightConstants.bold,
                      fontSize: TextSizeConstants.s,
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
