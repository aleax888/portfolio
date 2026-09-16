import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';

class ShadowedContainer extends StatefulWidget {
  const ShadowedContainer({
    super.key,
    required this.child,
    this.shadowColor = ColorPaletteConstants.secondary,
    this.shadowColorEnd,
    this.shadowOpacity = 0.85,
    this.shadowBlurRadius = 200.0,
    this.shadowSpreadRadius = 0.0,
    this.shadowOffset = const Offset(0, 0),
  });

  final Widget child;
  final Color shadowColor;
  final Color? shadowColorEnd;
  final double shadowOpacity;
  final double shadowBlurRadius;
  final double shadowSpreadRadius;
  final Offset shadowOffset;

  @override
  State<ShadowedContainer> createState() => _ShadowedContainerState();
}

class _ShadowedContainerState extends State<ShadowedContainer> {
  late double _pixelRatio;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
  }

  Color _withOpacity(Color color) =>
      color.withAlpha((widget.shadowOpacity * 255).round());

  @override
  Widget build(BuildContext context) {
    final colorStart = _withOpacity(widget.shadowColor);
    final colorEnd = _withOpacity(widget.shadowColorEnd ?? widget.shadowColor);

    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _GradientShadowPainter(
              colorStart: colorStart,
              colorEnd: colorEnd,
              blurRadius: widget.shadowBlurRadius / _pixelRatio,
              spreadRadius: widget.shadowSpreadRadius / _pixelRatio,
              offset: widget.shadowOffset / _pixelRatio,
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _GradientShadowPainter extends CustomPainter {
  const _GradientShadowPainter({
    required this.colorStart,
    required this.colorEnd,
    required this.blurRadius,
    required this.spreadRadius,
    required this.offset,
  });

  final Color colorStart;
  final Color colorEnd;
  final double blurRadius;
  final double spreadRadius;
  final Offset offset;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero) + offset;
    final radius = (size.shortestSide / 2) + spreadRadius;

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [colorStart, colorEnd],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(_GradientShadowPainter old) =>
      old.colorStart != colorStart ||
      old.colorEnd != colorEnd ||
      old.blurRadius != blurRadius ||
      old.spreadRadius != spreadRadius ||
      old.offset != offset;
}