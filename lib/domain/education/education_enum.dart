enum EducationEnum {
  unsa(
    name: 'UNSA',
    fileName: 'unsa.png',
    fullName: 'Universidad Nacional de San Agustín',
    description: 'Focused on AI (In progress)',
    degree: 'Master of Science in Computer Science',
    period: '2025 - PRESENT',
  ),
  ucsp(
    name: 'UCSP',
    fileName: 'ucsp.png',
    fullName: 'Universidad Católica de San Pablo',
    description: 'Focused on Software Engineering and AI',
    degree: 'Bachelor of Science in Computer Science',
    period: '2018 - 2023',
  );

  const EducationEnum({
    required this.name,
    required this.fileName,
    required this.fullName,
    required this.description,
    required this.degree,
    required this.period,
  });

  final String name;
  final String fileName;
  final String fullName;
  final String description;
  final String degree;
  final String period;

  String get logo => 'assets/images/logos/education/$fileName';
}
