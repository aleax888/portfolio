enum IconEnum {
  github,
  linkedin,
  whatsapp;

  String get path =>
      'assets/icons/${name.toLowerCase().replaceAll(' ', '_')}.png';

  String get name {
    switch (this) {
      case IconEnum.github:
        return 'GitHub';
      case IconEnum.linkedin:
        return 'LinkedIn';
      case IconEnum.whatsapp:
        return 'WhatsApp';
    }
  }
}
