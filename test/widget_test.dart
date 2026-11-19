import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/pages/sections/contact/section/contact_section.dart';
import 'package:portfolio/pages/sections/presentation/presentation_section.dart';
import 'package:portfolio/widgets/layout/viewport_section.dart';
import 'package:portfolio/widgets/layout/growing_viewport_section.dart';
import 'package:portfolio/pages/portfolio_page.dart';
import 'package:portfolio/pages/sections/education/education_section.dart';
import 'package:portfolio/pages/sections/experience/section/experience_section.dart';
import 'package:portfolio/pages/sections/experience/animation/cross_platform_animation.dart';
import 'package:portfolio/pages/sections/stack/slider/tech_stack_slider.dart';
import 'package:portfolio/pages/sections/stack/ai_vs_human/ai_vs_human_split_screen.dart';
import 'package:portfolio/pages/sections/contact/hook/contact_hook.dart';
import 'package:portfolio/design_system/constants/layout_constants.dart';
import 'package:portfolio/widgets/scroll_driven/portfolio_scroll_view.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    for (final entry in {
      'BebasNeue': 'bebas_neue',
      'FragmentMono': 'fragment_mono',
      'Inter': 'inter',
    }.entries) {
      final loader = FontLoader(entry.key)
        ..addFont(rootBundle.load('assets/fonts/${entry.value}_regular.ttf'));
      await loader.load();
    }
  });

  for (final size in [
    const Size(390, 844),
    const Size(844, 260),
    const Size(320, 568),
    const Size(780, 510),
    const Size(1024, 600),
    const Size(1680, 960),
    const Size(844, 390),
    const Size(1366, 768),
  ]) {
    for (final scale in [1.0, 2.0]) {
      testWidgets('Portfolio section contracts at $size, text scale $scale', (
        tester,
      ) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = size;
        addTearDown(tester.view.reset);
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(scale)),
                  child: const PortfolioPage(),
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        Finder owner(Type content, Type wrapper) => find.ancestor(
          of: find.byType(content),
          matching: find.byType(wrapper),
        );
        for (final section in [PresentationSection, EducationSection]) {
          final fixed = owner(section, ViewportSection);
          expect(fixed, findsOneWidget);
          final height = tester.getSize(fixed).height;
          final minHeight = size.width < LayoutConstants.tabletWidth
              ? LayoutConstants.minPortraitSectionHeight
              : LayoutConstants.minSectionHeight;
          if (scale == 1 && size.height >= minHeight) {
            expect(height, size.height);
          } else {
            expect(height, greaterThanOrEqualTo(size.height));
          }
        }
        expect(
          owner(ExperienceSection, GrowingViewportSection),
          findsOneWidget,
        );
        expect(
          tester
              .getSize(owner(ExperienceSection, GrowingViewportSection))
              .height,
          greaterThanOrEqualTo(size.height),
        );
        expect(
          tester.element(owner(TechStackSlider, GrowingViewportSection)),
          same(
            tester.element(owner(AiVsHumanSplitScreen, GrowingViewportSection)),
          ),
        );
        for (final scene in [CrossPlatformAnimation, ContactHook]) {
          expect(owner(scene, ViewportSection), findsNothing);
          expect(owner(scene, GrowingViewportSection), findsNothing);
        }
        final contactWidth = tester.getSize(find.byType(ContactSection)).width;
        expect(
          contactWidth,
          size.width.clamp(0.0, LayoutConstants.contentWidth),
        );
        final controller = tester
            .widget<PortfolioScrollView>(find.byType(PortfolioScrollView))
            .controller;
        controller.jumpTo(controller.position.maxScrollExtent);
        await tester.pump();
        await tester.pump();
        await tester.pump(const Duration(seconds: 2));
        expect(find.text('aleax888').hitTestable(), findsOneWidget);
      });
    }
  }

  for (final size in [
    const Size(390, 844),
    const Size(844, 390),
    const Size(1366, 768),
  ]) {
    testWidgets('The portfolio menu opens Contact at $size', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const MyApp());
      await tester.pump(const Duration(seconds: 2));
      await tester.tap(find.byTooltip('Mostrar cabecera'));
      await tester.pump();
      if (size.width < 900) {
        await tester.tap(find.byTooltip('Menú'));
        await tester.pump();
        await tester.pump(const Duration(seconds: 2));
      }
      await tester.tap(find.text('Contact').last);
      for (var i = 0; i < 15; i++) {
        await tester.pump(const Duration(milliseconds: 160));
      }
      final controller = tester
          .widget<PortfolioScrollView>(find.byType(PortfolioScrollView))
          .controller;
      expect(
        controller.offset,
        closeTo(controller.position.maxScrollExtent, 1),
      );
      expect(find.text('aleax888').hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Section sizes use the scroll viewport inside a smaller panel', (
    tester,
  ) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            height: 320,
            child: PortfolioScrollView(
              controller: controller,
              child: const Column(
                children: [
                  ViewportSection(child: SizedBox.shrink()),
                  GrowingViewportSection(child: SizedBox(height: 25)),
                  GrowingViewportSection(child: SizedBox(height: 500)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    expect(tester.getSize(find.byType(ViewportSection)).height, 320);
    expect(
      tester.getSize(find.byType(GrowingViewportSection).first).height,
      320,
    );
    expect(
      tester.getSize(find.byType(GrowingViewportSection).last).height,
      500,
    );
  });

  testWidgets('Only the bubble reopens the header for another two seconds', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    final controller = tester
        .widget<PortfolioScrollView>(find.byType(PortfolioScrollView))
        .controller;
    final bubble = find.byTooltip('Mostrar cabecera');
    final menu = find.byTooltip('Menú');
    expect(menu, findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1500));
    controller.jumpTo(300);
    await tester.pump(const Duration(milliseconds: 499));
    expect(menu, findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1));
    expect(bubble, findsOneWidget);
    controller.jumpTo(0);
    await tester.pump(const Duration(seconds: 3));
    expect(menu, findsNothing);
    await tester.tap(bubble);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1999));
    expect(menu, findsOneWidget);
    expect(bubble, findsNothing);
    await tester.pump(const Duration(milliseconds: 1));
    expect(bubble, findsOneWidget);
    await tester.tap(bubble);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 3));
    expect(tester.takeException(), isNull);
  });
}
