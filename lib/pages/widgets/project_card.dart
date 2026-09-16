import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/border_constants.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/pressable_widget.dart';
import 'package:portfolio/widgets/content/tag.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';
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
    final isHorizontal = axis == Axis.horizontal;

    final image = Expanded(
      flex: 2,
      child: Image.asset(
        imagePath,
        fit: .cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );

    final content = Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomColumn(
                    spacing: 0.0,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: TextFamilyConstants.secondary,
                          color: TextColorConstants.light,
                          fontSize: max(
                            TextSizeConstants.l,
                            MediaQuery.of(context).size.width * 0.03,
                          ),
                          fontWeight: TextWeightConstants.bold,
                        ),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontFamily: TextFamilyConstants.secondary,
                          color: BasicColorConstants.gray,
                          fontSize: min(
                            TextSizeConstants.l,
                            MediaQuery.of(context).size.width * 0.03,
                          ),
                          fontWeight: TextWeightConstants.regular,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: .start,
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: SpacingConstants.xs,
                          runSpacing: SpacingConstants.xs,
                          alignment: .start,
                          children: techStack
                              .map(
                                (tech) => CustomTag(
                                  text: tech,
                                  color: ColorPaletteConstants.quinary,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final children = [image, content];

    return PressableWidget(
      onTap: () => launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication),
      child: Stack(
        alignment: .bottomEnd,
        children: [
          CustomContainer(
            padding: EdgeInsets.zero,
            hoverColor: ColorPaletteConstants.quinary,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(BorderRadiusConstants.xl),
              ),
              child: isHorizontal
                  ? Row(children: children)
                  : Column(children: children),
            ),
          ),
          // Positioned(
          //   child: Container(
          //     padding: const EdgeInsets.all(SpacingConstants.s),
          //     margin: const EdgeInsets.all(SpacingConstants.s),
          //     decoration: BoxDecoration(
          //       shape: .circle,
          //       border: Border.all(color: ColorPaletteConstants.quinary),
          //     ),
          //     child: Icon(Icons.arrow_right_alt_rounded, color: ColorPaletteConstants.quinary),
          //   ),
          // ),
        ],
      ),
    );
  }
}
