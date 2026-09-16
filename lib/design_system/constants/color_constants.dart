import 'dart:ui';

class ColorPaletteConstants {
  const ColorPaletteConstants._();

  static const Color primary = Color(0xFF1E202C);
  static const Color secondary = Color(0xFF693B93);
  static const Color tertiary = Color(0xFF763CAC);
  static const Color quaternary = Color(0xFF3EA868);
  static const Color quinary = Color(0xFF00E5A0);
}

class BasicColorConstants {
  const BasicColorConstants._();

  static const Color black = Color(0xFF000000);
  static const Color gray = Color(0xFF909090);
  static const Color white = Color(0xFFFFFFFF);
}

class BackgroundColorConstants {
  const BackgroundColorConstants._();

  static const Color dark = Color(0xFF11071F);
  static const Color light = ColorPaletteConstants.quaternary;
}

class SemaphoreColorConstants {
  const SemaphoreColorConstants._();

  static const Color success = Color(0xFF00E5A0);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFFF5722);
  static const Color info = Color(0xFF2196F3);
  static const Color disabled = Color(0xFF909090);
}
