import 'package:flutter/material.dart';

class AnimacionesAutenticacion {
  // Equivalente Flutter de .fade-up, .fade-view y feedback CSS.
  static const Duration fadeUpDuration = Duration(milliseconds: 720);
  static const Duration swapViewDuration = Duration(milliseconds: 520);
  static const Duration hoverDuration = Duration(milliseconds: 180);
  static const Duration feedbackEntranceDuration = Duration(milliseconds: 360);
  static const Duration resendLimitShakeDuration = Duration(milliseconds: 420);

  static const Offset fadeUpOffset = Offset(0, 34);
  static const double fadeViewInitialScale = 0.96;

  static Duration getDelay(int index) {
    return Duration(milliseconds: 90 + (index - 1) * 100);
  }

  static const Curve defaultCurve = Curves.ease;

  static Widget fadeUp({
    required Widget child,
    required AnimationController controller,
    required int delayIndex,
  }) {
    const totalMs = 1310;
    final delayMs = getDelay(delayIndex).inMilliseconds;
    final start = delayMs / totalMs;
    final end = ((delayMs + fadeUpDuration.inMilliseconds) / totalMs).clamp(
      0.0,
      1.0,
    );

    final fade = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: defaultCurve),
    );
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.34),
      end: Offset.zero,
    ).animate(fade);

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }

  static Widget fadeView({required Widget child}) {
    return TweenAnimationBuilder<double>(
      duration: swapViewDuration,
      curve: defaultCurve,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, animatedChild) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: fadeViewInitialScale + ((1 - fadeViewInitialScale) * value),
            child: animatedChild,
          ),
        );
      },
      child: child,
    );
  }

  static Widget feedback({required Widget child, bool isError = false}) {
    return TweenAnimationBuilder<double>(
      duration: isError ? resendLimitShakeDuration : feedbackEntranceDuration,
      curve: defaultCurve,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, animatedChild) {
        final entranceValue = value.clamp(0.0, 1.0);
        final shake = isError ? _shakeOffset(value) : 0.0;

        return Opacity(
          opacity: entranceValue,
          child: Transform.translate(
            offset: Offset(shake, -6 * (1 - entranceValue)),
            child: animatedChild,
          ),
        );
      },
      child: child,
    );
  }

  static Widget authLinkMotion({required Widget child, required bool hovered}) {
    return AnimatedSlide(
      duration: hoverDuration,
      curve: defaultCurve,
      offset: hovered ? const Offset(0, -0.08) : Offset.zero,
      child: child,
    );
  }

  static double _shakeOffset(double value) {
    if (value < 0.25) return -5 * (value / 0.25);
    if (value < 0.50) return -5 + (10 * ((value - 0.25) / 0.25));
    if (value < 0.75) return 5 - (8 * ((value - 0.50) / 0.25));
    return -3 + (3 * ((value - 0.75) / 0.25));
  }
}
