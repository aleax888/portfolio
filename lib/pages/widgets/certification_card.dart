import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/domain/education/certifications/certification_item.dart';
import 'package:portfolio/pages/widgets/certification_element.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';
import 'package:portfolio/widgets/layout/custom_container.dart';

class CertificationCard extends StatelessWidget {
  final List<CertificationItem> data;
  const CertificationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: CustomColumn(
        spacing: SpacingConstants.s,
        children: [
          Text(
            data.first.issuedBy,
            style: TextStyle(
              fontFamily: TextFamilyConstants.secondary,
              color: ColorPaletteConstants.quinary,
              fontSize: TextSizeConstants.m,
              fontWeight: TextWeightConstants.regular,
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: data.length,
              itemBuilder: (context, index) =>
                  CertificationElement(data: data[index]),
              separatorBuilder: (context, index) => Divider(
                color: BasicColorConstants.gray,
                height: SpacingConstants.s,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
