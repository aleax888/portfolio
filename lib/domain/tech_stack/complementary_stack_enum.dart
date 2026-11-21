import 'package:flutter/material.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';

enum ComplementaryStackEnum with TechStackItem {
  bash(
    name: 'Bash',
    fileName: 'bash.png',
    description:
        'Unix shell and command language for system administration and scripting',
    color: Color(0xFF4EAA25),
  ),
  cpp(
    name: 'C++',
    fileName: 'c++.png',
    description:
        'High-performance programming language for systems and performance-critical applications',
    color: Color(0xFF00599C),
  ),
  git(
    name: 'Git',
    fileName: 'git.png',
    description: 'Distributed version control system for tracking code changes',
    color: Color(0xFFF1502F),
  ),
  github(
    name: 'GitHub',
    fileName: 'github.png',
    description:
        'Platform for version control, collaboration, and development workflow',
    color: Color(0xFF181717),
  ),
  postman(
    name: 'Postman',
    fileName: 'postman.png',
    description: 'API development and testing tool for REST and GraphQL APIs',
    color: Color(0xFFFF6C37),
  );

  const ComplementaryStackEnum({
    required this.name,
    required this.fileName,
    required this.description,
    required this.color,
  });

  @override
  final String name;
  @override
  final String fileName;
  @override
  final String description;
  @override
  final Color color;
}
