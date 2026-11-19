import 'package:flutter/widgets.dart';
import 'package:portfolio/widgets/scroll_driven/scroll_geometry.dart';

/// Pins one viewport of content for the specified logical scroll distance.
class PinnedScrollScene extends StatefulWidget {
  const PinnedScrollScene({
    super.key,
    required this.controller,
    required this.distance,
    required this.builder,
  }) : assert(distance >= 0);

  final ScrollController controller;
  final double distance;
  final Widget Function(BuildContext, double progress) builder;

  @override
  State<PinnedScrollScene> createState() => _PinnedScrollSceneState();
}

class _PinnedScrollSceneState extends State<PinnedScrollScene> {
  double _travel = 0;
  double? _height;

  @override
  Widget build(BuildContext context) {
    final height = _height ?? MediaQuery.sizeOf(context).height;
    final travel = _travel.clamp(0.0, widget.distance);
    return ScrollGeometry(
      controller: widget.controller,
      onPosition: (top, position) {
        final travel = (-top).clamp(0.0, widget.distance);
        if (_travel != travel || _height != position.viewportDimension) {
          setState(() {
            _travel = travel;
            _height = position.viewportDimension;
          });
        }
      },
      child: SizedBox(
        height: height + widget.distance,
        child: Stack(
          children: [
            Positioned(
              top: travel,
              left: 0,
              right: 0,
              height: height,
              child: widget.builder(
                context,
                widget.distance == 0 ? 0 : travel / widget.distance,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
