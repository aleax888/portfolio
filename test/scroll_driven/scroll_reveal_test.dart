import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_reveal.dart';
import 'fixture.dart';

void main() {
  testWidgets(
    'Triggers once at the threshold, on restored entry and at document end',
    (tester) async {
      for (final (initial, after) in [
        (0.0, 600.0),
        (320.0, 600.0),
        (0.0, 0.0),
      ]) {
        final c = ScrollController(initialScrollOffset: initial);
        addTearDown(c.dispose);
        await tester.pumpWidget(
          fixture(
            c,
            ScrollReveal(
              scrollController: c,
              child: const SizedBox(height: 30),
            ),
            after: after,
          ),
        );
        await tester.pumpAndSettle();
        double opacity() => tester
            .widget<FadeTransition>(
              find.descendant(
                of: find.byType(ScrollReveal),
                matching: find.byType(FadeTransition),
              ),
            )
            .opacity
            .value;
        if (initial == 0) {
          expect(opacity(), 0);
          c.jumpTo(after == 0 ? c.position.maxScrollExtent : 300);
          await tester.pumpAndSettle();
        }
        expect(opacity(), 1);
        c.jumpTo(0);
        await tester.pumpAndSettle();
        expect(opacity(), 1);
        await tester.pumpWidget(const SizedBox.shrink());
      }
    },
  );
}
