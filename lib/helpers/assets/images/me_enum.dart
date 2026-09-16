enum MeEnum {
  ai,
  paint,
  casual,
  matrix,
  software;

  String get path => 'assets/images/me/${name.toLowerCase()}.png';
}
