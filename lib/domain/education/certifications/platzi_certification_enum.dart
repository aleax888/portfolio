import 'package:portfolio/domain/education/certifications/certification_item.dart';

enum PlatziCertificationEnum implements CertificationItem {
  django,
  pensamientoCriticoIa,
  flutterModulosnativos,
  promptEngineering,
  reactAvanzado,
  flutterFirebase,
  flutter,
  cPlusPlusPoo,
  cPlusPlus,
  cPlusPlusPractico,
  optimizacionSQLServer,
  gitGitHub;

  @override
  String get issuedBy => 'Platzi';

  @override
  String get name {
    switch (this) {
      case PlatziCertificationEnum.django:
        return 'Curso de Django';
      case PlatziCertificationEnum.pensamientoCriticoIa:
        return 'Curso de Pensamiento Crítico para usar Inteligencia Artificial';
      case PlatziCertificationEnum.flutterModulosnativos:
        return 'Curso de Integración Módulos Nativos iOS/Android para Flutter';
      case PlatziCertificationEnum.promptEngineering:
        return 'Curso de Prompt Engineering';
      case PlatziCertificationEnum.reactAvanzado:
        return 'Curso de React Avanzado';
      case PlatziCertificationEnum.flutterFirebase:
        return 'Curso de Flutter con Firebase';
      case PlatziCertificationEnum.flutter:
        return 'Curso de Flutter';
      case PlatziCertificationEnum.cPlusPlusPoo:
        return 'Curso de Programación Orientada a Objetos con C++';
      case PlatziCertificationEnum.cPlusPlus:
        return 'Curso de C++ Básico';
      case PlatziCertificationEnum.cPlusPlusPractico:
        return 'Curso Práctico de C++';
      case PlatziCertificationEnum.optimizacionSQLServer:
        return 'Curso de Optimización de Bases de Datos en SQL Server';
      case PlatziCertificationEnum.gitGitHub:
        return 'Curso de Git y GitHub';
    }
  }

  @override
  String get link {
    switch (this) {
      case PlatziCertificationEnum.django:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/9574-course/diploma/detalle/';
      case PlatziCertificationEnum.pensamientoCriticoIa:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/13070-course/diploma/detalle/';
      case PlatziCertificationEnum.flutterModulosnativos:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/12038-course/diploma/detalle/';
      case PlatziCertificationEnum.promptEngineering:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/12323-course/diploma/detalle/';
      case PlatziCertificationEnum.reactAvanzado:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/11223-course/diploma/detalle/';
      case PlatziCertificationEnum.flutterFirebase:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/11883-course/diploma/detalle/';
      case PlatziCertificationEnum.flutter:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/11256-course/diploma/detalle/';
      case PlatziCertificationEnum.cPlusPlusPoo:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/2373-course/diploma/detalle/';
      case PlatziCertificationEnum.cPlusPlus:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/2372-course/diploma/detalle/';
      case PlatziCertificationEnum.cPlusPlusPractico:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/1545-course/diploma/detalle/';
      case PlatziCertificationEnum.optimizacionSQLServer:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/2179-course/diploma/detalle/';
      case PlatziCertificationEnum.gitGitHub:
        return 'https://platzi.com/p/alex.maglio.neyra.herrada/curso/11059-course/diploma/detalle/';
    }
  }

  @override
  String get duration {
    switch (this) {
      case PlatziCertificationEnum.django:
        return '22 horas';
      case PlatziCertificationEnum.pensamientoCriticoIa:
        return '14 horas';
      case PlatziCertificationEnum.flutterModulosnativos:
        return '17 horas';
      case PlatziCertificationEnum.promptEngineering:
        return '13 horas';
      case PlatziCertificationEnum.reactAvanzado:
        return '16 horas';
      case PlatziCertificationEnum.flutterFirebase:
        return '19 horas';
      case PlatziCertificationEnum.flutter:
        return '18 horas';
      case PlatziCertificationEnum.cPlusPlusPoo:
        return '12 horas';
      case PlatziCertificationEnum.cPlusPlus:
        return '14 horas';
      case PlatziCertificationEnum.cPlusPlusPractico:
        return '23 horas';
      case PlatziCertificationEnum.optimizacionSQLServer:
        return '17 horas';
      case PlatziCertificationEnum.gitGitHub:
        return '24 horas';
    }
  }
}
