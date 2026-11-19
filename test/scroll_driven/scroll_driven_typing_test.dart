import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_typing.dart';
import 'fixture.dart';

void main() {
  testWidgets('Pins each instance independently and remeasures after reflow', (
    tester,
  ) async {
    final c = ScrollController();
    addTearDown(c.dispose);
    Widget scene(String text) => ScrollDrivenTyping(
      text: text,
      scrollController: c,
      pixelsPerCharacter: 50,
    );
    Widget page(double before) => fixture(
      c,
      Column(children: [scene('A\u{1F469}\u200D\u{1F4BB}'), scene('BC')]),
      before: before,
    );
    String visible(int i) =>
        ((tester.widget<Text>(find.byType(Text).at(i)).textSpan! as TextSpan)
                    .children!
                    .first
                as TextSpan)
            .text!;
    await tester.pumpWidget(page(400));
    await tester.pumpAndSettle();
    for (final (offset, a, b) in [
      (450.0, 'A', ''),
      (500.0, 'A\u{1F469}\u200D\u{1F4BB}', ''),
      (750.0, 'A\u{1F469}\u200D\u{1F4BB}', 'B'),
      (450.0, 'A', ''),
    ]) {
      c.jumpTo(offset);
      await tester.pumpAndSettle();
      expect([visible(0), visible(1)], [a, b]);
      if (offset <= 500) {
        expect(tester.getCenter(find.byType(Text).first).dy, 300);
      }
    }
    await tester.pumpWidget(page(500));
    await tester.pumpAndSettle();
    expect(visible(0), '');
    await tester.pumpWidget(fixture(c, scene('')));
    await tester.pumpAndSettle();
    expect(visible(0), '');
  });
}
