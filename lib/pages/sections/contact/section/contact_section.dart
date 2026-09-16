import 'package:flutter/material.dart';
import 'package:portfolio/pages/sections/contact/section/widgets/contact_buttons.dart';
import 'package:portfolio/pages/sections/contact/section/widgets/contact_message.dart';
import 'package:portfolio/widgets/content/full_screen_section.dart';
import 'package:portfolio/widgets/content/section_title.dart';
import 'package:portfolio/widgets/content/split_view.dart';

class ContactSection extends StatelessWidget {
  final ScrollController scrollController;
  const ContactSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return FullScreenSection(
      minHeight: 1000,
      child: Column(
        children: [
          SectionTitle(
            index: 5,
            scrollController: scrollController,
            title: 'CONTACT ME',
          ),
          Expanded(
            child: SplitView(
              left: ContactMessage(scrollController: scrollController),
              right: ContactButtons(scrollController: scrollController),
            ),
          ),
        ],
      ),
    );
  }
}
