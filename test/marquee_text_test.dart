import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/widgets/animation/marquee_text.dart';

void main() {
  testWidgets(
    'Uses rendered width, elapsed time and the remainder after wrapping',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Center(
            child: SizedBox(
              width: 200,
              height: 60,
              child: MarqueeText(
                text: 'abc',
                startOffsetFraction: 0,
                speedPixelsPerSecond: 100,
                initialDelay: Duration(milliseconds: 200),
              ),
            ),
          ),
        ),
      );
      final text = find.text('abc');
      final origin = tester.getTopLeft(find.byType(MarqueeText)).dx;
      final width = tester.getSize(text).width;
      double x() => tester.getTopLeft(text).dx - origin;
      expect(x(), closeTo(0, 0.001));
      await tester.pump(const Duration(milliseconds: 100));
      expect(x(), closeTo(0, 0.001));
      await tester.pump(const Duration(milliseconds: 250));
      expect(x(), closeTo(-15, 0.001));
      await tester.pump(const Duration(seconds: 8));
      expect(x(), closeTo(200 - (200 + 815) % (200 + width), 0.001));
    },
  );

  testWidgets(
    'Preserves position on pause, speed change, resize and reversal',
    (tester) async {
      Widget panel(double width, double speed, MarqueeDirection direction) =>
          MaterialApp(
            home: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: width,
                height: 60,
                child: MarqueeText(
                  text: 'abc',
                  direction: direction,
                  startOffsetFraction: 0.5,
                  speedPixelsPerSecond: speed,
                ),
              ),
            ),
          );
      double x() => tester.getTopLeft(find.text('abc')).dx;
      await tester.pumpWidget(panel(200, 100, MarqueeDirection.left));
      await tester.pump(const Duration(milliseconds: 300));
      expect(x(), closeTo(70, 0.001));
      await tester.pumpWidget(panel(300, 0, MarqueeDirection.left));
      await tester.pump(const Duration(seconds: 2));
      expect(x(), closeTo(70, 0.001));
      await tester.pumpWidget(panel(300, 50, MarqueeDirection.right));
      await tester.pump();
      expect(x(), closeTo(70, 0.001));
      await tester.pump(const Duration(milliseconds: 400));
      expect(x(), closeTo(90, 0.001));
    },
  );
}
