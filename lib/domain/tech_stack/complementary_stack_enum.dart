import 'package:flutter/material.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';

enum ComplementaryStackEnum implements TechStackItem {
  bash,
  cpp,
  git,
  github,
  postman;

  @override
  String get image => 'assets/images/logos/tech_stack/${name.toLowerCase().replaceAll(' ', '_')}.png';

  @override
  String get description {
    return switch (this) {
      ComplementaryStackEnum.bash =>
        'Unix shell and command language for system administration and scripting',
      ComplementaryStackEnum.cpp =>
        'High-performance programming language for systems and performance-critical applications',
      ComplementaryStackEnum.git =>
        'Distributed version control system for tracking code changes',
      ComplementaryStackEnum.github =>
        'Platform for version control, collaboration, and development workflow',
      ComplementaryStackEnum.postman =>
        'API development and testing tool for REST and GraphQL APIs',
    };
  }

  @override
  String get name {
    return switch (this) {
      ComplementaryStackEnum.bash => 'Bash',
      ComplementaryStackEnum.cpp => 'C++',
      ComplementaryStackEnum.git => 'Git',
      ComplementaryStackEnum.github => 'GitHub',
      ComplementaryStackEnum.postman => 'Postman',
    };
  }

  @override
  Color get color {
    return switch (this) {
      ComplementaryStackEnum.bash => const Color(0xFF4EAA25),
      ComplementaryStackEnum.cpp => const Color(0xFF00599C),
      ComplementaryStackEnum.git => const Color(0xFFF1502F),
      ComplementaryStackEnum.github => const Color(0xFF181717),
      ComplementaryStackEnum.postman => const Color(0xFFFF6C37),
    };
  }
}
