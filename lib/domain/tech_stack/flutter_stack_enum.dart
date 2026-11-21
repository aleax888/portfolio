import 'package:flutter/material.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';

enum FlutterStackEnum with TechStackItem {
  dart(
    name: 'Dart',
    fileName: 'dart.png',
    description: 'Programming language optimized for fast apps on any platform',
    color: Color(0xFF00D2FC),
  ),
  flutter(
    name: 'Flutter',
    fileName: 'flutter.png',
    description:
        'Cross-platform mobile framework for building beautiful native applications',
    color: Color(0xFF02569B),
  ),
  bloc(
    name: 'BLoC',
    fileName: 'bloc.png',
    description: 'State management library implementing the BLoC pattern',
    color: Color(0xFF254053),
  ),
  mason(
    name: 'Mason',
    fileName: 'mason.png',
    description: 'Dart template generator for creating reusable code templates',
    color: Color(0xFF2196F3),
  ),
  melos(
    name: 'Melos',
    fileName: 'melos.png',
    description: 'Tool for managing Dart monorepos',
    color: Color(0xFF5C5C5C),
  ),
  firebase(
    name: 'Firebase',
    fileName: 'firebase.png',
    description: 'Google\'s platform for building web and mobile apps',
    color: Color(0xFFFFA000),
  );

  const FlutterStackEnum({
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
