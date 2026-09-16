import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_driven_text.dart';

class ContactHook extends StatelessWidget {
  final ScrollController scrollController;
  const ContactHook({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ScrollDrivenText(
      scrollController: scrollController,
      pixelsPerChar: 70,
      text: 'Want to start a new project?',
      textAlign: .center,
      textStyle: TextStyle(
        fontFamily: TextFamilyConstants.primary,
        color: TextColorConstants.light,
        fontSize: MediaQuery.of(context).size.width * 0.1,
        fontWeight: TextWeightConstants.bold,
      ),
    );
  }
}
