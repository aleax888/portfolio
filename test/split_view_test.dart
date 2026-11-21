import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/widgets/content/split_view.dart';

void main() {
  testWidgets('Stacks panels when the horizontal gap exceeds local width', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(800, 400);
    addTearDown(tester.view.reset);

    const left = SizedBox(key: ValueKey('left'), height: 20);
    const right = SizedBox(key: ValueKey('right'), height: 20);
    await tester.pumpWidget(
      const MaterialApp(
        home: Center(
          child: SizedBox(
            width: 85,
            child: SplitView(split: 0.7, gap: 100, left: left, right: right),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(tester.getSize(find.byWidget(left)).width, 85);
    expect(
      tester.getTopLeft(find.byWidget(right)).dy,
      tester.getBottomLeft(find.byWidget(left)).dy + 100,
    );
  });

  testWidgets('Portrait photo gets remaining height or sizes to its content', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(400, 800);
    addTearDown(tester.view.reset);

    const photo = SizedBox(key: ValueKey('photo'), height: 150);
    const split = SplitView(
      gap: 10,
      expandBottom: true,
      left: SizedBox(height: 100),
      right: photo,
    );
    await tester.pumpWidget(const MaterialApp(home: split));
    expect(tester.getSize(find.byWidget(photo)).height, 690);

    await tester.pumpWidget(
      const MaterialApp(home: SingleChildScrollView(child: split)),
    );
    expect(tester.getSize(find.byWidget(photo)).height, 150);
  });
}
