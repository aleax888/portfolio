enum FontEnum {
  bebasNeueRegular('Bebas Neue Regular', 'bebas_neue_regular.ttf');

  const FontEnum(this.name, this.fileName);

  final String name;
  final String fileName;

  String get path => 'assets/fonts/$fileName';
}
