import 'package:flutter/material.dart';
import 'package:style/gesture/tap_paper/stamp.dart';

class StampPainter extends CustomPainter {
  final StampData stamps;
  final int? count;
  final Paint _paint = Paint();
  final Paint _pathPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  StampPainter({
    required this.stamps,
    this.count,
  }) : super(repaint: stamps);

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);

    ///中心点已经固定从点击点 确定是哪个格子
    for (var stamp in stamps.stamps) {
      double length = size.width / count!;
      int x = stamp.center.dx ~/ length; //横向第几个
      int y = stamp.center.dy ~/ length; //纵向第几个
      double strokeWidth = stamp.radius * 0.07; //笔的宽度

      Offset center = Offset(length * x + length / 2, length * y + length / 2);
      stamp.center = center;
      canvas.drawCircle(stamp.center, stamp.radius, _paint..color = stamp.color);
      canvas.drawPath(
          stamp.path,
          _pathPaint
            ..strokeWidth = strokeWidth
            ..color = Colors.white);
      canvas.drawCircle(stamp.center, stamp.radius + strokeWidth * 1.5, _pathPaint..color = stamp.color);
    }
  }

  @override
  bool shouldRepaint(covariant StampPainter oldDelegate) {
    return this.stamps != oldDelegate.stamps;
  }
}
