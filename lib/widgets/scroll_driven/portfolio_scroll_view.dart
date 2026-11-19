import 'package:flutter/material.dart';
import 'package:portfolio/widgets/layout/section_viewport.dart';

class PortfolioScrollView extends StatelessWidget {
  const PortfolioScrollView({
    super.key,
    required this.controller,
    required this.child,
  });

  final ScrollController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SectionViewport(
        size: constraints.biggest,
        child: Scrollbar(
          controller: controller,
          interactive: true,
          thumbVisibility: true,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(controller: controller, child: child),
          ),
        ),
      ),
    );
  }
}
