import 'package:flutter/material.dart';

class CircularSlider extends StatefulWidget {
  const CircularSlider({
    super.key,
    required this.items,
    this.itemWidth = 100.0,
    this.itemHeight = 140.0,
    this.focusScaleFactor = 1.55,
    this.sideOffset = 120.0,
    this.initialIndex = 0,
    this.onIndexChanged,
  });

  final List<Widget> items;
  final double itemWidth;
  final double itemHeight;
  final double focusScaleFactor;

  /// Distancia horizontal desde el centro al elemento n±1
  final double sideOffset;

  final int initialIndex;
  final ValueChanged<int>? onIndexChanged;

  @override
  State<CircularSlider> createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider>
    with SingleTickerProviderStateMixin {
  late int _current;
  late AnimationController _controller;
  late Animation<double> _animation;

  // offset animado: 0.0 = en reposo, ±1.0 = desplazándose un paso
  double _offsetAnim = 0.0;
  int _direction = 0; // -1 izq, +1 der

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    _controller.addListener(() {
      setState(() => _offsetAnim = _animation.value * _direction);
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _current = _mod(_current + _direction, widget.items.length);
          _offsetAnim = 0.0;
          _direction = 0;
          widget.onIndexChanged?.call(_current);
        });
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _mod(int a, int b) => ((a % b) + b) % b;

  void _go(int dir) {
    if (_controller.isAnimating) return;
    _direction = dir;
    _controller.forward(from: 0.0);
  }

  /// offset lógico del ítem i con respecto al centro, con wrap circular
  double _logicalOffset(int i) {
    final n = widget.items.length;
    double raw = (i - _current).toDouble() - _offsetAnim;
    // normalizar al rango [-n/2, n/2]
    while (raw > n / 2) {
      raw -= n;
    }
    while (raw < -n / 2) {
      raw += n;
    }
    return raw;
  }

  _ItemConfig _configForOffset(double off) {
    final abs = off.abs();

    // interpolamos entre estados discretos para una transición fluida
    if (abs <= 1.0) {
      // entre centro (0) y primer lateral (±1)
      final t = abs;
      final scale = _lerp(widget.focusScaleFactor, 1.0, t);
      final x = off.sign * _lerp(0, widget.sideOffset, t);
      final z = _lerp(10, 5, t).round();
      final opacity = _lerp(1.0, 0.85, t);
      return _ItemConfig(x: x, scale: scale, zIndex: z, opacity: opacity);
    } else if (abs <= 2.0) {
      // entre primer lateral (±1) y segundo (±2)
      final t = abs - 1.0;
      final scale = _lerp(1.0, 0.72, t);
      final x = off.sign * _lerp(widget.sideOffset, widget.sideOffset * 1.6, t);
      final z = _lerp(5, 2, t).round();
      final opacity = _lerp(0.85, 0.45, t);
      return _ItemConfig(x: x, scale: scale, zIndex: z, opacity: opacity);
    } else {
      // oculto
      return _ItemConfig(
        x: off.sign * widget.sideOffset * 2.5,
        scale: 0.4,
        zIndex: 0,
        opacity: 0.0,
      );
    }
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t.clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final n = widget.items.length;

    // construimos los items con su config, ordenados por zIndex para el stack
    final configs = List.generate(n, (i) {
      final off = _logicalOffset(i);
      final cfg = _configForOffset(off);
      return (index: i, config: cfg);
    });

    // ordenamos: primero los de menor zIndex (atrás)
    configs.sort((a, b) => a.config.zIndex.compareTo(b.config.zIndex));

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        if (details.primaryVelocity! < -200) _go(1); // swipe izq → siguiente
        if (details.primaryVelocity! > 200) _go(-1); // swipe der → anterior
      },
      child: SizedBox(
        width: double.infinity,
        height: widget.itemHeight * widget.focusScaleFactor + 24,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ...configs.map((entry) {
              final cfg = entry.config;
              return AnimatedPositioned(
                duration: Duration.zero,
                child: Transform.translate(
                  offset: Offset(cfg.x, 0),
                  child: Transform.scale(
                    scale: cfg.scale,
                    child: Opacity(
                      opacity: cfg.opacity.clamp(0.0, 1.0),
                      child: GestureDetector(
                        onTap: () {
                          final off = _logicalOffset(entry.index);
                          final dir = off > 0 ? 1 : (off < 0 ? -1 : 0);
                          if (dir != 0) _go(dir);
                        },
                        child: SizedBox(
                          width: widget.itemWidth,
                          height: widget.itemHeight,
                          child: widget.items[entry.index],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),

            // Botón izquierda
            Positioned(
              left: 8,
              child: _NavButton(icon: Icons.chevron_left, onTap: () => _go(-1)),
            ),

            // Botón derecha
            Positioned(
              right: 8,
              child: _NavButton(icon: Icons.chevron_right, onTap: () => _go(1)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemConfig {
  const _ItemConfig({
    required this.x,
    required this.scale,
    required this.zIndex,
    required this.opacity,
  });
  final double x;
  final double scale;
  final int zIndex;
  final double opacity;
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: Colors.black26,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
