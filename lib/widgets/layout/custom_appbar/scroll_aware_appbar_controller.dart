import 'package:flutter/material.dart';
import 'package:portfolio/widgets/layout/custom_appbar/custom_app_bar.dart';

class ScrollAwareAppBarController extends ChangeNotifier {
  ScrollAwareAppBarController({
    required ScrollController scrollController,
    required List<PortfolioNavItem> navItems,
  }) : _scrollController = scrollController,
       _navItems = navItems {
    _scrollController.addListener(recomputeActiveItem);
  }

  final ScrollController _scrollController;
  final List<PortfolioNavItem> _navItems;
  PortfolioNavItem? _activeItem;
  PortfolioNavItem? get activeItem => _activeItem;

  /// Determina qué sección está activa según cuál es la última cuyo
  /// borde superior ya cruzó la línea de activación (ej: top + altura del AppBar).
  void recomputeActiveItem() {
    if (!_scrollController.hasClients) return;
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
    final position = _scrollController.position;
    if (_navItems.isNotEmpty &&
        position.maxScrollExtent > 0 &&
        position.pixels >= position.maxScrollExtent) {
      bestMatch = _navItems.last;
    }
    bestMatch ??= _navItems.firstOrNull;

    if (bestMatch != _activeItem) {
      _activeItem = bestMatch;
      notifyListeners();
    }
  }

  static const double _activationLine = 80;

  @override
  void dispose() {
    _scrollController.removeListener(recomputeActiveItem);
    super.dispose();
  }
}
