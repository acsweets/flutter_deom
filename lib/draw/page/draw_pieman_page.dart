import 'dart:math';

import 'package:flutter/material.dart';
import 'package:style/draw/widget/snow2.dart';
import 'package:style/draw/widget/sonw.dart';

import '../widget/gesture.dart';
import '../widget/rule.dart';

class DrawPage extends StatefulWidget {
  const DrawPage({Key? key}) : super(key: key);

  @override
  State<DrawPage> createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  double _rotate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: CustomPaint(
                size: Size(100, 100),
                painter: PieMan(), // 背景
              ),
            ),

            Container(
              child: CustomPaint(
                size: Size(100, 100),
                painter: SnowPainter1(), // 雪花
              ),
            ),
            Container(
              color: Colors.orange,
              child: CustomPaint(
                size: Size(100, 100),
                painter: Snow2(), // 雪花
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Transform.rotate(
                    angle: _rotate,
                    child: Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  HandleWidget(
                    size: 200,
                    onMove: _onMove,
                  )
                ],
              ),
            ),

            ///尺子

            Center(
              child: Ruler(
                min: 1,
                max: 200,
                size: Size(300.0, 100),
                onChange: (double) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMove(double rotate, double distance) {
    setState(() {
      _rotate = rotate;
    });
  }
}

class PieMan extends CustomPainter {
  final Color color; // 颜色
  final double angle; // 角度(与x轴交角 角度制)

  final Paint _paint = Paint();

  PieMan({this.color = Colors.yellowAccent, this.angle = 30});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size); //剪切画布
    final double radius = size.width / 2;
    canvas.translate(radius, size.height / 2);
    _drawHead(canvas, size);
  }

  void _drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(center: const Offset(0, 0), width: size.width, height: size.height);
    var a = angle / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true, _paint..color = color);
  }

  @override
  bool shouldRepaint(covariant PieMan oldDelegate) => oldDelegate.color != color || oldDelegate.angle != angle;
}
