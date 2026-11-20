import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/pages/sections/education/education_section.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/layout/adaptive_dashboard_layout.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';
import 'package:portfolio/widgets/layout/viewport_section.dart';

void main() {
  testWidgets(
    'Education panels fill the remaining height and grow in short windows',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final controller = ScrollController();
      addTearDown(controller.dispose);
      for (final size in [
        const Size(390, 844),
        const Size(780, 510),
        const Size(1366, 768),
        const Size(390, 360),
      ]) {
        tester.view.physicalSize = size;
        await tester.pumpWidget(
          MaterialApp(
            home: SingleChildScrollView(
              controller: controller,
              child: ViewportSection(
                child: EducationSection(scrollController: controller),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final dashboard = find.byType(AdaptiveDashboardLayout);
        final panels = find.descendant(
          of: dashboard,
          matching: find.byType(AnimatedTranslation),
        );
        expect(panels, findsNWidgets(7));
        final bounds = tester.getRect(dashboard);
        final rects = panels
            .evaluate()
            .map((element) => tester.getRect(find.byWidget(element.widget)))
            .toList();
        expect(
          rects.map((rect) => rect.top).reduce((a, b) => a < b ? a : b),
          closeTo(bounds.top, 0.01),
        );
        expect(
          rects.map((rect) => rect.bottom).reduce((a, b) => a > b ? a : b),
          closeTo(bounds.bottom, 0.01),
        );
        final padding = tester
            .widget<Padding>(
              find
                  .descendant(
                    of: find.byType(CustomConstrain),
                    matching: find.byType(Padding),
                  )
                  .first,
            )
            .padding
            .resolve(TextDirection.ltr);
        if (size.height >= 500) {
          expect(bounds.bottom, closeTo(size.height - padding.bottom, 0.01));
        } else {
          expect(controller.position.maxScrollExtent, greaterThan(0));
        }
        expect(tester.takeException(), isNull);
      }
    },
  );
}
