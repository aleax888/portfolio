import 'package:portfolio/domain/education/certifications/certification_item.dart';

enum UniCertificationEnum implements CertificationItem {
  cloud(
    name: 'CLOUD COMPUTING: AWS - Azure - Google Cloud',
    link:
        'https://certificados.uni.edu.pe/verificador/search.php?cert_id=cert_6ca0a49be13ecf1e3eff0a9d231ca232',
    duration: '24 horas',
  ),
  scrum(
    name: 'Fundamentos de Gestión de Proyectos bajo el enfoque Scrum',
    link:
        'https://certificados.uni.edu.pe/verificador/search.php?cert_id=cert_54475e4b8eb8c557a52bfed9a8bb65d4',
    duration: '16 horas',
  ),
  linux(
    name: 'Fundamentos de Linux',
    link:
        'https://certificados.uni.edu.pe/verificador/search.php?cert_id=cert_a0264f71bf9c99fd3d5b7b6251155650',
    duration: '16 horas',
  );

  const UniCertificationEnum({
    required this.name,
    required this.link,
    required this.duration,
  });

  @override
  final String name;
  @override
  final String link;
  @override
  final String duration;

  @override
  String get issuedBy => 'UNIVERSIDAD NACIONAL DE INGENIERÍA';
}
