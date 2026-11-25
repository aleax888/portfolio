import 'package:flutter/material.dart';
import 'package:portfolio/domain/projects/project_enum.dart';
import 'package:portfolio/pages/widgets/project_card.dart';
import 'package:portfolio/widgets/content/section_title.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';
import 'package:portfolio/widgets/layout/three_card_layout.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_reveal.dart';

class ProjectsSection extends StatelessWidget {
  final ScrollController scrollController;
  const ProjectsSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      scrollController: scrollController,
      child: Center(
        child: CustomConstrain(
          child: CustomColumn(
            children: [
              // Title -------------------------------------------------------
              SectionTitle(
                index: 3,
                scrollController: scrollController,
                title: 'MY PROJECTS',
              ),

              // Projects -------------------------------------------------------
              ThreeCardLayout(
                left: ProjectCard(
                  axis: Axis.vertical,
                  imagePath: ProjectEnum.ledPanel.image,
                  title: ProjectEnum.ledPanel.name,
                  description: ProjectEnum.ledPanel.description,
                  techStack: ProjectEnum.ledPanel.technologies,
                  link: ProjectEnum.ledPanel.link,
                ),
                topRight: ProjectCard(
                  imagePath: ProjectEnum.cvGenerator.image,
                  title: ProjectEnum.cvGenerator.name,
                  description: ProjectEnum.cvGenerator.description,
                  techStack: ProjectEnum.cvGenerator.technologies,
                  link: ProjectEnum.cvGenerator.link,
                ),
                bottomRight: ProjectCard(
                  imagePath: ProjectEnum.textArt.image,
                  title: ProjectEnum.textArt.name,
                  description: ProjectEnum.textArt.description,
                  techStack: ProjectEnum.textArt.technologies,
                  link: ProjectEnum.textArt.link,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
