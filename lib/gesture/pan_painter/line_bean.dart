
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:style/gesture/pan_painter/point_bean.dart';

import '../../utils/enmu.dart';

class Line {
  List<Points> points = [];
  PaintState state;
  double strokeWidth;
  Color color;

  Line(
      {this.color = Colors.black,
        this.strokeWidth = 1,
        this.state = PaintState.doing});

  void paint(Canvas canvas, Paint paint) {
    paint
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth;
    canvas.drawPoints(PointMode.polygon,
        points.map<Offset>((e) => e.toOffset()).toList(),
        paint);
  }
}