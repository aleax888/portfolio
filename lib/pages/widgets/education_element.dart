import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/layout_constants.dart';
import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final logoSize =
            constraints.maxWidth < LayoutConstants.compactSplitWidth
            ? LayoutConstants.compactLogoSize
            : LayoutConstants.logoSize;
        return Row(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          spacing: SpacingConstants.s,
          children: [
            Image.asset(
              data.logo,
              semanticLabel: data.fullName,
              width: logoSize,
              height: logoSize,
            ),
            Expanded(
              child: CustomColumn(
                spacing: SpacingConstants.xs,
                children: [
                  CustomColumn(
                    spacing: SpacingConstants.xxs,
                    children: [
                      Text(
                        data.degree,
                        style: TextStyle(
                          height: 0.95,
                          color: TextColorConstants.light,
                          fontWeight: TextWeightConstants.bold,
                          fontSize: ResponsiveFontSize.logarithmic(
                            TextSizeConstants.l,
                            context.viewportSize,
                            minScale: 0.72,
                          ),
                        ),
                      ),
                      Text(
                        data.description,
                        style: TextStyle(
                          height: 0.95,
                          color: BasicColorConstants.gray,
                          fontWeight: TextWeightConstants.regular,
                          fontSize: ResponsiveFontSize.logarithmic(
                            TextSizeConstants.m,
                            context.viewportSize,
                            minScale: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      data.period,
                      style: TextStyle(
                        color: ColorPaletteConstants.secondary,
                        fontWeight: TextWeightConstants.bold,
                        fontSize: TextSizeConstants.s,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
