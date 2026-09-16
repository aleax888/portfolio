import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/pages/sections/contact/hook/contact_hook.dart';
import 'package:portfolio/pages/sections/contact/section/contact_section.dart';
import 'package:portfolio/pages/sections/education/education_section.dart';
import 'package:portfolio/pages/sections/experience/animation/cross_platform_animation.dart';
import 'package:portfolio/pages/sections/experience/section/experience_section.dart';
import 'package:portfolio/pages/sections/presentation/presentation_section.dart';
import 'package:portfolio/pages/sections/projects/projects_section.dart';
import 'package:portfolio/pages/sections/stack/ai_vs_human/ai_vs_human_split_screen.dart';
import 'package:portfolio/pages/sections/stack/slider/tech_stack_slider.dart';
import 'package:portfolio/pages/widgets/logo.dart';
import 'package:portfolio/widgets/layout/custom_appbar/custom_app_bar.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';
import 'package:portfolio/widgets/scroll_driven/smooth_scroll_view.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  // Keys de cada sección que querés que sea un "punto de interés"
  final _presentationKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _techStackKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _contactKey = GlobalKey();

  late final List<PortfolioNavItem> _navItems = [
    PortfolioNavItem(label: 'Start', sectionKey: _presentationKey),
    PortfolioNavItem(label: 'Experience', sectionKey: _experienceKey),
    PortfolioNavItem(label: 'Stack', sectionKey: _techStackKey),
    PortfolioNavItem(label: 'Projects', sectionKey: _projectsKey),
    PortfolioNavItem(label: 'Education', sectionKey: _educationKey),
    PortfolioNavItem(label: 'Contact', sectionKey: _contactKey),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: SmoothScrollView(
                scrollController: _scrollController,
                child: Column(
                  spacing: SpacingConstants.xxl,
                  children: [
                    // Presentación -------------------------------------------------------
                    PresentationSection(key: _presentationKey),

                    // Experiencia -----------------------------------------------------
                    CustomConstrain(
                      child: ExperienceSection(
                        key: _experienceKey,
                        scrollController: _scrollController,
                      ),
                    ),
                    CustomConstrain(
                      child: CrossPlatformAnimation(
                        scrollController: _scrollController,
                      ),
                    ),

                    // Stack tecnológico --------------------------------------------------
                    TechStackSlider(
                      key: _techStackKey,
                      scrollController: _scrollController,
                    ),
                    AiVsHumanSplitScreen(scrollController: _scrollController),

                    // Proyectos destacados -----------------------------------------------
                    CustomConstrain(
                      child: ProjectsSection(
                        key: _projectsKey,
                        scrollController: _scrollController,
                      ),
                    ),

                    // Estudios -----------------------------------------------------------
                    CustomConstrain(
                      child: EducationSection(
                        key: _educationKey,
                        scrollController: _scrollController,
                      ),
                    ),

                    // Contacto -----------------------------------------------------------
                    ContactHook(scrollController: _scrollController),
                    CustomConstrain(
                      child: ContactSection(
                        key: _contactKey,
                        scrollController: _scrollController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AdaptivePortfolioAppBar(
              scrollController: _scrollController,
              navItems: _navItems,
              leading: Logo(),
            ),
          ),
        ],
      ),
    );
  }
}
