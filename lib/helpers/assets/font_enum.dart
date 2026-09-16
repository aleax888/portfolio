enum FontEnum {
  bebasNeueRegular;

  String get path =>
      'assets/fonts/${name.toLowerCase().replaceAll(' ', '_')}.ttf';

  String get name {
    switch (this) {
      case FontEnum.bebasNeueRegular:
        return 'Bebas Neue Regular';
    }
  }
}
