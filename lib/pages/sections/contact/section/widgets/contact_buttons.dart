import 'package:flutter/material.dart';
import 'package:portfolio/helpers/assets/icon_enum.dart';
import 'package:portfolio/pages/widgets/contact_option.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/layout/custom_column.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButtons extends StatelessWidget {
  final ScrollController scrollController;
  const ContactButtons({super.key, required this.scrollController});

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTranslation(
      origin: .fromRight,
      scrollController: scrollController,
      child: CustomColumn(
        children: [
          ContactOption(
            icon: ContactIcon.icon(Icons.email),
            text: "alex.maglio.neyra.herrada@gmail.com",
            color: Colors.orange,
            onTap: () => _launchUrl(
              Uri.parse(
                'https://mail.google.com/mail/?view=cm'
                '&fs=1'
                '&to=alex.maglio.neyra.herrada@gmail.com'
                '&su=Hello%20from%20...'
                '&body=Hello,%20...',
              ),
            ),
          ),
          ContactOption(
            icon: ContactIcon.asset(IconEnum.whatsapp.path),
            text: "+51 967 746 185",
            color: Colors.green,
            onTap: () => _launchUrl(
              Uri.parse("https://wa.me/51967746185?text=Hola%20Alex%20..."),
            ),
          ),
          ContactOption(
            icon: ContactIcon.asset(IconEnum.linkedin.path),
            text: "Alex Maglio Neyra Herrada",
            color: Colors.blue,
            onTap: () => _launchUrl(
              Uri.parse(
                "https://linkedin.com/in/alex-maglio-neyra-herrada-04271432a/",
              ),
            ),
          ),
          ContactOption(
            icon: ContactIcon.asset(IconEnum.github.path),
            text: "aleax888",
            color: Colors.grey,
            onTap: () => _launchUrl(Uri.parse("https://github.com/aleax888")),
          ),
        ],
      ),
    );
  }
}
