import 'package:flutter/material.dart';

import 'package:portfolio/design_system/constants/layout_constants.dart';
import 'package:portfolio/design_system/extensions/context_extensions.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/pages/sections/contact/section/widgets/contact_buttons.dart';
import 'package:portfolio/pages/sections/contact/section/widgets/contact_message.dart';
import 'package:portfolio/widgets/layout/custom_appbar/custom_app_bar.dart';
import 'package:portfolio/widgets/content/section_title.dart';
import 'package:portfolio/widgets/content/split_view.dart';

class ContactSection extends StatelessWidget {
  final ScrollController scrollController;
  const ContactSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final height = context.viewportSize.height;
    return LayoutBuilder(
      builder: (context, constraints) {
        final bodyWidth = constraints.maxWidth - 2 * SpacingConstants.m;
        final title = SectionTitle(
          index: 5,
          scrollController: scrollController,
          title: 'CONTACT ME',
        );
        final message = ContactMessage(scrollController: scrollController);
        final shortLandscape =
            bodyWidth >= LayoutConstants.splitWidth &&
            height < LayoutConstants.minSectionHeight;
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            SpacingConstants.m,
            AdaptivePortfolioAppBar.defaultHeight,
            SpacingConstants.m,
            SpacingConstants.xs,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!shortLandscape) title,
              SplitView(
                breakpoint: LayoutConstants.splitWidth,
                left: shortLandscape
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          title,
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: height * 0.66,
                            ),
                            child: message,
                          ),
                        ],
                      )
                    : message,
                right: ContactButtons(scrollController: scrollController),
              ),
            ],
          ),
        );
      },
    );
  }
}
