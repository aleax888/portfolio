import 'package:flutter/material.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';

enum DevStackEnum implements TechStackItem {
  react,
  node,
  fastapi,
  django,
  postgresql,
  sqlserver;

  @override
  String get image =>
      'assets/images/logos/tech_stack/${name.toLowerCase().replaceAll(' ', '_')}.png';

  @override
  String get description {
    return switch (this) {
      DevStackEnum.react =>
        'JavaScript library for building user interfaces with component-based architecture',
      DevStackEnum.node =>
        'JavaScript runtime for server-side development and backend services',
      DevStackEnum.fastapi =>
        'Modern Python web framework for building high-performance APIs',
      DevStackEnum.django =>
        'High-level Python web framework for rapid development and clean design',
      DevStackEnum.postgresql =>
        'Powerful open-source relational database with advanced features',
      DevStackEnum.sqlserver =>
        'Microsoft\'s enterprise relational database management system',
    };
  }

  @override
  String get name {
    return switch (this) {
      DevStackEnum.react => 'React',
      DevStackEnum.node => 'Node.js',
      DevStackEnum.fastapi => 'FastAPI',
      DevStackEnum.django => 'Django',
      DevStackEnum.postgresql => 'PostgreSQL',
      DevStackEnum.sqlserver => 'SQL Server',
    };
  }

  @override
  Color get color {
    return switch (this) {
      DevStackEnum.react => const Color(0xFF61DAFB),
      DevStackEnum.node => const Color(0xFF68A063),
      DevStackEnum.fastapi => const Color(0xFF009688),
      DevStackEnum.django => const Color(0xFF092E20),
      DevStackEnum.postgresql => const Color(0xFF336791),
      DevStackEnum.sqlserver => const Color(0xFFCC2927),
    };
  }
}
