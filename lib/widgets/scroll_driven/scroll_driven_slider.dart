import 'package:flutter/material.dart';
import 'package:portfolio/widgets/scroll_driven/viewport_observer.dart';

enum SliderDirection { toRight, toLeft }

class ScrollDrivenSlider extends StatefulWidget {
  final List<Widget> items;
  final ScrollController scrollController;

  /// Offset inicial del slider (fracción del ancho total del contenido).
  final double offset;

  /// Umbral de progreso máximo del scroll (0.0 a 1.0).
  final double threshold;

  /// Tamaño de cada item cuadrado en logical pixels.
  final double itemSize;

  /// Espacio entre items.
  final double itemSpacing;

  /// Dirección de la animación.
  final SliderDirection direction;

  const ScrollDrivenSlider({
    super.key,
    required this.items,
    required this.scrollController,
    this.offset = 0.1,
    this.threshold = 0.9,
    this.itemSize = 200.0,
    this.itemSpacing = 16.0,
    this.direction = SliderDirection.toLeft,
  }) : assert(threshold > 0 && threshold <= 1);

  @override
  State<ScrollDrivenSlider> createState() => _ScrollDrivenSliderState();
}

class _ScrollDrivenSliderState extends State<ScrollDrivenSlider> {
  final _innerController = ScrollController();

  void _syncSlider(double top, ScrollPosition position) {
    if (!_innerController.hasClients || position.viewportDimension <= 0) return;
    final progress =
        ((position.viewportDimension - top) /
                (position.viewportDimension * widget.threshold))
            .clamp(0.0, 1.0);
    final maxScroll = _innerController.position.maxScrollExtent;
    final rawOffset = progress * maxScroll;

    // Aplica offset inicial y dirección
    final offsetPixels = widget.offset * maxScroll;
    final target = widget.direction == SliderDirection.toLeft
        ? (rawOffset + offsetPixels).clamp(0.0, maxScroll)
        : (maxScroll - rawOffset - offsetPixels).clamp(0.0, maxScroll);

    if (_innerController.offset != target) _innerController.jumpTo(target);
  }

  @override
  void dispose() {
    _innerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewportObserver(
      controller: widget.scrollController,
      onPosition: _syncSlider,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          return SizedBox(
            height: widget.itemSize,
            child: ScrollConfiguration(
              // Deshabilita el scroll manual del usuario
              behavior: const ScrollBehavior().copyWith(scrollbars: false),
              child: SingleChildScrollView(
                controller: _innerController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                child: Row(
                  children: [
                    // Padding fantasma izquierdo para efecto de aparición
                    SizedBox(width: screenWidth),
                    ...List.generate(
                      widget.items.length,
                      (i) => Padding(
                        padding: EdgeInsets.only(
                          right: i < widget.items.length - 1
                              ? widget.itemSpacing
                              : 0,
                        ),
                        child: SizedBox(
                          width: widget.itemSize,
                          height: widget.itemSize,
                          child: widget.items[i],
                        ),
                      ),
                    ),
                    // Padding fantasma derecho para efecto de desaparición
                    SizedBox(width: screenWidth),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
