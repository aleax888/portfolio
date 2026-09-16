import 'package:flutter/material.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';

enum FlutterStackEnum implements TechStackItem {
  dart,
  flutter,
  bloc,
  mason,
  melos,
  firebase;

  @override
  String get image => 'assets/images/logos/tech_stack/${name.toLowerCase().replaceAll(' ', '_')}.png';

  @override
  String get description {
    return switch (this) {
      FlutterStackEnum.dart =>
        'Programming language optimized for fast apps on any platform',
      FlutterStackEnum.flutter =>
        'Cross-platform mobile framework for building beautiful native applications',
      FlutterStackEnum.bloc =>
        'State management library implementing the BLoC pattern',
      FlutterStackEnum.mason =>
        'Dart template generator for creating reusable code templates',
      FlutterStackEnum.melos => 'Tool for managing Dart monorepos',
      FlutterStackEnum.firebase =>
        'Google\'s platform for building web and mobile apps',
    };
  }

  @override
  String get name {
    return switch (this) {
      FlutterStackEnum.dart => 'Dart',
      FlutterStackEnum.flutter => 'Flutter',
      FlutterStackEnum.bloc => 'BLoC',
      FlutterStackEnum.mason => 'Mason',
      FlutterStackEnum.melos => 'Melos',
      FlutterStackEnum.firebase => 'Firebase',
    };
  }

  @override
  Color get color {
    return switch (this) {
      FlutterStackEnum.dart => const Color(0xFF00D2FC),
      FlutterStackEnum.flutter => const Color(0xFF02569B),
      FlutterStackEnum.bloc => const Color(0xFF254053),
      FlutterStackEnum.mason => const Color(0xFF2196F3),
      FlutterStackEnum.melos => const Color(0xFF5C5C5C),
      FlutterStackEnum.firebase => const Color(0xFFFFA000),
    };
  }
}
