import 'dart:async';

import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/layout_constants.dart';
import 'package:portfolio/design_system/constants/motion_constants.dart';
import 'package:portfolio/design_system/constants/color_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/layout/custom_container.dart';

enum _AppBarLayoutType { web, compact }

class AdaptivePortfolioAppBar extends StatefulWidget {
  const AdaptivePortfolioAppBar({
    super.key,

    required this.navItems,
    this.leading,
    this.height = defaultHeight,
    this.webBreakpoint = LayoutConstants.navigationWidth,
    this.backgroundColor,
    this.elevation = 4,
  });

  final List<PortfolioNavItem> navItems;
  final Widget? leading;
  static const double defaultHeight = LayoutConstants.headerHeight;
  final double height;
  final double webBreakpoint;
  final Color? backgroundColor;
  final double elevation;

  @override
  State<AdaptivePortfolioAppBar> createState() =>
      _AdaptivePortfolioAppBarState();
}

class _AdaptivePortfolioAppBarState extends State<AdaptivePortfolioAppBar> {
  PortfolioNavItem? _selected;
  late Timer _hideTimer;
  bool _showHeader = true;

  @override
  void initState() {
    super.initState();
    _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer = Timer(MotionConstants.headerVisibleDuration, () {
      setState(() => _showHeader = false);
    });
  }

  void _openHeader() {
    _hideTimer.cancel();
    setState(() => _showHeader = true);
    _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer.cancel();
    super.dispose();
  }

  void _navigateTo(PortfolioNavItem item) {
    final target = item.sectionKey.currentContext;
    if (target != null) {
      setState(() => _selected = item);
      Scrollable.ensureVisible(
        target,
        duration: MotionConstants.navigationDuration,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_showHeader) {
      return SafeArea(
        bottom: false,
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingConstants.s,
              vertical: SpacingConstants.xs,
            ),
            child: Material(
              shape: const CircleBorder(),
              color: Theme.of(context).colorScheme.surface,
              elevation: widget.elevation,
              child: IconButton(
                tooltip: 'Mostrar cabecera',
                constraints: const BoxConstraints.tightFor(
                  width: LayoutConstants.touchTarget,
                  height: LayoutConstants.touchTarget,
                ),
                icon: const Icon(Icons.menu),
                onPressed: _openHeader,
              ),
            ),
          ),
        ),
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final textScale =
            MediaQuery.textScalerOf(context).scale(TextSizeConstants.s) /
            TextSizeConstants.s;
        final layout = constraints.maxWidth < widget.webBreakpoint * textScale
            ? _AppBarLayoutType.compact
            : _AppBarLayoutType.web;
        return _buildBar(context, layout);
      },
    );
  }

  Widget _buildBar(BuildContext context, _AppBarLayoutType layoutType) {
    return Material(
      color: widget.backgroundColor ?? Colors.transparent,
      elevation: widget.elevation,
      child: SizedBox(
        height: widget.height,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpacingConstants.s),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: widget.leading,
                    ),
                  ),
                ),
                if (layoutType == _AppBarLayoutType.web)
                  _WebNavOptions(
                    items: widget.navItems,
                    activeItem: _selected,
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

  Future<void> _openSideMenu(BuildContext context) async {
    final selected = await showGeneralDialog<PortfolioNavItem>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Menú',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.centerRight,
          child: _SideMenu(
            items: widget.navItems,
            activeItem: _selected,
            onTap: (item) => Navigator.of(context).pop(item),
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
    if (mounted && selected != null) _navigateTo(selected);
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
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingConstants.xxs,
            ),
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
    return InkWell(
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
          width: LayoutConstants.menuWidth,
          height: double.infinity,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: SpacingConstants.m),
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
