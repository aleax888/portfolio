enum MeEnum {
  ai,
  paint,
  casual,
  matrix,
  software;

  String get path {
    final extension = this == ai || this == software ? 'webp' : 'png';
    return 'assets/images/me/$name.$extension';
  }
}
