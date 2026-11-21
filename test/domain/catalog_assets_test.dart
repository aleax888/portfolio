import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/domain/education/education_enum.dart';
import 'package:portfolio/domain/projects/project_enum.dart';
import 'package:portfolio/domain/tech_stack/complementary_stack_enum.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';
import 'package:portfolio/domain/tech_stack/dev_stack_enum.dart';
import 'package:portfolio/domain/tech_stack/flutter_stack_enum.dart';
import 'package:portfolio/helpers/assets/animation_enum.dart';
import 'package:portfolio/helpers/assets/icon_enum.dart';
import 'package:portfolio/helpers/assets/images/me_enum.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'The Flutter bundle contains the portfolio catalog images and animations',
    () async {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      expect(
        manifest.listAssets(),
        containsAll([
          for (final project in ProjectEnum.values) project.image,
          for (final degree in EducationEnum.values) degree.logo,
          for (final skill in <TechStackItem>[
            ...FlutterStackEnum.values,
            ...DevStackEnum.values,
            ...ComplementaryStackEnum.values,
          ])
            skill.image,
          for (final icon in IconEnum.values) icon.path,
          for (final animation in AnimationEnum.values) animation.path,
          for (final photo in MeEnum.values) photo.path,
        ]),
      );
    },
  );
}
