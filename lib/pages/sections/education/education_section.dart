import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/domain/education/certifications/anthropic_certification_enum.dart';
import 'package:portfolio/domain/education/certifications/platzi_certification_enum.dart';
import 'package:portfolio/domain/education/certifications/uni_certification_enum.dart';
import 'package:portfolio/domain/education/education_enum.dart';
import 'package:portfolio/pages/sections/education/widgets/amount_label_container.dart';
import 'package:portfolio/pages/widgets/education_element.dart';
import 'package:portfolio/widgets/content/full_screen_section.dart';
import 'package:portfolio/widgets/content/section_title.dart';
import 'package:portfolio/widgets/effects/outlined_text.dart';
import 'package:portfolio/widgets/layout/adaptive_dashboard_layout.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';
import 'package:portfolio/widgets/layout/custom_container.dart';

class EducationSection extends StatelessWidget {
  final ScrollController scrollController;
  const EducationSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return FullScreenSection(
      minHeight: MediaQuery.of(context).size.width < 1200
          ? MediaQuery.of(context).size.height * 2.5
          : 1000,
      child: CustomColumn(
        children: [
          SectionTitle(
            index: 4,
            scrollController: scrollController,
            title: 'EDUCATION',
          ),
          Expanded(
            child: AdaptiveDashboardLayout(
              scrollController: scrollController,
              a: CustomContainer(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: CustomColumn(
                    spacing: SpacingConstants.l,
                    children: [
                      Text(
                        'University education',
                        style: TextStyle(
                          fontFamily: TextFamilyConstants.secondary,
                          color: TextColorConstants.light,
                          fontSize: TextSizeConstants.xl,
                          fontWeight: TextWeightConstants.bold,
                        ),
                      ),

                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: EducationEnum.values.length,
                        itemBuilder: (context, index) =>
                            EducationElement(data: EducationEnum.values[index]),
                        separatorBuilder: (context, index) => Divider(
                          color: BasicColorConstants.gray,
                          height: SpacingConstants.xl,
                          indent: SpacingConstants.l,
                          endIndent: SpacingConstants.l,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              b: CustomContainer(
                padding: EdgeInsetsGeometry.zero,
                child: Center(
                  child: OutlinedText(
                    text: "HELLO",
                    height: 0.7,
                    fillColor: Colors.transparent,
                    fontFamily: TextFamilyConstants.primary,
                    strokeColor: TextColorConstants.light,
                    strokeWidth: 1,
                    fontSize: 110,
                    fontWeight: TextWeightConstants.black,
                  ),
                ),
              ),
              c: CustomContainer(
                padding: EdgeInsetsGeometry.zero,
                child: Center(
                  child: OutlinedText(
                    text: "WORLD!",
                    height: 0.7,
                    fillColor: Colors.transparent,
                    fontFamily: TextFamilyConstants.primary,
                    strokeColor: TextColorConstants.light,
                    strokeWidth: 1,
                    fontSize: 110,
                    fontWeight: TextWeightConstants.black,
                  ),
                ),
              ),
              d: AmountLabelContainer(amount: "B2", label: "English"),
              // e: CertificationCard(data: AnthropicCertificationEnum.values),
              // f: CertificationCard(data: PlatziCertificationEnum.values),
              // g: CertificationCard(data: UniCertificationEnum.values),
              e: AmountLabelContainer(
                amount:
                    (AnthropicCertificationEnum.values.length +
                            PlatziCertificationEnum.values.length +
                            UniCertificationEnum.values.length)
                        .toString(),
                label: "Certifications",
              ),
              f: AmountLabelContainer(
                amount: DateTime.now()
                    .difference(DateTime(2018))
                    .inDays
                    .toString(),
                label: "Days of coding",
              ),
              g: AmountLabelContainer(amount: "AI", label: "Entusiast"),
            ),
          ),
        ],
      ),
    );
  }
}
