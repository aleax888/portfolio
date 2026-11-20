import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/domain/education/certifications/anthropic_certification_enum.dart';
import 'package:portfolio/domain/education/certifications/platzi_certification_enum.dart';
import 'package:portfolio/domain/education/certifications/uni_certification_enum.dart';
import 'package:portfolio/domain/education/education_enum.dart';
import 'package:portfolio/pages/sections/education/widgets/amount_label_container.dart';
import 'package:portfolio/pages/widgets/education_element.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';
import 'package:portfolio/widgets/content/section_title.dart';
import 'package:portfolio/widgets/effects/outlined_text.dart';
import 'package:portfolio/widgets/layout/adaptive_dashboard_layout.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';
import 'package:portfolio/widgets/layout/custom_container.dart';

final class EducationSection extends StatelessWidget {
  final ScrollController scrollController;
  const EducationSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final dashboard = AdaptiveDashboardLayout(
      scrollController: scrollController,
      a: CustomContainer(
        child: LayoutBuilder(
          builder: (context, constraints) => FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: constraints.maxWidth,
              child: CustomColumn(
                spacing: SpacingConstants.m,
                children: [
                  // University -------------------------------------------------------
                  Text(
                    'University education',
                    style: TextStyle(
                      color: TextColorConstants.light,
                      fontSize: ResponsiveFontSize.logarithmic(
                        TextSizeConstants.xl,
                        context.viewportSize,
                        minScale: 0.65,
                      ),
                      fontFamily: TextFamilyConstants.secondary,
                      fontWeight: TextWeightConstants.bold,
                    ),
                  ),

                  // Education elements -------------------------------------------------------
                  for (final item in EducationEnum.values) ...[
                    if (item != EducationEnum.values.first)
                      Divider(
                        color: BasicColorConstants.gray,
                        height: SpacingConstants.xs,
                        indent: SpacingConstants.l,
                        endIndent: SpacingConstants.l,
                      ),
                    EducationElement(data: item),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      // Hook -------------------------------------------------------
      b: CustomContainer(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: OutlinedText(
            text: "HELLO",
            height: 0.7,
            strokeColor: TextColorConstants.light,
            strokeWidth: 1,
            fillColor: Colors.transparent,
            fontSize: ResponsiveFontSize.linear(100, context.viewportSize),
            fontWeight: TextWeightConstants.black,
            fontFamily: TextFamilyConstants.primary,
          ),
        ),
      ),
      // Hook -------------------------------------------------------
      c: CustomContainer(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: OutlinedText(
            text: "WORLD!",
            height: 0.7,
            strokeColor: TextColorConstants.light,
            strokeWidth: 1,
            fillColor: Colors.transparent,
            fontSize: ResponsiveFontSize.linear(100, context.viewportSize),
            fontWeight: TextWeightConstants.black,
            fontFamily: TextFamilyConstants.primary,
          ),
        ),
      ),
      // English level -------------------------------------------------------
      d: AmountLabelContainer(amount: "B2", label: "English"),
      // Certifications -------------------------------------------------------
      e: AmountLabelContainer(
        amount:
            (AnthropicCertificationEnum.values.length +
                    PlatziCertificationEnum.values.length +
                    UniCertificationEnum.values.length)
                .toString(),
        label: "Certifications",
      ),
      // Days of coding -------------------------------------------------------
      f: AmountLabelContainer(
        amount: DateTime.now().difference(DateTime(2018)).inDays.toString(),
        label: "Days of coding",
      ),
      // Hook -------------------------------------------------------
      g: AmountLabelContainer(amount: "AI", label: "Entusiast"),
    );
    return Center(
      child: CustomConstrain(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              spacing: SpacingConstants.m,
              crossAxisAlignment: .stretch,
              children: [
                SectionTitle(
                  index: 4,
                  scrollController: scrollController,
                  title: 'EDUCATION',
                ),
                if (constraints.hasBoundedHeight)
                  Expanded(child: dashboard)
                else
                  dashboard,
              ],
            );
          },
        ),
      ),
    );
  }
}
