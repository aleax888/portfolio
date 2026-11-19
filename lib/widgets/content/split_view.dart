import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/widgets/layout/viewport_orientation_builder.dart';

/// Un widget que divide el espacio disponible entre dos hijos [left] y [right].
///
/// Parámetros:
/// - [left]        : Widget del lado izquierdo (o superior en modo columna).
/// - [right]       : Widget del lado derecho (o inferior en modo columna).
/// - [split]       : Proporción que ocupa [left], valor entre 0.0 y 1.0.
///                   Por defecto 0.5 (50/50).
/// - [gap]         : Espacio entre ambos widgets, en puntos lógicos. Usa el espaciado del sistema de diseño.
/// Apila los hijos si la pantalla es más alta que ancha.
class SplitView extends StatelessWidget {
  const SplitView({
    super.key,
    required this.left,
    required this.right,
    this.split = 0.5,
    this.gap = SpacingConstants.s,
    this.expandBottom = false,
  }) : assert(split >= 0.0 && split <= 1.0, 'split debe estar entre 0.0 y 1.0');

  final Widget left;
  final Widget right;

  /// Proporción del ancho total asignada al widget [left].
  /// El widget [right] recibe el complemento (1 - split).
  final double split;

  /// Espacio en píxeles lógicos entre [left] y [right].
  final double gap;

  /// En columna, asigna al segundo hijo la altura restante si está acotada.
  final bool expandBottom;

  @override
  Widget build(BuildContext context) {
    return ViewportOrientationBuilder(
      builder: (context, orientation) => LayoutBuilder(
        builder: (context, constraints) => orientation == .portrait
            ? _buildColumn(expandBottom && constraints.hasBoundedHeight)
            : _buildRow(constraints.maxWidth),
      ),
    );
  }

  /// Layout horizontal: left ocupa [split]%, right ocupa el resto.
  Widget _buildRow(double totalWidth) {
    // El gap se descuenta del ancho total antes de repartir.
    final availableWidth = totalWidth - gap;
    final leftWidth = availableWidth * split;
    final rightWidth = availableWidth * (1 - split);

    return Row(
      spacing: gap,
      crossAxisAlignment: .start,
      children: [
        SizedBox(width: leftWidth, child: left),
        SizedBox(width: rightWidth, child: right),
      ],
    );
  }

  /// Layout vertical: ambos ocupan el 100% del ancho disponible.
  Widget _buildColumn(bool fillRemainingHeight) {
    return Column(
      spacing: gap,
      crossAxisAlignment: .stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        left,
        if (fillRemainingHeight) Expanded(child: right) else right,
      ],
    );
  }
}
