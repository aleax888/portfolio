import 'package:flutter/material.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/pages/sections/stack/ai_vs_human/widgets/ai_side.dart';
import 'package:portfolio/pages/sections/stack/ai_vs_human/widgets/human_side.dart';
import 'package:portfolio/widgets/animation/hover_split_view.dart';

class AiVsHumanSplitScreen extends StatelessWidget {
  final ScrollController scrollController;
  const AiVsHumanSplitScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: SpacingConstants.m,
      children: [
        // AI or Human
        SplitOverlapView(
          leftChild: AiSide(scrollController: scrollController),
          rightChild: HumanSide(scrollController: scrollController),
        ),
      ],
    );
  }
}
