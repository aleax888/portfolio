import 'package:flutter/material.dart';
import 'package:portfolio/widgets/layout/custom_appbar/custom_app_bar.dart';

class ScrollAwareAppBarController extends ChangeNotifier {
  ScrollAwareAppBarController({
    required ScrollController scrollController,
    required List<PortfolioNavItem> navItems,
    this.scrollThreshold = 6.0,
  }) : _scrollController = scrollController,
       _navItems = navItems {
    _scrollController.addListener(_onScroll);
  }

  final ScrollController _scrollController;
  final List<PortfolioNavItem> _navItems;
  final double scrollThreshold;

  bool _isVisible = true;
  bool get isVisible => _isVisible;

  double _lastOffset = 0;
  bool _isProgrammaticScroll = false;

  PortfolioNavItem? _activeItem;
  PortfolioNavItem? get activeItem => _activeItem;

  void setProgrammaticScroll(bool value) {
    _isProgrammaticScroll = value;
    if (value && !_isVisible) {
      _isVisible = true;
      notifyListeners();
    }
  }

  void _onScroll() {
    final currentOffset = _scrollController.offset;

    _updateVisibility(currentOffset);
    _updateActiveItem(currentOffset);

    _lastOffset = currentOffset;
  }

  void _updateVisibility(double currentOffset) {
    if (_isProgrammaticScroll) return;

    if (currentOffset <= 0) {
      _setVisible(true);
      return;
    }

    final delta = currentOffset - _lastOffset;
    if (delta.abs() < scrollThreshold) return;

    _setVisible(delta <= 0);
  }

  /// Determina qué sección está activa según cuál es la última cuyo
  /// borde superior ya cruzó la línea de activación (ej: top + altura del AppBar).
  void _updateActiveItem(double currentOffset) {
    final scrollBox =
        _scrollController.position.context.storageContext.findRenderObject()
            as RenderBox?;
    if (scrollBox == null) return;

    PortfolioNavItem? bestMatch;
    double bestDistance = double.infinity;

    for (final item in _navItems) {
      final itemContext = item.sectionKey.currentContext;
      final renderObject = itemContext?.findRenderObject();
      if (renderObject is! RenderBox || !renderObject.attached) continue;

      // dy = distancia desde el top del Scrollable hasta el top de la sección,
      // en coordenadas de pantalla actuales (ya refleja el scroll aplicado).
      final dy = renderObject
          .localToGlobal(Offset.zero, ancestor: scrollBox)
          .dy;

      // La sección "activa" es la última cuyo top ya pasó la línea de activación
      // (es decir, dy <= activationLine), y de esas, la más cercana a 0.
      if (dy <= _activationLine && (_activationLine - dy) < bestDistance) {
        bestMatch = item;
        bestDistance = _activationLine - dy;
      }
    }

    // Caso borde: si ninguna sección cruzó aún la línea (estamos arriba del todo),
    // activamos la primera por defecto.
    bestMatch ??= _navItems.isNotEmpty ? _navItems.first : null;

    if (bestMatch != _activeItem) {
      _activeItem = bestMatch;
      notifyListeners();
    }
  }

  void recomputeActiveItem() {
    _updateActiveItem(
      _scrollController.hasClients ? _scrollController.offset : 0,
    );
  }

  static const double _activationLine = 80.0;

  /// Margen para decidir "cuándo" una sección se considera activa
  /// relativo al top del viewport (ej: cuando pasa bajo el AppBar).
  // static const double _activationOffset = 80.0;

  void _setVisible(bool value) {
    if (_isVisible != value) {
      _isVisible = value;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
