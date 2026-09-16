import 'package:portfolio/domain/education/certifications/certification_item.dart';

enum UniCertificationEnum implements CertificationItem {
  cloud,
  scrum,
  linux;

  @override
  String get issuedBy => 'UNIVERSIDAD NACIONAL DE INGENIERÍA';

  @override
  String get name {
    switch (this) {
      case UniCertificationEnum.cloud:
        return 'CLOUD COMPUTING: AWS - Azure - Google Cloud';
      case UniCertificationEnum.scrum:
        return 'Fundamentos de Gestión de Proyectos bajo el enfoque Scrum';
      case UniCertificationEnum.linux:
        return 'Fundamentos de Linux';
    }
  }

  @override
  String get link {
    switch (this) {
      case UniCertificationEnum.cloud:
        return 'https://certificados.uni.edu.pe/verificador/search.php?cert_id=cert_6ca0a49be13ecf1e3eff0a9d231ca232';
      case UniCertificationEnum.scrum:
        return 'https://certificados.uni.edu.pe/verificador/search.php?cert_id=cert_54475e4b8eb8c557a52bfed9a8bb65d4';
      case UniCertificationEnum.linux:
        return 'https://certificados.uni.edu.pe/verificador/search.php?cert_id=cert_a0264f71bf9c99fd3d5b7b6251155650';
    }
  }

  @override
  String get duration {
    switch (this) {
      case UniCertificationEnum.cloud:
        return '24 horas';
      case UniCertificationEnum.scrum:
        return '16 horas';
      case UniCertificationEnum.linux:
        return '16 horas';
    }
  }
}
