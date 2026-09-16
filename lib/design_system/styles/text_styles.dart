import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';

class TextStyleConstants {
  TextStyleConstants._();

  // Display
  static const TextStyle displayLarge = TextStyle(
    fontSize: TextSizeConstants.xxl,
    fontWeight: TextWeightConstants.bold,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.primary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: TextSizeConstants.xl,
    fontWeight: TextWeightConstants.bold,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.primary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: TextSizeConstants.l,
    fontWeight: TextWeightConstants.semiBold,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.primary,
  );

  // Headline
  static const TextStyle headlineLarge = TextStyle(
    fontSize: TextSizeConstants.xl,
    fontWeight: TextWeightConstants.semiBold,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.primary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: TextSizeConstants.l,
    fontWeight: TextWeightConstants.semiBold,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.primary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: TextSizeConstants.m,
    fontWeight: TextWeightConstants.semiBold,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.primary,
  );

  // Title
  static const TextStyle titleLarge = TextStyle(
    fontSize: TextSizeConstants.m,
    fontWeight: TextWeightConstants.medium,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.primary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: TextSizeConstants.s,
    fontWeight: TextWeightConstants.medium,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.primary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: TextSizeConstants.xs,
    fontWeight: TextWeightConstants.medium,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.primary,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: TextSizeConstants.s,
    fontWeight: TextWeightConstants.regular,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.secondary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: TextSizeConstants.xs,
    fontWeight: TextWeightConstants.regular,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.secondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: TextSizeConstants.xxs,
    fontWeight: TextWeightConstants.regular,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.secondary,
  );

  // Label
  static const TextStyle labelLarge = TextStyle(
    fontSize: TextSizeConstants.s,
    fontWeight: TextWeightConstants.medium,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.secondary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: TextSizeConstants.xs,
    fontWeight: TextWeightConstants.medium,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.secondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: TextSizeConstants.xxs,
    fontWeight: TextWeightConstants.medium,
    color: TextColorConstants.light,
    fontFamily: TextFamilyConstants.secondary,
  );
}
