import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';

class FullScreenSection extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final double? minWidth;
  final double? minHeight;
  const FullScreenSection({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: SpacingConstants.l),
    this.backgroundColor = Colors.transparent,
    this.minWidth,
    this.minHeight,
  });

  @override
  State<FullScreenSection> createState() => _FullScreenSectionState();
}

class _FullScreenSectionState extends State<FullScreenSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      color: widget.backgroundColor,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: max(
            widget.minHeight ?? 0.0,
            MediaQuery.of(context).size.height,
          ),
          maxWidth: max(
            widget.minWidth ?? 0.0,
            MediaQuery.of(context).size.width,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
