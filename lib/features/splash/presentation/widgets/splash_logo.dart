import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
    this.size = 120,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * .30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x40FFFFFF),
            Color(0x15FFFFFF),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: .20),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .15),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Center(
        child: CustomPaint(
          size: Size.square(size * .55),
          painter: _WakeStopLogoPainter(),
        ),
      ),
    );
  }
}

class _WakeStopLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final blue = Paint()
      ..color = const Color(0xFF60A5FA)
      ..style = PaintingStyle.fill;

    final white = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final outline = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width * .06
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(
      center,
      size.width * .42,
      blue,
    );

    canvas.drawCircle(
      center,
      size.width * .42,
      outline,
    );

    final pin = Path();

    pin.moveTo(center.dx, size.height * .15);

    pin.quadraticBezierTo(
      size.width * .78,
      size.height * .28,
      size.width * .74,
      size.height * .54,
    );

    pin.quadraticBezierTo(
      size.width * .68,
      size.height * .80,
      center.dx,
      size.height * .94,
    );

    pin.quadraticBezierTo(
      size.width * .32,
      size.height * .80,
      size.width * .26,
      size.height * .54,
    );

    pin.quadraticBezierTo(
      size.width * .22,
      size.height * .28,
      center.dx,
      size.height * .15,
    );

    canvas.drawPath(pin, white);

    canvas.drawCircle(
      Offset(center.dx, size.height * .46),
      size.width * .11,
      blue,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}