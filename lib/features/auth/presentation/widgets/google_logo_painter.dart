import 'package:flutter/material.dart';

class GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final center =
        Offset(size.width / 2, size.height / 2);

    final radius = size.width / 2;

    final colors = [
      const Color(0xFF4285F4),
      const Color(0xFFEA4335),
      const Color(0xFFFBBC05),
      const Color(0xFF34A853),
    ];

    final paint = Paint()
      ..style = PaintingStyle.fill;

    const sweepAngle =
        (2 * 3.14159) / 4;

    for (int i = 0; i < 4; i++) {
      paint.color = colors[i];

      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),

        i * sweepAngle - 3.14159 / 4,

        sweepAngle,

        true,

        paint,
      );
    }

    paint.color = Colors.white;

    canvas.drawCircle(
      center,
      radius * 0.55,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}