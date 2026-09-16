import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/domain/education/certifications/certification_item.dart';
import 'package:portfolio/widgets/animation/pressable_widget.dart';

class CertificationElement extends StatelessWidget {
  final CertificationItem data;
  const CertificationElement({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return PressableWidget(
      onTap: () {
        // TODO: Implement URL launch
      },
      child: Row(
        spacing: SpacingConstants.s,
        children: [
          Expanded(
            child: Text(
              data.name,
              overflow: .ellipsis,
              style: TextStyle(
                fontFamily: TextFamilyConstants.secondary,
                color: TextColorConstants.light,
                fontSize: TextSizeConstants.m,
                fontWeight: TextWeightConstants.regular,
              ),
            ),
          ),
          if (data.duration != null)
            Text(
              data.duration!,
              style: TextStyle(
                fontFamily: TextFamilyConstants.secondary,
                color: ColorPaletteConstants.tertiary,
                fontSize: TextSizeConstants.m,
                fontWeight: TextWeightConstants.bold,
              ),
            ),
        ],
      ),
    );
  }
}
