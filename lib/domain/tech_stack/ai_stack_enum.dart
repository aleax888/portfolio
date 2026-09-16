import 'package:flutter/material.dart';
import 'package:portfolio/domain/tech_stack/tech_stack_item.dart';

enum AIStackEnum implements TechStackItem {
  claude,
  chatgpt,
  gemini,
  copilot,
  llama;

  @override
  String get image => 'assets/images/logos/tech_stack/${name.toLowerCase().replaceAll(' ', '_')}.png';

  @override
  String get description {
    return switch (this) {
      AIStackEnum.claude =>
        'Advanced AI assistant by Anthropic with strong reasoning and code understanding',
      AIStackEnum.chatgpt =>
        'Conversational AI by OpenAI for diverse tasks and creative problem-solving',
      AIStackEnum.gemini =>
        'Google\'s multimodal AI model supporting text, code, and reasoning',
      AIStackEnum.copilot =>
        'GitHub\'s AI-powered code completion and suggestion tool',
      AIStackEnum.llama =>
        'Meta\'s open-source large language model for customizable AI solutions',
    };
  }

  @override
  String get name {
    return switch (this) {
      AIStackEnum.claude => 'Claude',
      AIStackEnum.chatgpt => 'ChatGPT',
      AIStackEnum.gemini => 'Gemini',
      AIStackEnum.copilot => 'Copilot',
      AIStackEnum.llama => 'Llama',
    };
  }

  @override
  Color get color {
    return switch (this) {
      AIStackEnum.claude => const Color(0xFF9D5D0D),
      AIStackEnum.chatgpt => const Color(0xFF10A37F),
      AIStackEnum.gemini => const Color(0xFF8E7CC3),
      AIStackEnum.copilot => const Color(0xFF0B57D8),
      AIStackEnum.llama => const Color(0xFFFFD21E),
    };
  }
}
