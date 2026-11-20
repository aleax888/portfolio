import 'package:flutter/material.dart';

import 'package:portfolio/pages/sections/contact/section/widgets/contact_buttons.dart';
import 'package:portfolio/pages/sections/contact/section/widgets/contact_message.dart';
import 'package:portfolio/widgets/content/section_title.dart';
import 'package:portfolio/widgets/content/split_view.dart';
import 'package:portfolio/widgets/layout/custom_constrain.dart';

class ContactSection extends StatelessWidget {
  final ScrollController scrollController;
  const ContactSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomConstrain(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .stretch,
          children: [
            // Title -------------------------------------------------------
            SectionTitle(
              index: 5,
              scrollController: scrollController,
              title: 'CONTACT ME',
            ),

            // Content -------------------------------------------------------
            SplitView(
              split: 0.6,
              left: ContactMessage(scrollController: scrollController),
              right: ContactButtons(scrollController: scrollController),
            ),
          ],
        ),
      ),
    );
  }
}
