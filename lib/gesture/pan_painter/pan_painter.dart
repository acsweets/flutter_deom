import 'package:flutter/cupertino.dart';
import 'package:style/gesture/pan_painter/paint_model.dart';
import 'package:style/gesture/pan_painter/point_bean.dart';

///[1]. 通过实际案例练习拖拽、长按手势的使用。
///[2]. 练习基础绘制和维护数据的能力。
///[3]. 如何进行触点的区域校验判断，进行线段的激活检测。
///[4]. 通过曲线拟合、线颜色粗细选择完善白板。

class PanPainter extends CustomPainter {
  PaintModel model;

  PanPainter({required this.model}) : super(repaint: model);

  final Paint _paint = Paint()..strokeCap = StrokeCap.round ;

  @override
  void paint(Canvas canvas, Size size) {
    for (var line in model.lines) {
      line.paint(canvas, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant PanPainter oldDelegate) =>oldDelegate.model !=model;
}
