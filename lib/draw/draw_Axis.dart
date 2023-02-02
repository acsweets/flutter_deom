import 'dart:math';

import 'package:flutter/material.dart';
import 'package:style/draw/page/draw_animation_pieman.dart';
import 'package:style/draw/page/draw_pieman_page.dart';

class AxisPage extends StatefulWidget {
  const AxisPage({Key? key}) : super(key: key);

  @override
  State<AxisPage> createState() => _AxisPageState();
}

class _AxisPageState extends State<AxisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('111'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
              child: Text("吃豆人"),
              onPressed: () {
                //导航到新路由
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return DrawPage();
                  }),
                );
              },
            ),
            TextButton(
              child: Text("吃豆人带动画"),
              onPressed: () {
                //导航到新路由
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return DrawAnimationPage();
                  }),
                );
              },
            ),
            Container(
              height: 200,
              width: 200,
              color: Colors.white,
              child: CustomPaint(
                painter: DrawAxis(),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}

class DrawAxis extends CustomPainter {
  late Paint _gridPint; // 画笔
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.red; // 线颜色

  DrawAxis() {
    _gridPint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.translate(size.width / 2, size.height / 2);
    //   _drawGrid(canvas, size);
    drawGrid(canvas, size);
    // TODO: implement paint
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    _drawBottomRight(canvas, size);
    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void drawGrid(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < (size.height / step) + 1; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width, 0), _gridPint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < (size.width / step) + 1; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height), _gridPint);
      canvas.translate(step, 0);
    }
    canvas.restore();

    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(
        Offset.zero,
        step * 2,
        _gridPint
          ..color = Colors.green
          ..strokeWidth = 2);

    canvas.save();
    for (int i = 0; i < 24; i++) {
      canvas.drawLine(
          Offset(step * 2, 0),
          Offset(step * 3, 0),
          _gridPint
            ..color = Colors.blue
            ..strokeWidth = 2);
      canvas.rotate(2 * pi / 24);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
