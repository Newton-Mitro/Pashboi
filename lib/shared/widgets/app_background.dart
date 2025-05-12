import 'package:flutter/material.dart';
import 'package:pashboi/core/constants/app_images.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AppImages.pathBackgroundImage, fit: BoxFit.cover),
        ),

        child,
      ],
    );
  }
}
