import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_animation.dart';
import 'fixture.dart';

import 'package:lottie/lottie.dart';

void main() {
  testWidgets(
    'Loaded frames determine pinned distance and reversible playback',
    (tester) async {
      const path = 'assets/animations/iphone.json';
      final composition = await tester.runAsync(() => AssetLottie(path).load());
      final distance = composition!.durationFrames * 16;
      final c = ScrollController();
      addTearDown(c.dispose);
      await tester.pumpWidget(
        fixture(
          c,
          ScrollDrivenAnimation(
            animationPath: path,
            scrollController: c,
            pixelsPerFrame: 16,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        tester.getSize(find.byType(ScrollDrivenAnimation)).height,
        closeTo(200 + distance, 0.01),
      );
      for (final progress in [0.0, 0.5, 1.0, 0.25]) {
        c.jumpTo(400 + distance * progress);
        await tester.pumpAndSettle();
        expect(
          tester
              .widget<LottieBuilder>(find.byType(LottieBuilder))
              .controller!
              .value,
          closeTo(progress, 0.001),
        );
        expect(tester.getCenter(find.byType(LottieBuilder)).dy, 300);
      }
    },
  );
}
