import 'dart:math' as math;
import 'dart:ui';

import 'package:portfolio/design_system/constants/layout_constants.dart';

/// Returns a logical font size before Flutter applies the user's text scaling.
/// All curves pass through [target] at the reference viewport. The tighter
/// dimension sets the scale, including in short landscape windows.
abstract final class ResponsiveFontSize {
  static double linear(
    double target,
    Size viewport, {
    Size reference = LayoutConstants.referenceViewport,
    double slope = 1,
    double minScale = 0.4,
    double maxScale = 1.35,
  }) {
    assert(slope >= 0);
    final ratio = _ratio(viewport, reference);
    return _size(target, 1 + slope * (ratio - 1), minScale, maxScale);
  }

  static double logarithmic(
    double target,
    Size viewport, {
    Size reference = LayoutConstants.referenceViewport,
    double curvature = 3,
    double minScale = 0.4,
    double maxScale = 1.35,
  }) {
    assert(curvature > 0);
    final ratio = _ratio(viewport, reference);
    final scale = math.log(1 + curvature * ratio) / math.log(1 + curvature);
    return _size(target, scale, minScale, maxScale);
  }

  static double exponential(
    double target,
    Size viewport, {
    Size reference = LayoutConstants.referenceViewport,
    double rate = 1,
    double minScale = 0.4,
    double maxScale = 1.35,
  }) {
    assert(rate > 0);
    final ratio = _ratio(viewport, reference);
    final scale = (math.exp(rate * ratio) - 1) / (math.exp(rate) - 1);
    return _size(target, scale, minScale, maxScale);
  }

  static double _ratio(Size viewport, Size reference) {
    assert(reference.isFinite && reference.width > 0 && reference.height > 0);
    assert(viewport.isFinite && viewport.width >= 0 && viewport.height >= 0);
    return math.min(
      viewport.width / reference.width,
      viewport.height / reference.height,
    );
  }

  static double _size(double target, double scale, double min, double max) {
    assert(target > 0 && min > 0 && min <= 1 && max >= 1);
    return target * scale.clamp(min, max);
  }
}
