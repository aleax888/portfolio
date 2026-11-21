import 'package:portfolio/domain/education/certifications/certification_item.dart';

enum PlatziCertificationEnum implements CertificationItem {
  django(
    name: 'Curso de Django',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/9574-course/diploma/detalle/',
    duration: '22 horas',
  ),
  pensamientoCriticoIa(
    name: 'Curso de Pensamiento Crítico para usar Inteligencia Artificial',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/13070-course/diploma/detalle/',
    duration: '14 horas',
  ),
  flutterModulosnativos(
    name: 'Curso de Integración Módulos Nativos iOS/Android para Flutter',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/12038-course/diploma/detalle/',
    duration: '17 horas',
  ),
  promptEngineering(
    name: 'Curso de Prompt Engineering',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/12323-course/diploma/detalle/',
    duration: '13 horas',
  ),
  reactAvanzado(
    name: 'Curso de React Avanzado',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/11223-course/diploma/detalle/',
    duration: '16 horas',
  ),
  flutterFirebase(
    name: 'Curso de Flutter con Firebase',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/11883-course/diploma/detalle/',
    duration: '19 horas',
  ),
  flutter(
    name: 'Curso de Flutter',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/11256-course/diploma/detalle/',
    duration: '18 horas',
  ),
  cPlusPlusPoo(
    name: 'Curso de Programación Orientada a Objetos con C++',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/2373-course/diploma/detalle/',
    duration: '12 horas',
  ),
  cPlusPlus(
    name: 'Curso de C++ Básico',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/2372-course/diploma/detalle/',
    duration: '14 horas',
  ),
  cPlusPlusPractico(
    name: 'Curso Práctico de C++',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/1545-course/diploma/detalle/',
    duration: '23 horas',
  ),
  optimizacionSQLServer(
    name: 'Curso de Optimización de Bases de Datos en SQL Server',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/2179-course/diploma/detalle/',
    duration: '17 horas',
  ),
  gitGitHub(
    name: 'Curso de Git y GitHub',
    link:
        'https://platzi.com/p/alex.maglio.neyra.herrada/curso/11059-course/diploma/detalle/',
    duration: '24 horas',
  );

  const PlatziCertificationEnum({
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
  String get issuedBy => 'Platzi';
}
