import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/layout_constants.dart';
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
  final Axis axis;

  const ProjectCard({
    super.key,
    this.imagePath = 'assets/images/debug/work_in_progress.png',
    this.axis = Axis.horizontal,
    required this.title,
    required this.description,
    required this.techStack,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return PressableWidget(
      onTap: () =>
          launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication),
      child: CustomContainer(
        padding: EdgeInsets.zero,
        hoverColor: ColorPaletteConstants.quinary,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(BorderRadiusConstants.xl),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final image = AspectRatio(
                aspectRatio: 1.6,
                child: Image.asset(imagePath, fit: BoxFit.cover),
              );
              final content = Padding(
                padding: const EdgeInsets.all(SpacingConstants.s),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: SpacingConstants.xs,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: TextFamilyConstants.secondary,
                        color: TextColorConstants.light,
                        fontWeight: TextWeightConstants.bold,
                        fontSize: ResponsiveFontSize.logarithmic(
                          TextSizeConstants.xl,
                          context.viewportSize,
                          minScale: 0.7,
                        ),
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontFamily: TextFamilyConstants.secondary,
                        color: BasicColorConstants.gray,
                        fontSize: TextSizeConstants.s,
                      ),
                    ),
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
              if (axis == Axis.horizontal &&
                  constraints.maxWidth >= LayoutConstants.compactSplitWidth) {
                return Row(
                  children: [
                    Expanded(flex: 2, child: image),
                    Expanded(flex: 3, child: content),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [image, content],
              );
            },
          ),
        ),
      ),
    );
  }
}
