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

  @override
  Widget build(BuildContext context) {
    // Helper method to create animated panels -------------------------------------------------------
    Widget panel(Widget child, TranslationOrigin origin) => AnimatedTranslation(
      origin: origin,
      scrollController: scrollController,
      child: child,
    );

    // Helper method to create a column layout -------------------------------------------------------
    Widget column(List<Widget> panels, {int? naturalHeightIndex}) {
      return LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: .stretch,
          spacing: gap,
          children: [
            for (final (index, child) in panels.indexed)
              if (constraints.hasBoundedHeight && index != naturalHeightIndex)
                Expanded(child: child)
              else
                child,
          ],
        ),
      );
    }

    // Helper method to create a row layout -------------------------------------------------------
    Widget row(List<Widget> panels, {List<int>? weights}) {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.hasBoundedHeight) {
            return Row(
              crossAxisAlignment: .stretch,
              spacing: gap,
              children: [
                for (final (index, child) in panels.indexed)
                  Expanded(flex: weights?[index] ?? 1, child: child),
              ],
            );
          }
          // In a growing section the tallest cell determines the row height.
          return Table(
            defaultVerticalAlignment:
                TableCellVerticalAlignment.intrinsicHeight,
            columnWidths: {
              for (var i = 0; i < panels.length; i++) ...{
                2 * i: FlexColumnWidth((weights?[i] ?? 1).toDouble()),
                if (i > 0) 2 * i - 1: FixedColumnWidth(gap),
              },
            },
            children: [
              TableRow(
                children: [
                  for (final (index, child) in panels.indexed) ...[
                    if (index > 0) const SizedBox.shrink(),
                    child,
                  ],
                ],
              ),
            ],
          );
        },
      );
    }

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
        if (constraints.maxWidth < 620) {
          return column([
            school,
            greeting,
            row([language, certificates]),
            row([days, interests]),
          ], naturalHeightIndex: 0);
        }
        if (constraints.maxWidth < 780) {
          return row(
            [
              school,
              column([
                greeting,
                row([language, certificates]),
                row([days, interests]),
              ]),
            ],
            weights: [3, 2],
          );
        }
        return column([
          row([
            school,
            column([greeting, language]),
          ]),
          row([certificates, days, interests]),
        ], naturalHeightIndex: 1);
      },
    );
  }
}
