enum IconEnum {
  github('GitHub', 'github.png'),
  linkedin('LinkedIn', 'linkedin.png'),
  whatsapp('WhatsApp', 'whatsapp.png');

  const IconEnum(this.name, this.fileName);

  final String name;
  final String fileName;

  String get path => 'assets/icons/$fileName';
}
