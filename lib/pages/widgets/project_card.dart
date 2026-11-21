import 'package:portfolio/widgets/scroll_driven/section_activity.dart';
import 'package:flutter/material.dart';

import 'package:portfolio/widgets/layout/viewport_orientation_builder.dart';
import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/border_constants.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/pressable_widget.dart';
import 'package:portfolio/widgets/content/tag.dart';
import 'package:portfolio/widgets/layout/custom_container.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final List<String> techStack;
  final String link;
  final Axis? axis;

  const ProjectCard({
    super.key,
    this.imagePath = 'assets/images/debug/work_in_progress.png',
    required this.title,
    required this.description,
    required this.techStack,
    required this.link,
    this.axis,
  });

  @override
  Widget build(BuildContext context) {
    return PressableWidget(
      onTap: () => launchUrl(Uri.parse(link), mode: .externalApplication),
      child: CustomContainer(
        padding: .zero,
        hoverColor: ColorPaletteConstants.quinary,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(BorderRadiusConstants.xl),
          ),
          child: ViewportOrientationBuilder(
            builder: (context, orientation) {
              final image = AspectRatio(
                aspectRatio: 1.6,
                child: SectionActivity.assetsReady(context)
                    ? Image.asset(imagePath, fit: .cover)
                    : const SizedBox.shrink(),
              );
              final content = Padding(
                padding: const EdgeInsets.all(SpacingConstants.m),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: SpacingConstants.s,
                  children: [
                    // Title -------------------------------------------------------
                    Text(
                      title,
                      style: TextStyle(
                        color: TextColorConstants.light,
                        fontSize: ResponsiveFontSize.logarithmic(
                          TextSizeConstants.xl,
                          context.viewportSize,
                          minScale: 0.7,
                        ),
                        fontFamily: TextFamilyConstants.secondary,
                        fontWeight: TextWeightConstants.bold,
                      ),
                    ),

                    // Description -------------------------------------------------------
                    Text(
                      description,
                      style: const TextStyle(
                        color: BasicColorConstants.gray,
                        fontSize: TextSizeConstants.s,
                        fontFamily: TextFamilyConstants.secondary,
                        fontWeight: TextWeightConstants.regular,
                      ),
                    ),

                    // Tech Stack -------------------------------------------------------
                    Wrap(
                      spacing: SpacingConstants.xs,
                      runSpacing: SpacingConstants.xs,
                      children: [
                        for (final tech in techStack)
                          CustomTag(
                            text: tech,
                            color: ColorPaletteConstants.quinary,
                          ),
                      ],
                    ),
                  ],
                ),
              );
              final horizontal = axis == null
                  ? orientation == .landscape
                  : axis == .horizontal;
              if (horizontal) {
                return Row(
                  children: [
                    Expanded(flex: 2, child: image),
                    Expanded(flex: 3, child: content),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: .stretch,
                children: [image, content],
              );
            },
          ),
        ),
      ),
    );
  }
}
