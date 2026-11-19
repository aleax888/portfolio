import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/domain/projects/project_enum.dart';
import 'package:portfolio/pages/widgets/project_card.dart';
import 'package:portfolio/widgets/layout/three_card_layout.dart';

void main() {
  testWidgets(
    'Project cards respect fixed axes and share the landscape row height',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      ProjectCard card(ProjectEnum project, [Axis? axis]) => ProjectCard(
        key: ValueKey(project),
        imagePath: project.image,
        title: project.name,
        description: project.description,
        techStack: project.technologies,
        link: project.link,
        axis: axis,
      );
      for (final size in [const Size(1000, 600), const Size(390, 844)]) {
        tester.view.physicalSize = size;
        await tester.pumpWidget(
          MaterialApp(
            home: SingleChildScrollView(
              child: ThreeCardLayout(
                left: card(ProjectEnum.gymFlow, Axis.vertical),
                topRight: card(ProjectEnum.ledPanel, Axis.horizontal),
                bottomRight: card(ProjectEnum.textArt),
                spacing: 12,
              ),
            ),
          ),
        );
        final cards = find.byType(ProjectCard);
        for (var i = 0; i < 3; i++) {
          final finder = cards.at(i);
          final image = tester.getRect(
            find.descendant(of: finder, matching: find.byType(Image)),
          );
          final title = tester.getRect(
            find.text(tester.widget<ProjectCard>(finder).title),
          );
          if (i == 0 || (i == 2 && size.height > size.width)) {
            expect(title.top, greaterThanOrEqualTo(image.bottom));
          } else {
            expect(title.left, greaterThanOrEqualTo(image.right));
          }
        }
        if (size.width > size.height) {
          final left = tester.getRect(cards.first);
          final top = tester.getRect(cards.at(1));
          final bottom = tester.getRect(cards.last);
          expect(top.top, left.top);
          expect(bottom.bottom, closeTo(left.bottom, 0.01));
          expect(bottom.top - top.bottom, closeTo(12, 0.01));
          expect(top.height, closeTo(bottom.height, 0.01));
        }
        expect(tester.takeException(), isNull);
      }
    },
  );
}
