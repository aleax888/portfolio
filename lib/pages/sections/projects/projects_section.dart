import 'package:flutter/material.dart';
import 'package:portfolio/domain/projects/project_enum.dart';
import 'package:portfolio/pages/widgets/project_card.dart';
import 'package:portfolio/widgets/content/full_screen_section.dart';
import 'package:portfolio/widgets/content/section_title.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';
import 'package:portfolio/widgets/layout/three_card_layout.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_reveal.dart';

class ProjectsSection extends StatelessWidget {
  final ScrollController scrollController;
  const ProjectsSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return FullScreenSection(
      child: ScrollReveal(
        scrollController: scrollController,
        child: CustomColumn(
          children: [
            SectionTitle(
              index: 3,
              scrollController: scrollController,
              title: 'MY PROJECTS',
            ),
            Expanded(
              child: ThreeCardLayout(
                left: ProjectCard(
                  imagePath: ProjectEnum.gymFlow.image,
                  axis: Axis.vertical,
                  title: ProjectEnum.gymFlow.name,
                  description: ProjectEnum.gymFlow.description,
                  techStack: ProjectEnum.gymFlow.technologies,
                  link: ProjectEnum.gymFlow.link,
                ),
                topRight: ProjectCard(
                  imagePath: ProjectEnum.ledPanel.image,
                  title: ProjectEnum.ledPanel.name,
                  description: ProjectEnum.ledPanel.description,
                  techStack: ProjectEnum.ledPanel.technologies,
                  link: ProjectEnum.ledPanel.link,
                ),
                bottomRight: ProjectCard(
                  imagePath: ProjectEnum.imgToTextArt.image,
                  title: ProjectEnum.imgToTextArt.name,
                  description: ProjectEnum.imgToTextArt.description,
                  techStack: ProjectEnum.imgToTextArt.technologies,
                  link: ProjectEnum.imgToTextArt.link,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
