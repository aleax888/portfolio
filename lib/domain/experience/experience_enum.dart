enum ExperienceEnum {
  cerv(
    name: 'Cerv',
    description:
        'Specialized in solving complex cross-platform challenges, from critical alert systems to multi-app mobile deployments, turning technical roadblocks into production-ready solutions.',
    position: 'Full-Stack Engineer',
    begin: '2026 JAN',
    end: '2026 JUL',
    durationInMonths: 6,
    technologies: ['Flutter', 'React', 'FastAPI', 'AWS'],
  ),
  navia(
    name: 'Navia',
    description:
        'Evolved into a full-stack role by independently delivering complete features and streamlining development workflows through code generation and automation.',
    position: 'Full-Stack Engineer',
    begin: '2025 JUL',
    end: '2026 JAN',
    durationInMonths: 6,
    technologies: ['Flutter', 'FastAPI'],
  ),
  innovaSolutions(
    name: 'Innova Solutions',
    description:
        'Consolidated an entire field sales ecosystem into a single mobile application, streamlining operations, optimizing routes, and enabling data-driven decision making for sales representatives.',
    position: 'Mobile Engineer',
    begin: '2024 JAN',
    end: '2025 JUN',
    durationInMonths: 18,
    technologies: ['Flutter', 'React'],
  );

  const ExperienceEnum({
    required this.name,
    required this.description,
    required this.position,
    required this.begin,
    required this.end,
    required this.durationInMonths,
    required this.technologies,
  });

  final String name;
  final String description;
  final String position;
  final String begin;
  final String end;
  final int durationInMonths;
  final List<String> technologies;
}
