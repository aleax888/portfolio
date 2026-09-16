import 'package:flutter/material.dart';

class CustomConstrain extends StatelessWidget {
  final Widget child;
  const CustomConstrain({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1400),
      child: child,
    );
  }
}
