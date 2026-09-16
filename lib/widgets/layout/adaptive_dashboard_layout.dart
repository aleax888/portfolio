import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';

class AdaptiveDashboardLayout extends StatelessWidget {
  final Widget a;
  final Widget b;
  final Widget c;
  final Widget d;
  final Widget e;
  final Widget f;
  final Widget g;
  final double gap;
  final ScrollController scrollController;

  const AdaptiveDashboardLayout({
    super.key,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.e,
    required this.f,
    required this.g,
    this.gap = SpacingConstants.xs,
    required this.scrollController,
  });

  static const double mobileBreakpoint = 768;
  static const double desktopBreakpoint = 1200;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (width < mobileBreakpoint) {
          return _buildMobile();
        }

        if (width < desktopBreakpoint) {
          return _buildTablet();
        }

        return _buildDesktop();
      },
    );
  }

  Widget _buildMobile() {
    return Column(
      spacing: gap,
      children: [
        Expanded(
          child: AnimatedTranslation(
            origin: .fromLeft,
            scrollController: scrollController,
            child: a,
          ),
        ),
        Expanded(
          child: AnimatedTranslation(
            origin: .fromRight,
            scrollController: scrollController,
            child: b,
          ),
        ),
        Expanded(
          child: AnimatedTranslation(
            origin: .fromLeft,
            scrollController: scrollController,
            child: c,
          ),
        ),
        Expanded(
          child: AnimatedTranslation(
            origin: .fromRight,
            scrollController: scrollController,
            child: d,
          ),
        ),
        Expanded(
          child: AnimatedTranslation(
            origin: .fromLeft,
            scrollController: scrollController,
            child: e,
          ),
        ),
        Expanded(
          child: AnimatedTranslation(
            origin: .fromRight,
            scrollController: scrollController,
            child: f,
          ),
        ),
        Expanded(
          child: AnimatedTranslation(
            origin: .fromLeft,
            scrollController: scrollController,
            child: g,
          ),
        ),
      ],
    );
  }

  Widget _buildTablet() {
    return Column(
      spacing: gap,
      children: [
        Expanded(
          child: AnimatedTranslation(
            origin: .fromLeft,
            scrollController: scrollController,
            child: a,
          ),
        ),

        Expanded(
          child: Row(
            spacing: gap,
            children: [
              Expanded(
                child: AnimatedTranslation(
                  origin: .fromLeft,
                  scrollController: scrollController,
                  child: b,
                ),
              ),
              Expanded(
                child: AnimatedTranslation(
                  origin: .fromRight,
                  scrollController: scrollController,
                  child: c,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: AnimatedTranslation(
            origin: .fromRight,
            scrollController: scrollController,
            child: d,
          ),
        ),

        Expanded(
          child: Row(
            spacing: gap,
            children: [
              Expanded(
                child: AnimatedTranslation(
                  origin: .fromLeft,
                  scrollController: scrollController,
                  child: e,
                ),
              ),
              Expanded(
                child: AnimatedTranslation(
                  origin: .fromRight,
                  scrollController: scrollController,
                  child: g,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: AnimatedTranslation(
            origin: .fromLeft,
            scrollController: scrollController,
            child: f,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktop() {
    return Column(
      spacing: gap,
      children: [
        Expanded(
          child: Row(
            spacing: gap,
            children: [
              Expanded(
                child: AnimatedTranslation(
                  origin: .fromLeft,
                  scrollController: scrollController,
                  child: a,
                ),
              ),
              Expanded(
                child: Column(
                  spacing: gap,
                  children: [
                    Expanded(
                      child: Row(
                        spacing: gap,
                        children: [
                          Expanded(
                            child: AnimatedTranslation(
                              origin: .fromLeft,
                              scrollController: scrollController,
                              child: b,
                            ),
                          ),
                          Expanded(
                            child: AnimatedTranslation(
                              origin: .fromRight,
                              scrollController: scrollController,
                              child: c,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: AnimatedTranslation(
                        origin: .fromRight,
                        scrollController: scrollController,
                        child: d,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            spacing: gap,
            children: [
              Expanded(
                child: AnimatedTranslation(
                  origin: .fromBottomLeft,
                  scrollController: scrollController,
                  child: e,
                ),
              ),
              Expanded(
                child: AnimatedTranslation(
                  origin: .fromBottom,
                  scrollController: scrollController,
                  child: f,
                ),
              ),
              Expanded(
                child: AnimatedTranslation(
                  origin: .fromBottomRight,
                  scrollController: scrollController,
                  child: g,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
