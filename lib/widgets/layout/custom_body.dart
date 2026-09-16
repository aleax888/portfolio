import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';

class CustomBody extends StatelessWidget {
  final List<Widget> children;
  const CustomBody({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(spacing: SpacingConstants.l, children: children),
      ),
    );
  }
}
