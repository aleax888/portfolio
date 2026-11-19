import 'package:flutter/material.dart';

import 'package:portfolio/widgets/layout/section_viewport.dart';

extension ContextExtension on BuildContext {
  /// Available during build, including inside an unbounded scroll column.
  Size get viewportSize => SectionViewport.sizeOf(this);
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
}
