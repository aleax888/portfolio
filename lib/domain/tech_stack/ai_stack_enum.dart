import 'package:flutter/material.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';

enum AIStackEnum with TechStackItem {
  claude(
    name: 'Claude',
    fileName: 'claude.png',
    description:
        'Advanced AI assistant by Anthropic with strong reasoning and code understanding',
    color: Color(0xFF9D5D0D),
  ),
  chatgpt(
    name: 'ChatGPT',
    fileName: 'chatgpt.png',
    description:
        'Conversational AI by OpenAI for diverse tasks and creative problem-solving',
    color: Color(0xFF10A37F),
  ),
  gemini(
    name: 'Gemini',
    fileName: 'gemini.png',
    description:
        'Google\'s multimodal AI model supporting text, code, and reasoning',
    color: Color(0xFF8E7CC3),
  ),
  copilot(
    name: 'Copilot',
    fileName: 'copilot.png',
    description: 'GitHub\'s AI-powered code completion and suggestion tool',
    color: Color(0xFF0B57D8),
  ),
  llama(
    name: 'Llama',
    fileName: 'llama.png',
    description:
        'Meta\'s open-source large language model for customizable AI solutions',
    color: Color(0xFFFFD21E),
  );

  const AIStackEnum({
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
