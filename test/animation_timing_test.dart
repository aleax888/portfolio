import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/widgets/animation/hover_split_view.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_reveal.dart';

void main() {
  for (final hz in [60, 120, 144]) {
    for (final reduced in [false, true]) {
      testWidgets('$hz Hz reduced=$reduced', (tester) async {
        debugSemanticsDisableAnimations = reduced;
        addTearDown(() => debugSemanticsDisableAnimations = null);
        final scroll = ScrollController();
        addTearDown(scroll.dispose);
        await tester.pumpWidget(
          MaterialApp(
            home: Column(
              children: [
                const SizedBox(
                  height: 100,
                  child: SplitOverlapView(
                    leftChild: SizedBox(),
                    rightChild: SizedBox(),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scroll,
                    child: Column(
                      children: [
                        const SizedBox(height: 600),
                        ScrollReveal(
                          scrollController: scroll,
                          child: const SizedBox(height: 100),
                        ),
                        const SizedBox(height: 600),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await mouse.addPointer(location: const Offset(10, 200));
        await mouse.moveTo(const Offset(10, 50));
        scroll.jumpTo(550);
        await tester.pump();
        double split() => tester
            .widget<Align>(
              find
                  .descendant(
                    of: find.byType(SplitOverlapView),
                    matching: find.byType(Align),
                  )
                  .first,
            )
            .widthFactor!;
        double fade() => tester
            .widget<FadeTransition>(
              find.descendant(
                of: find.byType(ScrollReveal),
                matching: find.byType(FadeTransition),
              ),
            )
            .opacity
            .value;
        expect(split(), .5);
        expect(fade(), 0);
        final durationUs = reduced ? 100000 : 2000000;
        var elapsed = 0;
        for (var frame = 1; elapsed < durationUs; frame++) {
          final next = (frame * 1000000 / hz).round().clamp(0, durationUs);
          await tester.pump(Duration(microseconds: next - elapsed));
          elapsed = next;
          if (elapsed == durationUs ~/ 2) {
            print('halfway split=${split()} fade=${fade()}');
          }
          if (elapsed < durationUs - 20000) {
            expect(split(), lessThan(1));
            expect(fade(), lessThan(1));
          }
        }
        expect(split(), closeTo(1, .00001));
        expect(fade(), closeTo(1, .00001));
        await mouse.removePointer();
      });
    }
  }
}
