import 'package:flutter/material.dart';

class FadeSlideTransitionBuilder extends PageTransitionsBuilder {
  const FadeSlideTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1.0, 0.0), // Slide in from right
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOut)),
      ),
      child: SlideTransition(
        position: secondaryAnimation.drive(
          Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-1.0, 0.0), // Slide out to left
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: FadeTransition(opacity: animation, child: child),
      ),
    );
  }
}
