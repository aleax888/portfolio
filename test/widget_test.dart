import 'package:flutter/gestures.dart';
import 'package:portfolio/widgets/layout/custom_appbar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'support/portfolio_fonts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/pages/sections/contact/section/contact_section.dart';
import 'package:portfolio/pages/sections/presentation/presentation_section.dart';
import 'package:portfolio/widgets/content/split_view.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/widgets/layout/viewport_section.dart';
import 'package:portfolio/widgets/layout/growing_viewport_section.dart';
import 'package:portfolio/pages/sections/projects/projects_section.dart';
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
  setUpAll(loadPortfolioFonts);

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
        tester.platformDispatcher.textScaleFactorTestValue = scale;
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await tester.pumpWidget(const MyApp());
        await tester.pump();
        Finder owner(Type content, Type wrapper) => find.ancestor(
          of: find.byType(content),
          matching: find.byType(wrapper),
        );
        expect(owner(ProjectsSection, GrowingViewportSection), findsOneWidget);
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
        final contactWidth = tester
            .getSize(
              find.descendant(
                of: find.byType(ContactSection),
                matching: find.byType(SplitView),
              ),
            )
            .width;
        expect(
          contactWidth,
          (size.width - 2 * SpacingConstants.l).clamp(
            0.0,
            LayoutConstants.contentWidth,
          ),
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
      await tester.pump(const Duration(milliseconds: 300));
      if (size.width >= 900) {
        await tester.tap(find.byTooltip('Mostrar cabecera'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
      }
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
      expect(tester.getTopLeft(find.byType(ContactSection)).dy, closeTo(0, 1));
      // A short viewport can show only the beginning of the contact section.
      if (controller.position.extentAfter > 1) {
        await tester.dragFrom(const Offset(350, 260), const Offset(0, -230));
        await tester.pump(const Duration(seconds: 2));
      }
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

  testWidgets(
    'Desktop header waits two full seconds after the pointer leaves',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(1200, 700);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Align(
              alignment: Alignment.topCenter,
              child: AdaptivePortfolioAppBar(
                navItems: [
                  PortfolioNavItem(label: 'Home', sectionKey: GlobalKey()),
                ],
              ),
            ),
          ),
        ),
      );
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer(location: const Offset(400, 200));
      addTearDown(mouse.removePointer);
      final bubble = find.byTooltip('Mostrar cabecera');
      for (var i = 0; i < 2; i++) {
        await tester.pump(const Duration(milliseconds: 1500));
        await mouse.moveTo(const Offset(400, 20));
        await tester.pump(const Duration(seconds: 3));
        expect(bubble, findsNothing);
        await mouse.moveTo(const Offset(400, 200));
      }
      await tester.pump(const Duration(milliseconds: 1999));
      expect(bubble, findsNothing);
      await tester.pump(const Duration(milliseconds: 1));
      expect(bubble, findsOneWidget);
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Home'), findsNothing);
      await tester.tap(bubble);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Home'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
