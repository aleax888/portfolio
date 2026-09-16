import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/design_system/constants/spacing_constants.dart';
import 'package:portfolio/design_system/constants/text_constants.dart';
import 'package:portfolio/widgets/animation/pressable_widget.dart';
import 'package:portfolio/widgets/layout/custom_container.dart';

// Clase sellada que actúa como tipo union
sealed class ContactIcon {
  const ContactIcon();

  factory ContactIcon.icon(IconData iconData) = _IconDataIcon;
  factory ContactIcon.asset(String path) = _AssetIcon;
}

class _IconDataIcon extends ContactIcon {
  final IconData iconData;
  const _IconDataIcon(this.iconData);
}

class _AssetIcon extends ContactIcon {
  final String path;
  const _AssetIcon(this.path);
}

class ContactOption extends StatefulWidget {
  final ContactIcon icon;
  final String text;
  final Color color;
  final VoidCallback? onTap;

  const ContactOption({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    this.onTap,
  });

  @override
  State<ContactOption> createState() => _ContactOptionState();
}

class _ContactOptionState extends State<ContactOption> {
  Widget _buildIcon() {
    return switch (widget.icon) {
      _IconDataIcon(:final iconData) => Icon(
        iconData,
        color: TextColorConstants.light,
      ),
      _AssetIcon(:final path) => Image.asset(
        path,
        width: 24,
        height: 24,
        color: TextColorConstants.light,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return PressableWidget(
      onTap: widget.onTap,
      child: CustomContainer(
        hoverColor: widget.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                spacing: SpacingConstants.l,
                children: [
                  _buildIcon(),
                  Expanded(
                    child: Text(
                      widget.text,
                      overflow: .ellipsis,
                      style: TextStyle(
                        color: TextColorConstants.light,
                        fontSize: TextSizeConstants.m,
                        fontWeight: TextWeightConstants.regular,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.copy),
              color: TextColorConstants.light,
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: widget.text));
              },
            ),
          ],
        ),
      ),
    );
  }
}
