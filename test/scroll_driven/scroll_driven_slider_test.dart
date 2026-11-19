import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_slider.dart';
import 'fixture.dart';

void main() {
  testWidgets(
    'Moves the cards in both directions and updates travel on resize',
    (tester) async {
      final c = ScrollController();
      addTearDown(c.dispose);
      Widget page(SliderDirection direction, double width) => fixture(
        c,
        ScrollDrivenSlider(
          scrollController: c,
          items: const [Text('card')],
          itemSize: 100,
          offset: 0,
          threshold: 1,
          direction: direction,
        ),
        width: width,
      );
      double x() =>
          tester.getTopLeft(find.text('card')).dx -
          tester.getTopLeft(find.byType(ScrollDrivenSlider)).dx;
      for (final direction in SliderDirection.values) {
        await tester.pumpWidget(page(direction, 300));
        await tester.pumpAndSettle();
        for (final progress in [0.0, 0.5, 1.0, 0.25]) {
          c.jumpTo(200 + 200 * progress);
          await tester.pumpAndSettle();
          expect(
            x(),
            closeTo(
              300 -
                  400 *
                      (direction == SliderDirection.toLeft
                          ? progress
                          : 1 - progress),
              0.01,
            ),
          );
        }
      }
      await tester.pumpWidget(page(SliderDirection.toLeft, 200));
      await tester.pumpAndSettle();
      expect(x(), closeTo(200 - 300 * 0.25, 0.01));
    },
  );
}
