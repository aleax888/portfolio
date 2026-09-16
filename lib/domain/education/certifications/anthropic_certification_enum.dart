import 'package:portfolio/domain/education/certifications/certification_item.dart';

enum AnthropicCertificationEnum implements CertificationItem {
  claude101,
  claudeCode101;

  @override
  String get issuedBy => 'Anthropic';

  @override
  String get name {
    switch (this) {
      case AnthropicCertificationEnum.claude101:
        return 'Claude 101';
      case AnthropicCertificationEnum.claudeCode101:
        return 'Claude Code 101';
    }
  }

  @override
  String get link {
    switch (this) {
      case AnthropicCertificationEnum.claude101:
        return 'https://verify.skilljar.com/c/fy27sdxmevvr';
      case AnthropicCertificationEnum.claudeCode101:
        return 'https://verify.skilljar.com/c/fouvdjqi2evv';
    }
  }

  @override
  String? get duration => null;
}
