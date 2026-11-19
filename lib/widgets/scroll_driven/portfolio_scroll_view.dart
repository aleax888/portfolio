import 'package:flutter/material.dart';
import 'package:portfolio/widgets/layout/section_viewport.dart';

class PortfolioScrollView extends StatefulWidget {
  const PortfolioScrollView({
    super.key,
    required this.controller,
    required this.child,
  });

  final ScrollController controller;
  final Widget child;

  @override
  State<PortfolioScrollView> createState() => _PortfolioScrollViewState();
}

class _PortfolioScrollViewState extends State<PortfolioScrollView> {
  double _extent = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SectionViewport(
        size: constraints.biggest,
        contentExtent: _extent,
        child: NotificationListener<ScrollMetricsNotification>(
          onNotification: (notification) {
            if (notification.depth == 0 &&
                notification.metrics.axis == Axis.vertical &&
                _extent != notification.metrics.maxScrollExtent) {
              setState(() => _extent = notification.metrics.maxScrollExtent);
            }
            return false;
          },
          child: Scrollbar(
            controller: widget.controller,
            interactive: true,
            thumbVisibility: true,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                controller: widget.controller,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
