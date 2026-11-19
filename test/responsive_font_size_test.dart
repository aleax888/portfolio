import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/design_system/utils/responsive_font_size.dart';

void main() {
  const target = 30.0;
  const reference = Size(1000, 600);
  const small = Size(500, 300);
  const large = Size(1500, 900);

  test(
    'All curves pass through the design target at the reference viewport',
    () {
      expect(
        ResponsiveFontSize.linear(target, reference, reference: reference),
        target,
      );
      expect(
        ResponsiveFontSize.logarithmic(target, reference, reference: reference),
        target,
      );
      expect(
        ResponsiveFontSize.exponential(target, reference, reference: reference),
        target,
      );
    },
  );

  test(
    'Equal changes in viewport produce linear, diminishing and accelerating growth',
    () {
      double linear(Size s) => ResponsiveFontSize.linear(
        target,
        s,
        reference: reference,
        slope: 0.8,
        maxScale: 3,
      );
      double log(Size s) => ResponsiveFontSize.logarithmic(
        target,
        s,
        reference: reference,
        curvature: 2,
        maxScale: 3,
      );
      double exp(Size s) => ResponsiveFontSize.exponential(
        target,
        s,
        reference: reference,
        rate: 0.75,
        minScale: 0.1,
        maxScale: 3,
      );
      expect(linear(large) - target, closeTo(target - linear(small), 1e-9));
      expect(log(large) - target, lessThan(target - log(small)));
      expect(exp(large) - target, greaterThan(target - exp(small)));
    },
  );

  test('The shorter dimension and the configured limits apply', () {
    expect(
      ResponsiveFontSize.linear(
        target,
        const Size(2000, 300),
        reference: reference,
      ),
      15,
    );
    expect(ResponsiveFontSize.linear(target, Size.zero, minScale: 0.5), 15);
    expect(
      ResponsiveFontSize.exponential(
        target,
        reference * 10,
        reference: reference,
        maxScale: 2,
      ),
      60,
    );
  });
}
