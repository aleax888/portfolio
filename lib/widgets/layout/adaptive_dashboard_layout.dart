import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/layout_constants.dart';
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

  @override
  Widget build(BuildContext context) {
    Widget panel(Widget child, TranslationOrigin origin) => AnimatedTranslation(
      origin: origin,
      scrollController: scrollController,
      child: child,
    );
    Widget column(List<Widget> panels) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: gap,
      children: panels,
    );
    Widget row(List<Widget> panels) => Row(
      spacing: gap,
      children: [for (final child in panels) Expanded(child: child)],
    );
    final school = panel(a, .fromLeft);
    final hello = panel(b, .fromLeft);
    final world = panel(c, .fromRight);
    final language = panel(d, .fromRight);
    final certificates = panel(e, .fromBottomLeft);
    final days = panel(f, .fromBottom);
    final interests = panel(g, .fromBottomRight);

    return LayoutBuilder(
      builder: (context, constraints) {
        final greeting = row([hello, world]);
        if (constraints.maxWidth < LayoutConstants.splitWidth) {
          return column([
            school,
            greeting,
            row([language, certificates]),
            row([days, interests]),
          ]);
        }
        if (constraints.maxWidth < LayoutConstants.wideSplitWidth) {
          return Row(
            spacing: gap,
            children: [
              Expanded(flex: 3, child: school),
              Expanded(
                flex: 2,
                child: column([
                  greeting,
                  row([language, certificates]),
                  row([days, interests]),
                ]),
              ),
            ],
          );
        }
        return column([
          row([
            school,
            column([greeting, language]),
          ]),
          row([certificates, days, interests]),
        ]);
      },
    );
  }
}
