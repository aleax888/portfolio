enum ProjectEnum {
  ledPanel(
    name: 'Led Panel',
    fileName: 'led_panel.webp',
    description:
        'LED displays to life with playful marquee-style animations and customizable.',
    technologies: ['Flutter'],
    link: 'https://github.com/aleax888/led_panel',
  ),
  cvGenerator(
    name: 'CV Generator',
    fileName: 'cv_generator.webp',
    description:
        'A modern CV generator that enhances your professional profile using local AI.',
    technologies: ['Python', 'Jinja2', 'Ollama'],

    link: 'https://github.com/aleax888/ai_powered_latex_cv_generator',
  ),
  textArt(
    name: 'Text art',
    fileName: 'text_art.webp',
    description:
        'Upload a picture and watch it transform into detailed text art.',
    technologies: ['Python', 'FastAPI', 'OpenCV'],
    link: 'https://github.com/aleax888/img_to_text_art',
  );

  const ProjectEnum({
    required this.name,
    required this.fileName,
    required this.description,
    required this.technologies,
    required this.link,
  });

  final String name;
  final String fileName;
  final String description;
  final List<String> technologies;
  final String link;

  String get image => 'assets/images/projects/$fileName';
}
