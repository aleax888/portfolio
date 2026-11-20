import 'package:flutter/material.dart';

import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_typing.dart';

class ContactHook extends StatelessWidget {
  final ScrollController scrollController;
  const ContactHook({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ScrollDrivenTyping(
      scrollController: scrollController,
      text: 'Want to start a new project?',
      textAlign: .center,
      textStyle: TextStyle(
        color: TextColorConstants.light,
        fontSize: ResponsiveFontSize.exponential(200, context.viewportSize),
        fontWeight: TextWeightConstants.bold,
        fontFamily: TextFamilyConstants.primary,
      ),
    );
  }
}
