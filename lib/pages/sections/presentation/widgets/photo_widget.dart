import 'package:flutter/material.dart';
import 'package:portfolio/helpers/assets/images/me_enum.dart';
import 'package:portfolio/widgets/animation/animated_translation.dart';
import 'package:portfolio/widgets/effects/corner_border_container.dart';
import 'package:portfolio/widgets/effects/shadowed_container.dart';

class PhotoWidget extends StatefulWidget {
  const PhotoWidget({super.key});

  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedTranslation(
      origin: .fromRight,
      child: Center(
        child: CornerBorderContainer(
          child: ShadowedContainer(
            shadowOffset: const Offset(160, 0),
            child: Image.asset(MeEnum.casual.path),
          ),
        ),
      ),
    );
  }
}
