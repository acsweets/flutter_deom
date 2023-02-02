import 'dart:math';
import 'package:flutter/material.dart';

class Snow2 extends CustomPainter {
  final Paint _mainPainter = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    double rate = 1 / 158 * size.width / 2;
//基础的尖尖
    Path p1 = Path()
      ..lineTo(-50 * rate, 0)
      ..lineTo(-60 * rate, 10 * rate)
      ..lineTo(-50 * rate, 20 * rate)
      ..lineTo(0, 20 * rate)
      ..close();
//合并的竖尖尖
     Path p2 = p1.transform(Matrix4.rotationZ(pi/2).storage);
     p2 = Path.combine(PathOperation.union, p2,  p1.transform(Matrix4.rotationZ(3*pi/2).storage).shift(Offset(-20*rate,-40*rate)));


 //由基础合并的长尖尖
    Path p3= Path();
      p3.addRect(Rect.fromCenter(center: Offset(80 * rate / 2, 10 * rate), width: 110 * rate, height: 20 * rate));
      p3 = Path.combine(PathOperation.union, p3,  p1);
      p2= Path.combine(PathOperation.union, p3,  p2.shift(Offset(-4,30*rate)));
    //
    Path p4 = p1.transform(Matrix4.rotationZ(pi/4).storage)..shift(Offset(50*rate,0));
    p4 = Path.combine(PathOperation.union, p4.shift(Offset(10*rate,0)),  p4.transform(Matrix4.rotationZ(3*pi/2).storage));
    p2= Path.combine(PathOperation.union, p2,  p4.shift(Offset(50*rate,2*rate)));

    p2 = p2.transform(Matrix4.diagonal3Values(0.5,0.5,1).storage);
 //   canvas.drawPath(p2.shift(Offset(-100*rate,0)), _mainPainter);
    for(int i=0;i<8;i++){
      canvas.rotate(2*pi/8*i);
      canvas.save();
      canvas.rotate(23/180*pi);
      canvas.translate(30*rate, 0);
      canvas.drawPath(p2.shift(Offset(-100*rate,0)), _mainPainter);
      canvas.restore();
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  ///路劲联合
  Path combineAll(List<Path> paths, {PathOperation operation = PathOperation.union}) {
    if (paths.isEmpty) return Path();
    if (paths.length <= 1) return paths.first;
    Path result = paths.first;
    for (int i = 1; i < paths.length; i++) {
      result = Path.combine(operation, paths[i], result);
    }
    return result;
  }
}
