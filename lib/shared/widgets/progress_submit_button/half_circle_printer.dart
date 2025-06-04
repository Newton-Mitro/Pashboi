import 'dart:math';

import 'package:flutter/material.dart';

class HalfCirclePainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  HalfCirclePainter({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect arcRect = Rect.fromLTWH(0, 0, size.width, size.height * 2);

    // Draw shadow
    canvas.drawShadow(
      Path()..addArc(arcRect, pi, pi),
      Colors.black.withOpacity(0.4),
      4.0,
      false,
    );

    // Base half-circle
    final Paint background =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill;

    canvas.drawArc(arcRect, pi, pi, true, background);

    // Progress ring
    final Paint progressPaint =
        Paint()
          ..color = progressColor
          ..strokeWidth = 5
          ..style = PaintingStyle.stroke;

    canvas.drawArc(arcRect, pi, pi * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant HalfCirclePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor;
  }
}
