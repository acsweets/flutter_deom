import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class BackGroundPainter extends CustomPainter {
  BackGroundPainter({this.count = 3});

  final int count;

  final Paint _pathPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  static const List<Color> colors = [
    Color(0xFFF60C0C),
    Color(0xFFF3B913),
    Color(0xFFE7F716),
    Color(0xFF3DF30B),
    Color(0xFF0DF6EF),
    Color(0xFF0829FB),
    Color(0xFFB709F4)
  ];

  static const List<double> pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);
    _pathPaint.shader =
        ui.Gradient.sweep(Offset(size.width / 2, size.height / 2), colors, pos, TileMode.mirror, pi / 2, pi);
    canvas.save();
    for (int i = 0; i < count+1 ; i++) {
      canvas.drawLine(Offset.zero, Offset(size.width, 0), _pathPaint);
      canvas.translate(0, size.height / count);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < count+1 ; i++) {
      canvas.drawLine(Offset.zero, Offset(0, size.height), _pathPaint);
      canvas.translate(size.width / count, 0);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant BackGroundPainter oldDelegate) {
    return count != oldDelegate.count;
  }
}
