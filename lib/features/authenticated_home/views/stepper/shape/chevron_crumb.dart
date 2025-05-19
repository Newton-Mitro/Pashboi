import 'package:flutter/material.dart';

// mixin Chevron {
//   Path getChevronPath(Size size) {
//     final Path path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(size.width * 3.5 / 4, 0.0);
//     path.lineTo(size.width, size.height / 2);
//     path.lineTo(size.width * 3.5 / 4, size.height);
//     path.lineTo(0.0, size.height);
//     path.lineTo(size.width * .5 / 4, size.height / 2);
//     path.close();
//     return path;
//   }
// }

mixin Chevron {
  Path getChevronPath(Size size, {double cornerRadius = 3}) {
    final Path path = Path();

    final double w = size.width;
    final double h = size.height;

    final Offset p1 = Offset(0, 0);
    final Offset p2 = Offset(w * 3.5 / 4, 0);
    final Offset p3 = Offset(w, h / 2);
    final Offset p4 = Offset(w * 3.5 / 4, h);
    final Offset p5 = Offset(0, h);
    final Offset p6 = Offset(w * 0.5 / 4, h / 2.0);
    final Offset p7 = Offset(w * 0.5 / 4, h / 2.0);

    path.moveTo(p1.dx + 0, p1.dy);

    path.lineTo(p2.dx - cornerRadius, p2.dy);
    path.arcToPoint(
      p2.translate(0, cornerRadius),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    path.lineTo(p3.dx, p3.dy - 0);
    path.arcToPoint(
      p3.translate(-0, 0),
      radius: Radius.circular(2),
      clockwise: true,
    );

    path.lineTo(p3.dx, p3.dy - 0);
    path.arcToPoint(
      p3.translate(0, 0),
      radius: Radius.circular(0),
      clockwise: true,
    );

    path.lineTo(p4.dx, p4.dy - 0);
    path.arcToPoint(
      p4.translate(-0, 0),
      radius: Radius.circular(0),
      clockwise: true,
    );

    path.lineTo(p5.dx + cornerRadius, p5.dy);
    path.arcToPoint(
      p5.translate(2, -cornerRadius),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    path.lineTo(p6.dx + cornerRadius, p6.dy);
    path.arcToPoint(
      p6.translate(2, -cornerRadius),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    path.close();
    return path;
  }
}
