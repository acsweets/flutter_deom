import 'dart:math';

import 'package:flutter/material.dart';

import '../bean/sector_shape.dart';
class PieDrawPage extends StatefulWidget {
  const PieDrawPage({Key? key}) : super(key: key);

  @override
  State<PieDrawPage> createState() => _PieDrawPageState();
}

class _PieDrawPageState extends State<PieDrawPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class PieDraw extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 2;

    SectorShape shape = SectorShape(
      center: Offset(size.width / 2, size.height / 2),
      innerRadius: 40,
      outRadius: 80,
      startAngle: 30 * pi / 180,
      sweepAngle: -80 * pi / 180,
    );

    canvas.drawPath(shape.formPath(), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }



  
}
