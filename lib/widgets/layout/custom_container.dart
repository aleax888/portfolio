import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/border_constants.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';

class CustomContainer extends StatefulWidget {
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color? hoverColor;
  final BorderRadiusGeometry borderRadius;
  final double borderWidth;
  final Widget child;
  const CustomContainer({
    super.key,
    this.width,
    this.height,
    this.onTap,
    this.padding = const EdgeInsets.all(SpacingConstants.m),
    this.color = BorderColorConstants.secondary,
    this.hoverColor,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(BorderRadiusConstants.xl),
    ),
    this.borderWidth = BorderWidthConstants.xxs,
    required this.child,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  bool _isHovering = false;
  Color get color =>
      (_isHovering ? (widget.hoverColor ?? widget.color) : widget.color);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: color.withAlpha(51),
          borderRadius: widget.borderRadius,
          border: Border.all(color: color, width: widget.borderWidth),
        ),
        child: widget.child,
      ),
    );
  }
}
