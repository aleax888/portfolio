import 'package:portfolio/widgets/scroll_driven/section_activity.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio/widgets/scroll_driven/desktop_scroll_controller.dart';
import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/widgets/layout/growing_viewport_section.dart';
import 'package:portfolio/pages/sections/contact/hook/contact_hook.dart';
import 'package:portfolio/pages/sections/contact/section/contact_section.dart';
import 'package:portfolio/pages/sections/education/education_section.dart';
import 'package:portfolio/pages/sections/experience/animation/cross_platform_animation.dart';
import 'package:portfolio/pages/sections/experience/section/experience_section.dart';
import 'package:portfolio/pages/sections/presentation/presentation_section.dart';
import 'package:portfolio/pages/sections/projects/projects_section.dart';
import 'package:portfolio/pages/sections/stack/slider/tech_stack_slider.dart';
import 'package:portfolio/pages/widgets/logo.dart';
import 'package:portfolio/widgets/layout/custom_appbar/custom_app_bar.dart';
import 'package:portfolio/widgets/layout/viewport_section.dart';
import 'package:portfolio/widgets/scroll_driven/portfolio_scroll_view.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  // Scroll Controller -------------------------------------------------------
  final ScrollController _scrollController = switch (defaultTargetPlatform) {
    TargetPlatform.windows ||
    TargetPlatform.macOS ||
    TargetPlatform.linux => DesktopScrollController(),
    _ => ScrollController(),
  };

  // Section Keys -------------------------------------------------------
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
              child: PortfolioScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // Presenation (Section) -------------------------------------------------------
                    ViewportSection(
                      key: _presentationKey,
                      child: const PresentationSection(),
                    ),

                    // Experience (Section) -------------------------------------------------------
                    GrowingViewportSection(
                      key: _experienceKey,
                      child: ExperienceSection(
                        scrollController: _scrollController,
                      ),
                    ),

                    // Cross Platform (Hook) -------------------------------------------------------
                    SectionActivity(
                      controller: _scrollController,
                      child: CrossPlatformAnimation(
                        scrollController: _scrollController,
                      ),
                    ),

                    // Tech Stack (Section) -------------------------------------------------------
                    GrowingViewportSection(
                      key: _techStackKey,
                      child: SectionActivity(
                        controller: _scrollController,
                        child: TechStackSlider(
                          scrollController: _scrollController,
                        ),
                      ),
                    ),

                    // Projects (Section) -------------------------------------------------------
                    GrowingViewportSection(
                      key: _projectsKey,
                      child: SectionActivity(
                        controller: _scrollController,
                        child: ProjectsSection(
                          scrollController: _scrollController,
                        ),
                      ),
                    ),

                    // Education (Section) -------------------------------------------------------
                    ViewportSection(
                      key: _educationKey,
                      child: EducationSection(
                        scrollController: _scrollController,
                      ),
                    ),

                    // Contact (Hook) -------------------------------------------------------
                    ContactHook(scrollController: _scrollController),

                    // Contact (Section) -------------------------------------------------------
                    GrowingViewportSection(
                      key: _contactKey,
                      child: ContactSection(
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
            child: Padding(
              padding: const EdgeInsets.only(right: SpacingConstants.xs),
              child: AdaptivePortfolioAppBar(
                navItems: _navItems,
                leading: Logo(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
