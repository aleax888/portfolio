import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/domain/projects/project_enum.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/pages/widgets/contact_option.dart';
import 'package:portfolio/pages/widgets/project_card.dart';

import '../support/portfolio_fonts.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadPortfolioFonts);

  const launcher = MethodChannel('plugins.flutter.io/url_launcher');
  late List<String> launched;
  setUp(() {
    launched = [];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(launcher, (call) async {
          expect(call.method, 'launch');
          launched.add(call.arguments['url'] as String);
          return true;
        });
  });
  tearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(launcher, null),
  );

  Future<void> show(WidgetTester tester, Finder target) async {
    await Scrollable.ensureVisible(tester.element(target), alignment: 0.5);
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
  }

  Future<void> press(WidgetTester tester, Finder target) async {
    await tester.tap(target);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 150));
    await tester.pump(const Duration(milliseconds: 150));
  }

  testWidgets('Each project opens its own destination', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    for (final project in ProjectEnum.values) {
      final title = find.descendant(
        of: find.byType(ProjectCard),
        matching: find.text(project.name),
      );
      await show(tester, title);
      await press(tester, title);
      expect(launched, [project.link]);
      launched.clear();
    }
  });

  testWidgets('Contact rows open their destination and copy independently', (
    tester,
  ) async {
    final copied = <String>[];
    final messenger = tester.binding.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') {
        copied.add(call.arguments['text'] as String);
      }
      return null;
    });
    addTearDown(
      () => messenger.setMockMethodCallHandler(SystemChannels.platform, null),
    );
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    const contacts = {
      'alex.maglio.neyra.herrada@gmail.com':
          'https://mail.google.com/mail/?view=cm&fs=1&to=alex.maglio.neyra.herrada@gmail.com&su=Hello%20from%20...&body=Hello,%20...',
      '(+51) 967 746 185': 'https://wa.me/51967746185?text=Hola%20Alex%20...',
      'Alex Maglio Neyra Herrada':
          'https://linkedin.com/in/alex-maglio-neyra-herrada-04271432a/',
      'aleax888': 'https://github.com/aleax888',
    };
    for (final contact in contacts.entries) {
      final label = find.text(contact.key);
      final row = find.ancestor(
        of: label,
        matching: find.byType(ContactOption),
      );
      await show(tester, label);
      await press(
        tester,
        find.descendant(of: row, matching: find.byIcon(Icons.copy)),
      );
      expect(copied, [contact.key]);
      expect(launched, isEmpty);
      await press(tester, label);
      expect(launched, [contact.value]);
      expect(copied, [contact.key]);
      copied.clear();
      launched.clear();
    }
  });
}
