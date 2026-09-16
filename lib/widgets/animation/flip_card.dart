import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';

// ─────────────────────────────────────────────────────────────────────────────
// FlipCard
//
// Widget que muestra dos caras (front / back) y las intercambia con una
// animación de giro 3-D al pasar el mouse por encima (MouseRegion hover).
//
// Parámetros obligatorios
//   • front   – Widget que se muestra como cara delantera.
//   • back    – Widget que se muestra como cara trasera.
//
// Parámetros opcionales
//   • width            – Ancho de la tarjeta.          Default: 300
//   • height           – Alto  de la tarjeta.          Default: 200
//   • duration         – Duración de la animación.     Default: 400 ms
//   • curve            – Curva de la animación.        Default: easeInOut
//   • flipAxis         – Eje de rotación (X o Y).      Default: FlipAxis.y
//   • borderRadius     – Radio de las esquinas.        Default: 16
// ─────────────────────────────────────────────────────────────────────────────

/// Eje alrededor del cual se realizará el giro.
enum FlipAxis { x, y }

class FlipCard extends StatefulWidget {
  const FlipCard({
    super.key,
    required this.front,
    required this.back,
    this.width = 300,
    this.height = 200,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.flipAxis = FlipAxis.y,
    this.borderRadius = 16,
  });

  /// Cara frontal (visible en reposo).
  final Widget front;

  /// Cara trasera (visible al hacer hover).
  final Widget back;

  /// Dimensiones de la tarjeta.
  final double width;
  final double height;

  /// Duración total de la animación de giro.
  final Duration duration;

  /// Curva de interpolación para la animación.
  final Curve curve;

  /// Eje de giro: [FlipAxis.y] = giro horizontal, [FlipAxis.x] = vertical.
  final FlipAxis flipAxis;

  /// Radio de las esquinas redondeadas de la tarjeta.
  final double borderRadius;

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  // ── Controlador de animación ───────────────────────────────────────────────
  late final AnimationController _controller;
  late final Animation<double> _animation;

  // Indica si el frente es el lado actualmente visible.
  bool _showingFront = true;

  // ── Ciclo de vida ──────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Anima de 0.0 (frente) → 1.0 (dorso) con la curva elegida.
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    // Actualiza _showingFront a mitad de la animación para que siempre se
    // vea la cara correcta durante todo el recorrido.
    _controller.addListener(_updateVisibleSide);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateVisibleSide);
    _controller.dispose();
    super.dispose();
  }

  // ── Lógica de visibilidad ──────────────────────────────────────────────────

  /// Cambia qué cara se renderiza cuando el ángulo supera los 90°.
  void _updateVisibleSide() {
    final showFront = _controller.value < 0.5;
    if (showFront != _showingFront) {
      setState(() => _showingFront = showFront);
    }
  }

  // ── Interacción hover ──────────────────────────────────────────────────────

  void _onEnter() => _controller.forward();
  void _onExit() => _controller.reverse();

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onEnter(),
      onExit: (_) => _onExit(),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          // Ángulo actual: de 0 → π (media vuelta completa).
          final angle = _animation.value * pi;

          // Cuando superamos 90° mostramos el dorso; lo rotamos -π para
          // que se vea en orientación correcta (efecto espejo).
          final visibleAngle = _showingFront ? angle : angle - pi;

          // Matriz de transformación 3-D según el eje configurado.
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspectiva
            .._applyRotation(widget.flipAxis, visibleAngle);

          return Transform(
            alignment: Alignment.center,
            transform: transform,
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: EdgeInsets.all(SpacingConstants.m),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    ColorPaletteConstants.primary,
                    ColorPaletteConstants.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: _CardFace(
                borderRadius: widget.borderRadius,
                child: _showingFront ? widget.front : widget.back,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _CardFace  –  Envoltura visual común para ambas caras.
// ─────────────────────────────────────────────────────────────────────────────

class _CardFace extends StatelessWidget {
  const _CardFace({required this.child, required this.borderRadius});

  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: child,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Extensión privada de Matrix4 para aplicar la rotación según el eje.
// ─────────────────────────────────────────────────────────────────────────────

extension _Matrix4Rotation on Matrix4 {
  void _applyRotation(FlipAxis axis, double angle) {
    switch (axis) {
      case FlipAxis.y:
        rotateY(angle);
      case FlipAxis.x:
        rotateX(angle);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DEMO  –  Ejemplo de uso del FlipCard
// ─────────────────────────────────────────────────────────────────────────────

void main() => runApp(const _DemoApp());

class _DemoApp extends StatelessWidget {
  const _DemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlipCard Demo',
      theme: ThemeData.dark(useMaterial3: true),
      home: const _DemoPage(),
    );
  }
}

class _DemoPage extends StatelessWidget {
  const _DemoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F14),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Ejemplo 1: giro en Y (horizontal) ──
            const Text(
              'Hover sobre la tarjeta',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 24),
            FlipCard(
              width: 320,
              height: 200,
              flipAxis: FlipAxis.y,
              front: _buildFront(),
              back: _buildBack(),
            ),
            const SizedBox(height: 48),

            // ── Ejemplo 2: giro en X (vertical) ──
            const Text(
              'Giro en eje X',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            const SizedBox(height: 24),
            FlipCard(
              width: 320,
              height: 200,
              flipAxis: FlipAxis.x,
              duration: const Duration(milliseconds: 500),
              front: _buildFront(),
              back: _buildBack(),
            ),
          ],
        ),
      ),
    );
  }

  // ── Cara delantera de ejemplo ──────────────────────────────────────────────
  Widget _buildFront() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF3ECFCF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.credit_card_rounded, size: 48, color: Colors.white),
            SizedBox(height: 12),
            Text(
              'Cara Frontal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Pasa el mouse para girar →',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ── Cara trasera de ejemplo ────────────────────────────────────────────────
  Widget _buildBack() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF6584), Color(0xFFFF8C42)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline_rounded, size: 48, color: Colors.white),
            SizedBox(height: 12),
            Text(
              'Cara Trasera',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '← Quita el mouse para volver',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
