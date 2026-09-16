enum AnimationEnum {
  iPhone,
  bluePhone,
  purplePhone,
  purpleSimbol;

  String get path =>
      'assets/animations/${name.toLowerCase().replaceAll(' ', '_')}.json';

  String get name {
    switch (this) {
      case AnimationEnum.iPhone:
        return 'iPhone';
      case AnimationEnum.bluePhone:
        return 'Blue Phone';
      case AnimationEnum.purplePhone:
        return 'Purple Phone';
      case AnimationEnum.purpleSimbol:
        return 'Purple Simbol';
    }
  }
}
