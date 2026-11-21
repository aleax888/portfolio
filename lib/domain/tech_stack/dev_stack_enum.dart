import 'package:flutter/material.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';

enum DevStackEnum with TechStackItem {
  react(
    name: 'React',
    fileName: 'react.png',
    description:
        'JavaScript library for building user interfaces with component-based architecture',
    color: Color(0xFF61DAFB),
  ),
  node(
    name: 'Node.js',
    fileName: 'node.js.png',
    description:
        'JavaScript runtime for server-side development and backend services',
    color: Color(0xFF68A063),
  ),
  fastapi(
    name: 'FastAPI',
    fileName: 'fastapi.png',
    description:
        'Modern Python web framework for building high-performance APIs',
    color: Color(0xFF009688),
  ),
  django(
    name: 'Django',
    fileName: 'django.png',
    description:
        'High-level Python web framework for rapid development and clean design',
    color: Color(0xFF092E20),
  ),
  postgresql(
    name: 'PostgreSQL',
    fileName: 'postgresql.png',
    description:
        'Powerful open-source relational database with advanced features',
    color: Color(0xFF336791),
  ),
  sqlserver(
    name: 'SQL Server',
    fileName: 'sql_server.png',
    description:
        'Microsoft\'s enterprise relational database management system',
    color: Color(0xFFCC2927),
  );

  const DevStackEnum({
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
