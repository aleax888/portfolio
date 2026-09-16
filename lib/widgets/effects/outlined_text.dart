import 'package:flutter/material.dart';

/// Widget para renderizar texto con:
/// - borde (stroke)
/// - relleno independiente
///
/// Ideal para títulos, headers, efectos visuales y branding.
class OutlinedText extends StatelessWidget {
  /// Texto a mostrar
  final String text;

  /// Tamaño de fuente
  final double fontSize;

  /// Color del relleno
  final Color fillColor;

  /// Color del borde
  final Color strokeColor;

  /// Grosor del borde
  final double strokeWidth;

  /// Peso de fuente
  final FontWeight fontWeight;

  /// Familia tipográfica
  final String? fontFamily;

  /// Alineación del texto
  final TextAlign textAlign;

  /// Espaciado entre letras
  final double? letterSpacing;

  /// Altura de línea
  final double? height;

  /// Máximo de líneas
  final int? maxLines;

  /// Overflow behavior
  final TextOverflow? overflow;

  const OutlinedText({
    super.key,
    required this.text,
    this.fontSize = 32,
    this.fillColor = Colors.transparent,
    this.strokeColor = Colors.black,
    this.strokeWidth = 0.5,
    this.fontWeight = FontWeight.bold,
    this.fontFamily,
    this.textAlign = TextAlign.center,
    this.letterSpacing,
    this.height,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Capa del borde
        Text(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            letterSpacing: letterSpacing,
            height: height,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),

        /// Capa del relleno
        Text(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: fontFamily,
            letterSpacing: letterSpacing,
            height: height,
            color: fillColor,
          ),
        ),
      ],
    );
  }
}
