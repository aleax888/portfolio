import 'package:flutter/material.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_geometry.dart';

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
    this.offset = 0.0,
    this.threshold = 0.9,
    this.itemSize = 200.0,
    this.itemSpacing = 16.0,
    this.direction = SliderDirection.toLeft,
  }) : assert(threshold > 0 && threshold <= 1);

  @override
  State<ScrollDrivenSlider> createState() => _ScrollDrivenSliderState();
}

class _ScrollDrivenSliderState extends State<ScrollDrivenSlider> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final gaps = widget.items.isEmpty ? 0 : widget.items.length - 1;
        final travel =
            width +
            widget.items.length * widget.itemSize +
            gaps * widget.itemSpacing;
        return ScrollGeometry(
          controller: widget.scrollController,
          onPosition: (top, position) {
            final span = position.viewportDimension * widget.threshold;
            if (span <= 0) return;
            _progress.value = ((position.viewportDimension - top) / span).clamp(
              0.0,
              1.0,
            );
          },
          child: SizedBox(
            height: widget.itemSize,
            width: width,
            child: ValueListenableBuilder<double>(
              valueListenable: _progress,
              builder: (context, progress, row) {
                final fraction = (progress + widget.offset).clamp(0.0, 1.0);
                final distance = widget.direction == SliderDirection.toLeft
                    ? fraction
                    : 1 - fraction;
                return Stack(
                  children: [
                    Positioned(
                      left: width - travel * distance,
                      top: 0,
                      child: row!,
                    ),
                  ],
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: widget.itemSpacing,
                children: [
                  for (final item in widget.items)
                    SizedBox.square(dimension: widget.itemSize, child: item),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final _progress = ValueNotifier<double>(0);

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }
}
