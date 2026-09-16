import 'package:flutter/material.dart';

class OpacityGradient extends StatelessWidget {
  final double opacity;
  final List<Color> colors;
  final List<double> stops;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final Widget child;
  const OpacityGradient({
    super.key,
    this.opacity = 0.15,
    this.colors = const [Colors.grey, Colors.transparent],
    this.stops = const [0.3, 1.0],
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
          stops: stops,
        ).createShader(bounds),
        child: child,
      ),
    );
  }
}
