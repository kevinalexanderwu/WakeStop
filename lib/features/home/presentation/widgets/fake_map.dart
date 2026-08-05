import 'package:flutter/material.dart';

class FakeMap extends StatelessWidget {
  const FakeMap({super.key});

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: CustomPaint(
        painter: _FakeMapPainter(),
        child: SizedBox.expand(),
      ),
    );
  }
}

class _FakeMapPainter extends CustomPainter {
  const _FakeMapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFF8FAFC),
          Color(0xFFE2E8F0),
        ],
      ).createShader(
        Offset.zero & size,
      );

    canvas.drawRect(
      Offset.zero & size,
      background,
    );

    final minorRoad = Paint()
      ..color = const Color(0xFFD6DCE6)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    final majorRoad = Paint()
      ..color = const Color(0xFFC5CEDA)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final river = Paint()
      ..color = const Color(0xFFBFDBFE)
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    final park = Paint()
      ..color = const Color(0xFFD1FAE5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * .18, size.height * .28),
      42,
      park,
    );

    canvas.drawCircle(
      Offset(size.width * .82, size.height * .72),
      60,
      park,
    );

    final riverPath = Path()
      ..moveTo(size.width * .05, size.height * .82)
      ..quadraticBezierTo(
        size.width * .32,
        size.height * .62,
        size.width * .58,
        size.height * .74,
      )
      ..quadraticBezierTo(
        size.width * .82,
        size.height * .86,
        size.width,
        size.height * .58,
      );

    canvas.drawPath(riverPath, river);

    for (double y = 80; y < size.height; y += 120) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        minorRoad,
      );
    }

    for (double x = 70; x < size.width; x += 95) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        minorRoad,
      );
    }

    final major = Path()
      ..moveTo(size.width * .1, size.height * .1)
      ..quadraticBezierTo(
        size.width * .45,
        size.height * .28,
        size.width * .95,
        size.height * .18,
      );

    canvas.drawPath(major, majorRoad);

    final major2 = Path()
      ..moveTo(size.width * .08, size.height * .58)
      ..quadraticBezierTo(
        size.width * .48,
        size.height * .44,
        size.width * .92,
        size.height * .78,
      );

    canvas.drawPath(major2, majorRoad);

    final stationPaint = Paint()
      ..color = const Color(0xFF2563EB);

    final stations = [
      Offset(size.width * .28, size.height * .24),
      Offset(size.width * .55, size.height * .34),
      Offset(size.width * .73, size.height * .66),
      Offset(size.width * .42, size.height * .71),
      Offset(size.width * .81, size.height * .27),
    ];

    for (final station in stations) {
      canvas.drawCircle(
        station,
        7,
        stationPaint,
      );

      canvas.drawCircle(
        station,
        12,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}