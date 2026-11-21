enum AnimationEnum {
  iPhone('iPhone', 'iphone.json'),
  bluePhone('Blue Phone', 'blue_phone.json'),
  purplePhone('Purple Phone', 'purple_phone.json'),
  purpleSimbol('Purple Simbol', 'purple_simbol.json');

  const AnimationEnum(this.name, this.fileName);

  final String name;
  final String fileName;

  String get path => 'assets/animations/$fileName';
}
