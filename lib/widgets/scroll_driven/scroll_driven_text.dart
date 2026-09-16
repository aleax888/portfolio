import 'package:flutter/material.dart';

class ScrollDrivenText extends StatefulWidget {
  final String text;
  final double pixelsPerChar;
  final ScrollController scrollController;
  final TextStyle? textStyle;
  final TextAlign textAlign;

  const ScrollDrivenText({
    super.key,
    required this.text,
    required this.scrollController,
    this.pixelsPerChar = 20.0,
    this.textStyle,
    this.textAlign = TextAlign.start,
  });

  @override
  State<ScrollDrivenText> createState() => _ScrollDrivenTextState();
}

class _ScrollDrivenTextState extends State<ScrollDrivenText> {
  final GlobalKey _containerKey = GlobalKey();

  // Análogo a _totalScrollAnimationDistance
  late double _totalScrollTextDistance;

  // Cuántos chars mostrar actualmente
  int _visibleChars = 0;

  @override
  void initState() {
    super.initState();
    _totalScrollTextDistance = widget.text.length * widget.pixelsPerChar;
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(ScrollDrivenText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.pixelsPerChar != widget.pixelsPerChar) {
      _totalScrollTextDistance = widget.text.length * widget.pixelsPerChar;
    }
  }

  void _onScroll() {
    final progress = _getProgress();
    final newVisibleChars = (progress * widget.text.length).round().clamp(
      0,
      widget.text.length,
    );

    if (newVisibleChars != _visibleChars) {
      setState(() => _visibleChars = newVisibleChars);
    }
  }

  // Misma lógica que en ScrollDrivenAnimation
  double _getProgress() {
    final context = _containerKey.currentContext;
    if (context == null) return 0.0;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return 0.0;

    final scrollAnimationPosition =
        box.localToGlobal(Offset.zero).dy + widget.scrollController.offset;

    final scrollAnimationProgress =
        widget.scrollController.offset - scrollAnimationPosition;

    return (scrollAnimationProgress / _totalScrollTextDistance).clamp(0.0, 1.0);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(25),
      key: _containerKey,
      // Misma fórmula: alto de pantalla + distancia total de scroll
      height: screenHeight + _totalScrollTextDistance,
      child: Stack(
        children: [
          AnimatedBuilder(
            // Reconstruye solo cuando cambia _visibleChars
            animation: widget.scrollController,
            builder: (context, _) {
              // Progreso actual para calcular el top offset (sticky effect)
              final progress = _getProgress();
              final topOffset = progress * _totalScrollTextDistance;

              return Positioned(
                // El texto se queda fijo mientras el scroll avanza
                top: topOffset,
                left: 0,
                right: 0,
                height: screenHeight,
                child: Center(child: _buildText()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildText() {
    final visible = widget.text.substring(0, _visibleChars);
    final hidden = widget.text.substring(_visibleChars);

    return Text.rich(
      TextSpan(
        children: [
          // Chars visibles
          TextSpan(text: visible, style: widget.textStyle),
          // Chars ocultos — misma fuente pero transparentes para
          // que el layout no salte al ir apareciendo el texto
          TextSpan(
            text: hidden,
            style: (widget.textStyle ?? const TextStyle()).copyWith(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      textAlign: widget.textAlign,
    );
  }
}
