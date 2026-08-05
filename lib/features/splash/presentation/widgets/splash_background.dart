import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0, -1.0),
                end: Alignment(0.2, 1.0),
                colors: [
                  Color(0xFF0F1829),
                  Color(0xFF1E3A8A),
                  Color(0xFF2563EB),
                ],
                stops: [
                  0.0,
                  0.55,
                  1.0,
                ],
              ),
            ),
          ),
        ),

        Positioned.fill(
          child: CustomPaint(
            painter: _GhostMapPainter(),
          ),
        ),
      ],
    );
  }
}

class _GhostMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final minor = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final major = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final horizontal = [
      100.0,
      200.0,
      300.0,
      400.0,
      500.0,
      600.0,
      700.0,
      800.0,
    ];

    for (final y in horizontal) {
      final yy = y / 844 * size.height;

      canvas.drawLine(
        Offset(0, yy),
        Offset(size.width, yy),
        y == 400 ? major : minor,
      );
    }

    final vertical = [
      80.0,
      160.0,
      240.0,
      310.0,
      390.0,
    ];

    for (final x in vertical) {
      final xx = x / 390 * size.width;

      canvas.drawLine(
        Offset(xx, 0),
        Offset(xx, size.height),
        x == 310 ? major : minor,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}