import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/layout_constants.dart';

class CustomConstrain extends StatelessWidget {
  final Widget child;
  const CustomConstrain({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: LayoutConstants.contentWidth),
      child: child,
    );
  }
}
