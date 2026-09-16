enum EducationEnum {
  unsa,
  ucsp;

  String get logo =>
      'assets/images/logos/education/${name.toLowerCase().replaceAll(' ', '_')}.png';

  String get name {
    switch (this) {
      case EducationEnum.unsa:
        return 'UNSA';
      case EducationEnum.ucsp:
        return 'UCSP';
    }
  }

  String get fullName {
    switch (this) {
      case EducationEnum.unsa:
        return 'Universidad Nacional de San Agustín';
      case EducationEnum.ucsp:
        return 'Universidad Católica de San Pablo';
    }
  }

  String get description {
    switch (this) {
      case EducationEnum.unsa:
        return 'Focused on AI (In progress)';
      case EducationEnum.ucsp:
        return 'Focused on Software Engineering and AI';
    }
  }

  String get degree {
    switch (this) {
      case EducationEnum.unsa:
        return 'Master of Science in Computer Science';
      case EducationEnum.ucsp:
        return 'Bachelor of Science in Computer Science';
    }
  }

  String get period {
    switch (this) {
      case EducationEnum.unsa:
        return '2025 - PRESENT';
      case EducationEnum.ucsp:
        return '2018 - 2023';
    }
  }
}
