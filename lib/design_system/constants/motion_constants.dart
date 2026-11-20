abstract final class MotionConstants {
  /// Time for a wheel impulse to cover about 63% of the remaining distance.
  static const wheelResponseTime = Duration(milliseconds: 72);
  static const headerTransitionDuration = Duration(milliseconds: 250);
  static const headerVisibleDuration = Duration(seconds: 2);
  static const revealDuration = Duration(seconds: 2);
  static const translationDuration = Duration(seconds: 2);
  static const navigationDuration = Duration(milliseconds: 500);
  static const splitDuration = Duration(seconds: 2);
  static const levitationDuration = Duration(milliseconds: 1800);
  static const marqueePixelsPerSecond = 48.0;
  static const typingPixelsPerCharacter = 70.0;
  static const lottiePixelsPerFrame = 16.0;
}
