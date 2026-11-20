import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/pages/sections/education/education_section.dart';
import 'package:portfolio/pages/sections/experience/section/experience_section.dart';
import 'package:portfolio/pages/sections/presentation/presentation_section.dart';
import 'package:portfolio/pages/sections/projects/projects_section.dart';
import 'package:portfolio/pages/sections/stack/slider/tech_stack_slider.dart';
import '../support/portfolio_fonts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadPortfolioFonts);

  testWidgets('Mobile menu reaches each section and returns to the start', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MyApp());
    for (final entry in {
      'Experience': ExperienceSection,
      'Stack': TechStackSlider,
      'Projects': ProjectsSection,
      'Education': EducationSection,
      'Start': PresentationSection,
    }.entries) {
      await tester.tap(find.byTooltip('Men\u00fa'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.text(entry.key).last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump(const Duration(milliseconds: 600));
      final top = tester.getTopLeft(find.byType(entry.value)).dy;
      expect(top, closeTo(0, 1), reason: entry.key);
      expect(find.byType(ListTile), findsNothing);
    }
  });
}
