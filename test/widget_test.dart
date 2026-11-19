import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_animation.dart';
import 'package:portfolio/widgets/layout/custom_appbar/custom_app_bar.dart';
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
import 'package:portfolio/widgets/scroll_driven/inertia_scroll_controller.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_typing.dart';
import 'package:portfolio/widgets/scroll_driven/viewport_threshold_notifier.dart';

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
          .widget<AdaptivePortfolioAppBar>(find.byType(AdaptivePortfolioAppBar))
          .scrollController;
      expect(
        controller.offset,
        closeTo(controller.position.maxScrollExtent, 1),
      );
      expect(find.text('aleax888').hitTestable(), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets(
    'A pinned Lottie scene maps its loaded frame count to scroll distance',
    (tester) async {
      final controller = ScrollController();
      addTearDown(controller.dispose);
      const path = 'assets/animations/iphone.json';
      final composition = await tester.runAsync(() => AssetLottie(path).load());
      final distance = composition!.durationFrames * 16;
      await tester.pumpWidget(
        MaterialApp(
          home: PortfolioScrollView(
            controller: controller,
            child: Column(
              children: [
                ScrollDrivenAnimation(
                  scrollController: controller,
                  animationPath: path,
                ),
                const SizedBox(height: 600),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      expect(
        tester.getSize(find.byType(ScrollDrivenAnimation)).height,
        closeTo(600 + distance, 0.1),
      );
      for (final fraction in [0.0, 0.5, 1.0]) {
        controller.jumpTo(distance * fraction);
        await tester.pump();
        await tester.pump();
        expect(
          tester
              .widget<LottieBuilder>(find.byType(LottieBuilder))
              .controller!
              .value,
          closeTo(fraction, 0.001),
        );
      }
    },
  );

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

  testWidgets('Threshold supports restored offsets, reentry and resize', (
    tester,
  ) async {
    final controller = ScrollController(initialScrollOffset: 550);
    addTearDown(controller.dispose);
    var entries = 0;
    Widget page(double height) => MaterialApp(
      home: Center(
        child: SizedBox(
          height: height,
          child: PortfolioScrollView(
            controller: controller,
            child: Column(
              children: [
                const SizedBox(height: 600),
                ViewportThresholdNotifier(
                  controller: controller,
                  threshold: 0.5,
                  onThresholdCrossed: () => entries++,
                  child: const SizedBox(height: 80),
                ),
                const SizedBox(height: 600),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pumpWidget(page(300));
    expect(entries, 1);
    controller.jumpTo(0);
    await tester.pump();
    controller.jumpTo(420);
    await tester.pump();
    expect(entries, 1);
    await tester.pumpWidget(page(400));
    expect(entries, 2);
    controller.jumpTo(700);
    await tester.pump();
    expect(entries, 2);
  });

  testWidgets('Only the bubble reopens the header for another two seconds', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    final controller = tester
        .widget<AdaptivePortfolioAppBar>(find.byType(AdaptivePortfolioAppBar))
        .scrollController;
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

  testWidgets('Wheel distance accumulates, reverses and yields to navigation', (
    tester,
  ) async {
    final controller = InertiaScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      MaterialApp(
        home: PortfolioScrollView(
          controller: controller,
          child: const SizedBox(height: 3000),
        ),
      ),
    );
    Future<void> wheel(double delta) async {
      await tester.sendEventToBinding(
        PointerScrollEvent(
          position: const Offset(200, 200),
          scrollDelta: Offset(0, delta),
        ),
      );
      await tester.pump();
    }

    await wheel(120);
    await tester.pump(const Duration(milliseconds: 16));
    final first = controller.offset;
    expect(first, inExclusiveRange(0, 120));
    await tester.pump(const Duration(milliseconds: 16));
    expect(controller.offset, inExclusiveRange(first, 120));
    await wheel(120);
    await tester.pumpAndSettle();
    expect(controller.offset, 240);
    await wheel(120);
    await tester.pump(const Duration(milliseconds: 32));
    final atReversal = controller.offset;
    await wheel(-60);
    await tester.pumpAndSettle();
    expect(controller.offset, closeTo(atReversal - 60, 0.001));
    await wheel(-120);
    await tester.pump(const Duration(milliseconds: 16));
    final navigation = controller.animateTo(
      800,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );
    await tester.pumpAndSettle();
    await navigation;
    expect(controller.offset, 800);
    await wheel(10000);
    await tester.pumpAndSettle();
    expect(controller.offset, controller.position.maxScrollExtent);
  });

  testWidgets('Wheel followed by thumb drag leaves the position at release', (
    tester,
  ) async {
    final controller = InertiaScrollController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.windows),
        home: PortfolioScrollView(
          controller: controller,
          child: const SizedBox(height: 3000),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.sendEventToBinding(
      const PointerScrollEvent(
        position: Offset(200, 200),
        scrollDelta: Offset(0, 120),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 16));
    final afterWheel = controller.offset;
    expect(afterWheel, inExclusiveRange(0, 120));
    final rect = tester.getRect(find.byType(Scrollbar));
    final mouse = await tester.startGesture(
      Offset(rect.right - 5, rect.top + 65),
      kind: PointerDeviceKind.mouse,
    );
    await tester.pump(const Duration(milliseconds: 100));
    expect(controller.offset, afterWheel);
    await mouse.moveBy(const Offset(0, 160));
    await mouse.moveBy(const Offset(0, 20));
    await tester.pump();
    await mouse.up();
    await tester.pump();
    final afterDrag = controller.offset;
    expect(afterDrag, greaterThan(afterWheel));
    await tester.pump(const Duration(seconds: 1));
    expect(controller.offset, afterDrag);
  });

  testWidgets('Typing advances by whole characters and handles empty text', (
    tester,
  ) async {
    final controller = ScrollController();
    addTearDown(controller.dispose);
    Widget page(String text) => MaterialApp(
      home: PortfolioScrollView(
        controller: controller,
        child: Column(
          children: [
            ScrollDrivenTyping(
              text: text,
              scrollController: controller,
              pixelsPerCharacter: 50,
            ),
            const SizedBox(height: 600),
          ],
        ),
      ),
    );
    await tester.pumpWidget(page('😀B'));
    String visible() =>
        ((tester.widget<Text>(find.byType(Text)).textSpan! as TextSpan)
                    .children!
                    .first
                as TextSpan)
            .text!;
    expect(visible(), '');
    for (final (offset, expected) in [
      (50.0, '😀'),
      (100.0, '😀B'),
      (0.0, ''),
    ]) {
      controller.jumpTo(offset);
      await tester.pump();
      await tester.pump();
      expect(visible(), expected);
    }
    await tester.pumpWidget(page(''));
    expect(visible(), '');
  });
}
