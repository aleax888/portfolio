import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/pressable_widget.dart';
import 'package:portfolio/widgets/layout/custom_appbar/scroll_aware_appbar_controller.dart';
import 'package:portfolio/widgets/layout/custom_container.dart';

enum _AppBarLayoutType { web, compact }

class AdaptivePortfolioAppBar extends StatefulWidget {
  const AdaptivePortfolioAppBar({
    super.key,
    required this.scrollController,
    required this.navItems,
    this.leading,
    this.height = 72,
    this.webBreakpoint = 900,
    this.backgroundColor,
    this.elevation = 4,
  });

  final ScrollController scrollController;
  final List<PortfolioNavItem> navItems;
  final Widget? leading;
  final double height;
  final double webBreakpoint;
  final Color? backgroundColor;
  final double elevation;

  @override
  State<AdaptivePortfolioAppBar> createState() =>
      _AdaptivePortfolioAppBarState();
}

class _AdaptivePortfolioAppBarState extends State<AdaptivePortfolioAppBar>
    with SingleTickerProviderStateMixin {
  late final ScrollAwareAppBarController _visibilityController;

  @override
  void initState() {
    super.initState();
    _visibilityController = ScrollAwareAppBarController(
      scrollController: widget.scrollController,
      navItems: widget.navItems, // <-- nuevo
    );

    // Esperamos a que las secciones estén montadas para hacer
    // el primer cálculo de sección activa.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _visibilityController.recomputeActiveItem();
    });
  }

  @override
  void dispose() {
    _visibilityController.dispose();
    super.dispose();
  }

  Future<void> _navigateTo(PortfolioNavItem item) async {
    final ctx = item.sectionKey.currentContext;
    if (ctx == null) return;

    _visibilityController.setProgrammaticScroll(true);

    // Cierra el drawer si está abierto (mobile/tablet).
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      alignment: 0.0,
    );

    _visibilityController.setProgrammaticScroll(false);
  }

  bool _isCompact(double width) => width < widget.webBreakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = _isCompact(constraints.maxWidth);
        final layoutType = compact
            ? _AppBarLayoutType.compact
            : _AppBarLayoutType.web;

        return AnimatedBuilder(
          animation: _visibilityController,
          builder: (context, _) {
            return _AnimatedHideableAppBar(
              isVisible: _visibilityController.isVisible,
              height: widget.height,
              child: _buildBar(context, layoutType),
            );
          },
        );
      },
    );
  }

  Widget _buildBar(BuildContext context, _AppBarLayoutType layoutType) {
    return Material(
      color: Colors.transparent,
      elevation: widget.elevation,
      child: SizedBox(
        height: widget.height,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                if (widget.leading != null) widget.leading!,
                const Spacer(),
                if (layoutType == _AppBarLayoutType.web)
                  _WebNavOptions(
                    items: widget.navItems,
                    activeItem: _visibilityController.activeItem, // <-- nuevo
                    onTap: _navigateTo,
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.menu),
                    tooltip: 'Menú',
                    onPressed: () => _openSideMenu(context),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openSideMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Menú',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.centerRight,
          child: AnimatedBuilder(
            animation: _visibilityController,
            builder: (context, _) => _SideMenu(
              items: widget.navItems,
              activeItem: _visibilityController.activeItem,
              onTap: (item) {
                Navigator.of(context).pop();
                _navigateTo(item);
              },
            ),
          ),
        );
      },
      transitionBuilder: (context, anim, secondaryAnim, child) {
        final curved = CurvedAnimation(
          parent: anim,
          curve: Curves.easeOutCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }
}

@immutable
class PortfolioNavItem {
  const PortfolioNavItem({
    required this.label,
    required this.sectionKey,
    this.icon,
  });

  final String label;
  final GlobalKey sectionKey;
  final IconData? icon;
}

/// Colapsa la altura real del AppBar a 0 cuando está oculto (no solo
/// lo desplaza), para que no quede un espacio vacío reservado.
class _AnimatedHideableAppBar extends StatelessWidget {
  const _AnimatedHideableAppBar({
    required this.isVisible,
    required this.height,
    required this.child,
  });

  final bool isVisible;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOutCubic,
        height: isVisible ? height : 0,
        child: OverflowBox(
          minHeight: 0,
          maxHeight: height,
          alignment: Alignment.topCenter,
          child: AnimatedSlide(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOutCubic,
            offset: isVisible ? Offset.zero : const Offset(0, -1),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isVisible ? 1 : 0,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _WebNavOptions extends StatelessWidget {
  const _WebNavOptions({
    required this.items,
    required this.onTap,
    this.activeItem,
  });

  final List<PortfolioNavItem> items;
  final PortfolioNavItem? activeItem;
  final ValueChanged<PortfolioNavItem> onTap;

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _NavOptionButton(
              item: item,
              isActive: item == activeItem,
              onTap: () => onTap(item),
            ),
          ),
      ],
    );
  }
}

class _NavOptionButton extends StatelessWidget {
  const _NavOptionButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final PortfolioNavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableWidget(
      onTap: onTap,
      child: CustomContainer(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: SpacingConstants.s,
          vertical: SpacingConstants.xs,
        ),
        color: isActive ? ColorPaletteConstants.tertiary : Colors.transparent,
        hoverColor: ColorPaletteConstants.quaternary,
        child: Text(
          item.label,
          style: TextStyle(
            fontWeight: isActive
                ? TextWeightConstants.black
                : TextWeightConstants.bold,
            color: TextColorConstants.light,
          ),
        ),
      ),
    );
  }
}

class _SideMenu extends StatelessWidget {
  const _SideMenu({required this.items, required this.onTap, this.activeItem});

  final List<PortfolioNavItem> items;
  final PortfolioNavItem? activeItem;
  final ValueChanged<PortfolioNavItem> onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      elevation: 8,
      color: colorScheme.surface,
      child: SafeArea(
        child: SizedBox(
          width: 280,
          height: double.infinity,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 24),
            children: [
              for (final item in items)
                ListTile(
                  leading: item.icon != null
                      ? Icon(
                          item.icon,
                          color: item == activeItem
                              ? colorScheme.primary
                              : null,
                        )
                      : null,
                  selected: item == activeItem,
                  selectedColor: colorScheme.primary,
                  selectedTileColor: colorScheme.primary.withValues(
                    alpha: 0.08,
                  ),
                  title: Text(
                    item.label,
                    style: TextStyle(
                      fontWeight: item == activeItem
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                  onTap: () => onTap(item),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
