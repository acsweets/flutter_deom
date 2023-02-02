import 'dart:math';

import 'package:flutter/material.dart';

class DrawAnimationPage extends StatefulWidget {
  const DrawAnimationPage({Key? key}) : super(key: key);

  @override
  State<DrawAnimationPage> createState() => _DrawAnimationPageState();
}

class _DrawAnimationPageState extends State<DrawAnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Container(
            child: CustomPaint(
              size: Size(100, 100),
              painter: PiAnimationMan(), // 背景
            ),
          ),



        ],
      ),
    );
  }
}

class PiAnimationMan extends CustomPainter {
  final Color color; // 颜色
  final double angle; // 角度(与x轴交角 角度制)

  final Paint _paint = Paint();

  PiAnimationMan({this.color = Colors.yellowAccent, this.angle = 30});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size); //剪切画布
    final double radius = size.width / 2;
    canvas.translate(radius, size.height / 2);
    _drawHead(canvas,size);
  }

  void _drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(center: const Offset(0, 0), width: size.width, height: size.height);
    var a = angle / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true, _paint..color = color);
  }



  @override
  bool shouldRepaint(covariant PiAnimationMan oldDelegate) =>
      oldDelegate.color != color || oldDelegate.angle != angle;
}
