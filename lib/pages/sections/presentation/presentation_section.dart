import 'package:flutter/material.dart';
import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/pages/sections/presentation/widgets/message_widget.dart';
import 'package:portfolio/pages/sections/presentation/widgets/name_widget.dart';
import 'package:portfolio/pages/sections/presentation/widgets/photo_widget.dart';
import 'package:portfolio/pages/sections/presentation/widgets/role_widget.dart';
import 'package:portfolio/widgets/animation/marquee_text.dart';
import 'package:portfolio/widgets/content/split_view.dart';
import 'package:portfolio/widgets/effects/opacity_gradient.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';

class PresentationSection extends StatelessWidget {
  const PresentationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Marquee -------------------------------------------------------
        Positioned.fill(
          child: ExcludeSemantics(
            child: OpacityGradient(
              child: MarqueeText(
                startOffsetFraction: 0,
                text: 'ALEX MAGLIO NEYRA HERRADA',
                style: TextStyle(
                  color: TextColorConstants.light,
                  fontSize: ResponsiveFontSize.linear(
                    600,
                    context.viewportSize,
                  ),
                  fontFamily: TextFamilyConstants.primary,
                  fontWeight: TextWeightConstants.bold,
                ),
              ),
            ),
          ),
        ),

        // Content -------------------------------------------------------
        Center(
          child: CustomConstrain(
            child: SplitView(
              split: 0.7,
              expandBottom: true,
              left: const CustomColumn(
                spacing: SpacingConstants.xs,
                children: [
                  // My name -------------------------------------------------------
                  NameWidget(),
                  // Job role -------------------------------------------------------
                  RoleWidget(),
                  // Message -------------------------------------------------------
                  MessageWidget(),
                ],
              ),

              // Photo -------------------------------------------------------
              right: const PhotoWidget(),
            ),
          ),
        ),
      ],
    );
  }
}
