import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/design_system/styles/text_styles.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: BackgroundColorConstants.dark,
    textTheme: TextTheme(
      displayLarge: TextStyleConstants.displayLarge,
      displayMedium: TextStyleConstants.displayMedium,
      displaySmall: TextStyleConstants.displaySmall,
      headlineLarge: TextStyleConstants.headlineLarge,
      headlineMedium: TextStyleConstants.headlineMedium,
      headlineSmall: TextStyleConstants.headlineSmall,
      titleLarge: TextStyleConstants.titleLarge,
      titleMedium: TextStyleConstants.titleMedium,
      titleSmall: TextStyleConstants.titleSmall,
      bodyLarge: TextStyleConstants.bodyLarge,
      bodyMedium: TextStyleConstants.bodyMedium,
      bodySmall: TextStyleConstants.bodySmall,
      labelLarge: TextStyleConstants.labelLarge,
      labelMedium: TextStyleConstants.labelMedium,
      labelSmall: TextStyleConstants.labelSmall,
    ),

    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: ColorPaletteConstants.primary,
      secondary: ColorPaletteConstants.secondary,
      surface: ColorPaletteConstants.tertiary,
      error: SemaphoreColorConstants.error,
      onPrimary: TextColorConstants.light,
      onSecondary: TextColorConstants.light,
      onSurface: TextColorConstants.light,
      onError: TextColorConstants.light,
    ),
  );
}
