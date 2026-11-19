import 'package:flutter/widgets.dart';

import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/motion_constants.dart';
import 'package:portfolio/widgets/scroll_driven/pinned_scroll_scene.dart';

class ScrollDrivenTyping extends StatelessWidget {
  const ScrollDrivenTyping({
    super.key,
    required this.text,
    required this.scrollController,
    this.pixelsPerCharacter = MotionConstants.typingPixelsPerCharacter,
    this.textStyle,
    this.textAlign = TextAlign.start,
  }) : assert(pixelsPerCharacter > 0);

  final String text;
  final ScrollController scrollController;
  final double pixelsPerCharacter;
  final TextStyle? textStyle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final characters = text.characters;
    final count = characters.length;
    return PinnedScrollScene(
      controller: scrollController,
      distance: count * pixelsPerCharacter,
      builder: (context, progress) {
        final visible = characters.take((count * progress).round()).toString();
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(SpacingConstants.m),
            child: Text.rich(
              TextSpan(
                style: textStyle,
                children: [
                  TextSpan(text: visible),
                  TextSpan(
                    text: text.substring(visible.length),
                    style: const TextStyle(color: Color(0x00000000)),
                  ),
                ],
              ),
              semanticsLabel: text,
              textAlign: textAlign,
            ),
          ),
        );
      },
    );
  }
}
