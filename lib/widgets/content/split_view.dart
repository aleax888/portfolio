import 'package:flutter/material.dart';

/// Un widget que divide el espacio disponible entre dos hijos [left] y [right].
///
/// Parámetros:
/// - [left]        : Widget del lado izquierdo (o superior en modo columna).
/// - [right]       : Widget del lado derecho (o inferior en modo columna).
/// - [split]       : Proporción que ocupa [left], valor entre 0.0 y 1.0.
///                   Por defecto 0.5 (50/50).
/// - [gap]         : Espacio entre ambos widgets, en puntos lógicos. Default 16.
/// - [breakpoint]  : Ancho mínimo en píxeles lógicos para mostrar layout en fila.
///                   Por debajo de este valor, los widgets se apilan verticalmente
///                   y cada uno ocupa el 100% del ancho. Default 600.
class SplitView extends StatelessWidget {
  const SplitView({
    super.key,
    required this.left,
    required this.right,
    this.split = 0.5,
    this.gap = 16.0,
    this.breakpoint = 600.0,
  }) : assert(split >= 0.0 && split <= 1.0, 'split debe estar entre 0.0 y 1.0');

  final Widget left;
  final Widget right;

  /// Proporción del ancho total asignada al widget [left].
  /// El widget [right] recibe el complemento (1 - split).
  final double split;

  /// Espacio en píxeles lógicos entre [left] y [right].
  final double gap;

  /// Umbral de ancho en píxeles lógicos. Por debajo → layout en columna.
  final double breakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < breakpoint;

        if (isNarrow) {
          return _buildColumn();
        }

        return _buildRow(constraints.maxWidth);
      },
    );
  }

  /// Layout horizontal: left ocupa [split]%, right ocupa el resto.
  Widget _buildRow(double totalWidth) {
    // El gap se descuenta del ancho total antes de repartir.
    final availableWidth = totalWidth - gap;
    final leftWidth = availableWidth * split;
    final rightWidth = availableWidth * (1 - split);

    return Row(
      children: [
        SizedBox(width: leftWidth, child: left),
        SizedBox(width: gap),
        SizedBox(width: rightWidth, child: right),
      ],
    );
  }

  /// Layout vertical: ambos ocupan el 100% del ancho disponible.
  Widget _buildColumn() {
    return Column(
      spacing: gap,
      crossAxisAlignment: .stretch,
      mainAxisSize: MainAxisSize.min,
      children: [left, right],
    );
  }
}
