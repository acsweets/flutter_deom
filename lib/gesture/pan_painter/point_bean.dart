import 'package:flutter/material.dart';

class Points {
  final double? x;
  final double? y;

  const Points({this.x, this.y});

  factory Points.fromOffset(Offset offset) {
    return Points(
      x: offset.dx,
      y: offset.dy,
    );
  }

  Offset toOffset() => Offset(x!, y!);
}
