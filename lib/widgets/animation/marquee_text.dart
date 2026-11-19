import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:portfolio/design_system/constants/motion_constants.dart';

enum MarqueeDirection { left, right }

/// Scrolls one line across the panel at a speed in logical pixels per second.
class MarqueeText extends StatefulWidget {
  const MarqueeText({
    super.key,
    required this.text,
    this.style,
    this.speedPixelsPerSecond = MotionConstants.marqueePixelsPerSecond,
    this.initialDelay = Duration.zero,
    this.startOffsetFraction = 1,
    this.direction = MarqueeDirection.left,
  });

  final String text;
  final TextStyle? style;
  final double speedPixelsPerSecond;
  final Duration initialDelay;

  /// Initial position relative to the direction of motion. At 1 the text
  /// enters from outside the panel. At 0 it is already aligned inside it.
  final double startOffsetFraction;
  final MarqueeDirection direction;

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  final _rowKey = GlobalKey();
  final _offset = ValueNotifier<double>(0);
  late final Ticker _ticker;
  late Duration _delayLeft;
  Duration _lastElapsed = Duration.zero;
  double _panelWidth = 0;
  double _cycle = 0;
  bool _measurementPending = false;

  @override
  void initState() {
    super.initState();
    _delayLeft = widget.initialDelay;
    _ticker = createTicker(_onTick);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncTicker();
  }

  @override
  void didUpdateWidget(MarqueeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.direction != oldWidget.direction && _cycle > 0) {
      // Mirroring the origin and the distance preserves the text's position.
      _offset.value = _cycle - _offset.value;
    }
    _syncTicker();
  }

  void _syncTicker() {
    final running = widget.text.isNotEmpty && widget.speedPixelsPerSecond > 0
        && TickerMode.of(context);
    if (running && !_ticker.isActive) {
      _lastElapsed = Duration.zero;
      _ticker.start();
    } else if (!running && _ticker.isActive) {
      _ticker.stop();
    }
  }

  double _initialOffset(double width) =>
      width * (1 - widget.startOffsetFraction.clamp(0.0, 1.0));

  void _measureAfterLayout() {
    if (_measurementPending) return;
    _measurementPending = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measurementPending = false;
      if (!mounted) return;
      final row = _rowKey.currentContext?.findRenderObject() as RenderBox?;
      final panel = context.findRenderObject() as RenderBox?;
      if (row == null || !row.hasSize || panel == null || !panel.hasSize) return;
      final width = panel.size.width;
      final cycle = row.size.width - width;
      if (cycle == _cycle && width == _panelWidth) return;
      // A new origin after a resize must not restart the current pass.
      final originShift = widget.direction == MarqueeDirection.left
          ? width - _panelWidth
          : (cycle - width) - (_cycle - _panelWidth);
      _offset.value = _cycle == 0 ? _initialOffset(width)
          : (_offset.value + originShift).clamp(0.0, cycle);
      _panelWidth = width;
      _cycle = cycle;
    });
  }

  void _onTick(Duration elapsed) {
    var delta = elapsed - _lastElapsed;
    _lastElapsed = elapsed;
    if (_cycle <= 0) return;
    if (_delayLeft > Duration.zero) {
      final wait = delta < _delayLeft ? delta : _delayLeft;
      _delayLeft -= wait;
      delta -= wait;
    }
    if (delta == Duration.zero) return;
    final seconds = delta.inMicroseconds / Duration.microsecondsPerSecond;
    _offset.value = (_offset.value + widget.speedPixelsPerSecond * seconds) % _cycle;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.hasBoundedWidth
          ? constraints.maxWidth : MediaQuery.sizeOf(context).width;
      _measureAfterLayout();
      final left = widget.direction == MarqueeDirection.left;
      return SizedBox(width: width, child: ClipRect(child: OverflowBox(
        fit: OverflowBoxFit.deferToChild,
        alignment: left ? Alignment.centerLeft : Alignment.centerRight,
        minWidth: 0, maxWidth: double.infinity,
        minHeight: 0, maxHeight: double.infinity,
        child: ValueListenableBuilder<double>(
          valueListenable: _offset,
          builder: (context, offset, child) {
            final travel = _cycle == 0 ? _initialOffset(width) : offset;
            return Transform.translate(offset: Offset(left ? -travel : travel, 0), child: child);
          },
          child: NotificationListener<SizeChangedLayoutNotification>(
            onNotification: (_) {
              _measureAfterLayout();
              return false;
            },
            child: SizeChangedLayoutNotifier(child: Row(
              key: _rowKey, mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: width),
                Text(widget.text, style: widget.style, maxLines: 1, softWrap: false),
                SizedBox(width: width),
              ],
            )),
          ),
        ),
      )));
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    _offset.dispose();
    super.dispose();

  }
}
