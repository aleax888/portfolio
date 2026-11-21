import 'package:portfolio/domain/education/certifications/certification_item.dart';

enum AnthropicCertificationEnum implements CertificationItem {
  claude101(
    name: 'Claude 101',
    link: 'https://verify.skilljar.com/c/fy27sdxmevvr',
  ),
  claudeCode101(
    name: 'Claude Code 101',
    link: 'https://verify.skilljar.com/c/fouvdjqi2evv',
  );

  const AnthropicCertificationEnum({required this.name, required this.link});

  @override
  final String name;
  @override
  final String link;

  @override
  String get issuedBy => 'Anthropic';

  @override
  String? get duration => null;
}
