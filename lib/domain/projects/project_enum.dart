enum ProjectEnum {
  ledPanel(
    name: 'Led Panel',
    fileName: 'led_panel.webp',
    description:
        'LED displays to life with playful marquee-style animations and customizable.',
    technologies: ['Flutter'],
    link: 'https://github.com/aleax888/led_panel',
  ),
  gymFlow(
    name: 'GymFlow',
    fileName: 'gymflow.webp',
    description:
        'A smart fitness app that analyzes body joints in real time to automatically detect movements and count exercise repetitions.',
    technologies: ['Flutter', 'TensorFlow Lite'],
    link: 'https://www.google.com/search?q=comming+soon&oq=comming+soon',
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
