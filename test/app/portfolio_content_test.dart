import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/domain/experience/experience_enum.dart';
import 'package:portfolio/domain/education/education_enum.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/pages/widgets/experience_card.dart';
import 'package:portfolio/pages/widgets/education_element.dart';
import 'package:portfolio/widgets/animation/flip_card.dart';

import 'package:portfolio/domain/tech_stack/flutter_stack_enum.dart';
import 'package:portfolio/domain/tech_stack/dev_stack_enum.dart';
import 'package:portfolio/domain/tech_stack/complementary_stack_enum.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_slider.dart';
import '../support/portfolio_fonts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadPortfolioFonts);
  testWidgets(
    'Presentation, employment and education render their catalog details',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(
        find.textContaining('ALEX MAGLIO NEYRA HERRADA', findRichText: true),
        findsWidgets,
      );
      for (final job in ExperienceEnum.values) {
        final card = find.ancestor(
          of: find.text(job.name),
          matching: find.byType(ExperienceCard),
        );
        for (final value in [
          job.begin,
          job.end,
          job.position,
          job.description,
          ...job.technologies,
        ]) {
          expect(
            find.descendant(of: card, matching: find.text(value)),
            findsOneWidget,
          );
        }
      }
      for (final degree in EducationEnum.values) {
        final card = find.ancestor(
          of: find.text(degree.degree),
          matching: find.byType(EducationElement),
        );
        for (final value in [degree.period, degree.description]) {
          expect(
            find.descendant(of: card, matching: find.text(value)),
            findsOneWidget,
          );
        }
      }
    },
  );

  testWidgets(
    'Each skills row pairs its logos with the matching names in catalog order',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      final catalogs = <List<TechStackItem>>[
        FlutterStackEnum.values,
        DevStackEnum.values,
        ComplementaryStackEnum.values,
      ];
      final rows = find.byType(ScrollDrivenSlider);
      expect(rows, findsNWidgets(catalogs.length));
      final backs = <Widget>[];
      for (final (index, skills) in catalogs.indexed) {
        final cards = tester
            .widgetList<FlipCard>(
              find.descendant(
                of: rows.at(index),
                matching: find.byType(FlipCard),
              ),
            )
            .toList();
        expect(
          cards.map(
            (card) => ((card.front as Image).image as AssetImage).assetName,
          ),
          skills.map((skill) => skill.image),
        );
        backs.addAll(cards.map((card) => card.back));
      }
      await tester.pumpWidget(MaterialApp(home: Wrap(children: backs)));
      expect(
        tester.widgetList<Text>(find.byType(Text)).map((text) => text.data),
        catalogs.expand((skills) => skills.map((skill) => skill.name)),
      );
    },
  );

  testWidgets('Hover reveals a skill name and leaving restores its logo', (
    tester,
  ) async {
    final skill = FlutterStackEnum.values.first;
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: FlipCard(
            front: Image.asset(skill.image),
            back: Text(skill.name),
          ),
        ),
      ),
    );
    final visible = find.byType(FlipCard);
    final image = find.byType(Image);
    expect(image, findsOneWidget);
    expect(find.text(skill.name), findsNothing);
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer();
    addTearDown(mouse.removePointer);
    await mouse.moveTo(tester.getCenter(visible));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.text(skill.name), findsOneWidget);
    expect(image, findsNothing);
    await mouse.moveTo(Offset.zero);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(image, findsOneWidget);
  });
}
