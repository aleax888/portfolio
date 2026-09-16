enum ExperienceEnum {
  cerv,
  navia,
  innovaSolutions;

  String get name {
    switch (this) {
      case ExperienceEnum.cerv:
        return 'Cerv';
      case ExperienceEnum.navia:
        return 'Navia';
      case ExperienceEnum.innovaSolutions:
        return 'Innova Solutions';
    }
  }

  String get description {
    switch (this) {
      case ExperienceEnum.cerv:
        return 'Specialized in solving complex cross-platform challenges, from critical alert systems to multi-app mobile deployments, turning technical roadblocks into production-ready solutions.';
      case ExperienceEnum.navia:
        return 'Evolved into a full-stack role by independently delivering complete features and streamlining development workflows through code generation and automation.';
      case ExperienceEnum.innovaSolutions:
        return 'Consolidated an entire field sales ecosystem into a single mobile application, streamlining operations, optimizing routes, and enabling data-driven decision making for sales representatives.';
    }
  }

  String get position {
    switch (this) {
      case ExperienceEnum.cerv:
        return 'Senior Mobile Engineer';
      case ExperienceEnum.navia:
        return 'Full-Stack Engineer';
      case ExperienceEnum.innovaSolutions:
        return 'Mobile Engineer';
    }
  }

  String get begin {
    switch (this) {
      case ExperienceEnum.cerv:
        return '2026 JAN';
      case ExperienceEnum.navia:
        return '2025 JUL';
      case ExperienceEnum.innovaSolutions:
        return '2024 JAN';
    }
  }

  String get end {
    switch (this) {
      case ExperienceEnum.cerv:
        return '2026 JUL';
      case ExperienceEnum.navia:
        return '2026 JAN';
      case ExperienceEnum.innovaSolutions:
        return '2025 JUN';
    }
  }

  int get durationInMonths {
    switch (this) {
      case ExperienceEnum.cerv:
        return 6;
      case ExperienceEnum.navia:
        return 6;
      case ExperienceEnum.innovaSolutions:
        return 18;
    }
  }

  List<String> get technologies {
    switch (this) {
      case ExperienceEnum.cerv:
        return ['Flutter', 'React', 'FastAPI', 'AWS'];
      case ExperienceEnum.navia:
        return ['Flutter', 'FastAPI'];
      case ExperienceEnum.innovaSolutions:
        return ['Flutter', 'React'];
    }
  }
}
