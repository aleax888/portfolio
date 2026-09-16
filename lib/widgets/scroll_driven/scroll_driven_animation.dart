import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/widgets/effects/shadowed_container.dart';

class ScrollDrivenAnimation extends StatefulWidget {
  final String animationPath;
  final double pixelsPerFrame;
  final ScrollController scrollController;
  final Widget? child;

  const ScrollDrivenAnimation({
    super.key,
    required this.animationPath,
    required this.scrollController,
    this.pixelsPerFrame = 12.0,
    this.child,
  });

  @override
  State<ScrollDrivenAnimation> createState() => _ScrollDrivenAnimationState();
}

class _ScrollDrivenAnimationState extends State<ScrollDrivenAnimation>
    with SingleTickerProviderStateMixin {
  final GlobalKey _containerKey = GlobalKey();
  late AnimationController _animationController;
  double _totalScrollAnimationDistance = 0.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, value: 0.0);
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    _animationController.value = _getProgress();
  }

  double _getProgress() {
    final context = _containerKey.currentContext;
    if (context == null) return 0.0;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return 0.0;

    // Posición absoluta del widget en el recorrido de la animación en el scroll
    final scrollAnimationPosition =
        box.localToGlobal(Offset.zero).dy + widget.scrollController.offset;

    // Cuánto hemos scrolleado desde el inicio recorrido de la animación
    final scrollAnimationProgress =
        widget.scrollController.offset - scrollAnimationPosition;

    return (scrollAnimationProgress / _totalScrollAnimationDistance).clamp(
      0.0,
      1.0,
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      // La altura total del widget es la altura de la pantalla + la distancia de scroll necesaria para recorrer toda la animación
      height: screenHeight + _totalScrollAnimationDistance,
      key: _containerKey,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => Positioned(
              // El Lottie se queda fijo mientras el scroll avanza
              top: _animationController.value * _totalScrollAnimationDistance,
              left: 0,
              right: 0,
              height: screenHeight,
              child: Stack(
                children: [
                  ShadowedContainer(
                    shadowColor: Color(0xFF763CAC),
                    shadowColorEnd: Color(0xFF320F85),
                    shadowBlurRadius: 500,
                    shadowSpreadRadius: 5,
                    child: Positioned.fill(
                      child: Opacity(
                        opacity: 0.5,
                        child: Lottie.asset(
                          widget.animationPath,
                          controller: _animationController,
                          fit: BoxFit.contain,
                          onLoaded: (LottieComposition composition) {
                            setState(() {
                              // scrollDistance = frames totales × píxeles por frame
                              _totalScrollAnimationDistance =
                                  composition.durationFrames *
                                  widget.pixelsPerFrame;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  if (widget.child != null)
                    Positioned.fill(child: Center(child: widget.child!)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
