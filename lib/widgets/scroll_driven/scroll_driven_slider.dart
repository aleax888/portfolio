import 'package:flutter/material.dart';

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
  });

  @override
  State<ScrollDrivenSlider> createState() => _ScrollDrivenSliderState();
}

class _ScrollDrivenSliderState extends State<ScrollDrivenSlider> {
  final _key = GlobalKey();
  final _innerController = ScrollController();

  /// Calcula el progreso [0.0, 1.0] basado en qué tan visible está el widget
  /// dentro del viewport, comenzando cuando el leading edge entra en pantalla.
  double _computeProgress() {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !widget.scrollController.hasClients) return 0.0;

    final screenHeight = MediaQuery.of(context).size.height;
    final widgetTop = renderBox.localToGlobal(Offset.zero).dy;

    // El widget comienza a animarse cuando su borde superior entra al viewport.
    // Completa la animación cuando su borde superior llega al threshold del viewport.
    final start = screenHeight; // leading edge entra al viewport
    final end = screenHeight * (1.0 - widget.threshold);

    return ((start - widgetTop) / (start - end)).clamp(0.0, 1.0);
  }

  void _syncSlider() {
    if (!mounted) return;

    final progress = _computeProgress();
    if (!_innerController.hasClients) return;

    final maxScroll = _innerController.position.maxScrollExtent;
    final rawOffset = progress * maxScroll;

    // Aplica offset inicial y dirección
    final offsetPixels = widget.offset * maxScroll;
    final target = widget.direction == SliderDirection.toLeft
        ? (rawOffset + offsetPixels).clamp(0.0, maxScroll)
        : (maxScroll - rawOffset - offsetPixels).clamp(0.0, maxScroll);

    _innerController.jumpTo(target);
  }

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_syncSlider);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_syncSlider);
    _innerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      key: _key,
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
                    right: i < widget.items.length - 1 ? widget.itemSpacing : 0,
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
  }
}
