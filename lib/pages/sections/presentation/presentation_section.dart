import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/pages/sections/presentation/widgets/message_widget.dart';
import 'package:portfolio/pages/sections/presentation/widgets/name_widget.dart';
import 'package:portfolio/pages/sections/presentation/widgets/photo_widget.dart';
import 'package:portfolio/pages/sections/presentation/widgets/role_widget.dart';
import 'package:portfolio/widgets/animation/marquee_text.dart';
import 'package:portfolio/widgets/content/full_screen_section.dart';
import 'package:portfolio/widgets/content/split_view.dart';
import 'package:portfolio/widgets/effects/opacity_gradient.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';

class PresentationSection extends StatefulWidget {
  const PresentationSection({super.key});

  @override
  State<PresentationSection> createState() => _PresentationSectionState();
}

class _PresentationSectionState extends State<PresentationSection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: OpacityGradient(
            child: MarqueeText(
              startOffsetFraction: 0.0,
              text: "ALEX MAGLIO NEYRA HERRADA",
              style: TextStyle(
                fontFamily: TextFamilyConstants.primary,
                color: TextColorConstants.light,
                fontSize: max(500, MediaQuery.of(context).size.height * 0.7),
                fontWeight: TextWeightConstants.bold,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: .center,
          children: [
            CustomConstrain(
              child: FullScreenSection(
                padding: const EdgeInsets.all(SpacingConstants.xl),
                minHeight: 1000,
                child: SplitView(
                  split: 0.7,
                  breakpoint: 900,
                  left: CustomColumn(
                    children: [NameWidget(), RoleWidget(), MessageWidget()],
                  ),
                  right: PhotoWidget(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
