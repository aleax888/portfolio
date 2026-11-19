import 'dart:math';

import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/layout_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/pages/sections/presentation/widgets/message_widget.dart';
import 'package:portfolio/pages/sections/presentation/widgets/name_widget.dart';
import 'package:portfolio/pages/sections/presentation/widgets/photo_widget.dart';
import 'package:portfolio/pages/sections/presentation/widgets/role_widget.dart';
import 'package:portfolio/widgets/animation/marquee_text.dart';
import 'package:portfolio/widgets/layout/custom_appbar/custom_app_bar.dart';
import 'package:portfolio/widgets/content/split_view.dart';
import 'package:portfolio/widgets/effects/opacity_gradient.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';

class PresentationSection extends StatelessWidget {
  const PresentationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.viewportSize.height;
    return Stack(
      children: [
        Positioned.fill(
          child: ExcludeSemantics(
            child: OpacityGradient(
              child: MarqueeText(
                startOffsetFraction: 0,
                text: 'ALEX MAGLIO NEYRA HERRADA',
                style: TextStyle(
                  fontFamily: TextFamilyConstants.primary,
                  color: TextColorConstants.light,
                  fontSize: ResponsiveFontSize.linear(
                    TextSizeConstants.marquee,
                    context.viewportSize,
                  ),
                  fontWeight: TextWeightConstants.bold,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: CustomConstrain(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                SpacingConstants.m,
                AdaptivePortfolioAppBar.defaultHeight,
                SpacingConstants.m,
                SpacingConstants.xs,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final breakpoint = height < LayoutConstants.minSectionHeight
                      ? LayoutConstants.compactSplitWidth
                      : LayoutConstants.splitWidth;
                  final stacked = constraints.maxWidth < breakpoint;
                  return SplitView(
                    split: LayoutConstants.presentationSplit,
                    breakpoint: breakpoint,
                    left: const CustomColumn(
                      spacing: SpacingConstants.xs,
                      children: [NameWidget(), RoleWidget(), MessageWidget()],
                    ),
                    right: SizedBox(
                      height: min(
                        height *
                            (stacked
                                ? LayoutConstants.portraitStackedFraction
                                : LayoutConstants.portraitSideFraction),
                        LayoutConstants.portraitMaxHeight,
                      ),
                      child: const PhotoWidget(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
