import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';

class CornerBorderContainer extends StatelessWidget {
  const CornerBorderContainer({
    super.key,
    required this.child,
    this.color = ColorPaletteConstants.quinary,
    this.strokeWidth = 3.0,
    this.cornerRadius = 0.0,
    this.cornerLengthPercent = 0.25,
  }) : assert(
         cornerLengthPercent > 0 && cornerLengthPercent < 0.5,
         'cornerLengthPercent debe estar entre 0 y 0.5',
       );

  final Widget child;

  /// Color de las esquinas
  final Color color;

  /// Grosor del trazo
  final double strokeWidth;

  /// Radio de redondeo de las esquinas
  final double cornerRadius;

  /// Porcentaje del lado que ocupa cada esquina (0.0 – 0.49)
  final double cornerLengthPercent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: CustomPaint(
            painter: _CornerBorderPainter(
              color: color,
              strokeWidth: strokeWidth,
              cornerRadius: cornerRadius,
              cornerLengthPercent: cornerLengthPercent,
            ),
            child: Container(),
          ),
        ),
      ],
    );
  }
}

class _CornerBorderPainter extends CustomPainter {
  _CornerBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.cornerRadius,
    required this.cornerLengthPercent,
  });

  final Color color;
  final double strokeWidth;
  final double cornerRadius;
  final double cornerLengthPercent;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final r = cornerRadius.clamp(0, size.shortestSide / 2);
    final lx = (size.width / 2 - r) * cornerLengthPercent;
    final ly = (size.height / 2 - r) * cornerLengthPercent;

    _drawCorner(canvas, paint, size, lx, ly, r.toDouble(), 1, 1); // top-left
    _drawCorner(canvas, paint, size, lx, ly, r.toDouble(), -1, 1); // top-right
    _drawCorner(
      canvas,
      paint,
      size,
      lx,
      ly,
      r.toDouble(),
      1,
      -1,
    ); // bottom-left
    _drawCorner(
      canvas,
      paint,
      size,
      lx,
      ly,
      r.toDouble(),
      -1,
      -1,
    ); // bottom-right
  }

  void _drawCorner(
    Canvas canvas,
    Paint paint,
    Size size,
    double lx,
    double ly,
    double r,
    double sx,
    double sy, // signos de dirección: +1 o -1
  ) {
    final ox = sx > 0 ? 0.0 : size.width;
    final oy = sy > 0 ? 0.0 : size.height;

    final path = Path()
      ..moveTo(ox + sx * (r + lx), oy + sy * r)
      ..lineTo(ox + sx * r, oy + sy * r)
      ..arcToPoint(
        Offset(ox + sx * r, oy + sy * (r + ly)),
        radius: Radius.circular(r),
        clockwise: sx == sy, // sentido correcto según la esquina
      )
      ..lineTo(ox + sx * r, oy + sy * (r + ly));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerBorderPainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.cornerRadius != cornerRadius ||
      old.cornerLengthPercent != cornerLengthPercent;
}
