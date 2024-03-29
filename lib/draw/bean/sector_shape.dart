import 'dart:math';
import 'dart:ui';

class SectorShape {
  Offset center; // 中心点
  double innerRadius; // 小圆半径
  double outRadius; // 大圆半径
  double startAngle; // 起始弧度   起始角度： 与横纵夹角(弧度)
  double sweepAngle; // 扫描弧度   扫描角度： 弧度值，顺时针为正

  SectorShape({
    required this.center,
    required this.innerRadius,
    required this.outRadius,
    required this.startAngle,
    required this.sweepAngle,
  });



  Path formPath() {


    double startRad = startAngle;
    double endRad = startAngle + sweepAngle;

    double r0 = innerRadius;
    double r1 = outRadius;
    Offset p0 = Offset(cos(startRad) * r0, sin(startRad) * r0);
    Offset p1 = Offset(cos(startRad) * r1, sin(startRad) * r1);
    Offset q0 = Offset(cos(endRad) * r0, sin(endRad) * r0);
    Offset q1 = Offset(cos(endRad) * r1, sin(endRad) * r1);

    bool large = sweepAngle.abs() > pi;
    bool clockwise = sweepAngle > 0;

    Path path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..lineTo(p1.dx, p1.dy)
      ..arcToPoint(q1, radius: Radius.circular(r1), clockwise: clockwise, largeArc: large)
      ..lineTo(q0.dx, q0.dy)
      ..arcToPoint(p0, radius: Radius.circular(r0), clockwise: !clockwise, largeArc: large);
    return path.shift(center);
  }
}