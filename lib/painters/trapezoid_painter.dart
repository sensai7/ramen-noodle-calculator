import 'package:flutter/material.dart';
import 'package:ramen_noodle_calc/constants.dart';

class TrapezoidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = kColorText;
    paint.style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 5, 0);
    path.lineTo(size.width * 4 / 5, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
