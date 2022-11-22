
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///绘制弹簧弹簧的表现主要取决于：宽、高、节数 三个量，
///这里为了方便起见，宽度定为常量 30。高(height)和节数(count)通过构造函数传入。
///y 轴上是负，x轴右是负

class SpringPainter extends CustomPainter {
  static const double springWidth = 30;
  final int count;
  final ValueListenable<double> height;

  SpringPainter({this.count = 20, required this.height}):super(repaint: height);

  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1
    ..color = Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    _drawSpring(canvas, size);
  }

  _drawSpring(Canvas canvas, Size size) {
 //   print(' $size');
    canvas.translate(size.width / 2 + springWidth / 2, size.height);
    Path springPath = Path();
    springPath.relativeLineTo(-springWidth, 0);
    double space = height.value / (count - 1);
    for (int i = 1; i < count; i++) {
      if (i % 2 == 1) {
        springPath.relativeLineTo(springWidth, -space);
      } else {
        springPath.relativeLineTo(-springWidth, -space);
      }
    }
    springPath.relativeLineTo(count.isOdd?springWidth:-springWidth, 0);
    canvas.drawPath(springPath, _paint);
  }

  @override
  bool shouldRepaint(covariant SpringPainter oldDelegate) => oldDelegate.count != count || oldDelegate.height != height;

  ///高度跟数量改变就重绘
}
