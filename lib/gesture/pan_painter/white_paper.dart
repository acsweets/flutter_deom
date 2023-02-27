import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:style/gesture/pan_painter/component/paint_setting_dialog.dart';
import 'package:style/gesture/pan_painter/line_bean.dart';
import 'package:style/gesture/pan_painter/paint_model.dart';
import 'package:style/gesture/pan_painter/pan_painter.dart';
import 'package:style/gesture/pan_painter/point_bean.dart';

class WhitePaper extends StatefulWidget {
  const WhitePaper({Key? key}) : super(key: key);

  @override
  State<WhitePaper> createState() => _WhitePaperState();
}

class _WhitePaperState extends State<WhitePaper> {
  final PaintModel paintModel = PaintModel();
  Color lineColor = Colors.black;
  double strokeWidth = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showSettingDialog,
      onPanDown: _initLineDate,
      onPanUpdate: _collectPoint,
      onPanEnd: _doneALine,
      onPanCancel: _cancel,
      onDoubleTap: _clear,
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: PanPainter(model: paintModel),
      ),
    );
  }

  void _initLineDate(DragDownDetails details) {
    Line line = Line(color: lineColor, strokeWidth: strokeWidth);
    paintModel.pushLine(line);
  }

  void _doneALine(DragEndDetails details) {
    paintModel.doneLine();
  }

  void _collectPoint(DragUpdateDetails details) {
    paintModel.pushPoint(Point.fromOffset(details.localPosition));
  }

  void _clear() {
    paintModel.clear();
  }

  void _cancel() {
    paintModel.removeEmpty();
  }

  @override
  void dispose() {
    paintModel.dispose();
    super.dispose();
  }

  void _showSettingDialog() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => PaintSettingDialog(
              initColor: lineColor,
              initWidth: strokeWidth,
              onLineWidthSelect: _selectWidth,
              onColorSelect: _selectColor,
            ));
  }

  void _selectColor(Color color) {
    lineColor = color;
  }

  void _selectWidth(double width) {
    strokeWidth = width;
  }
}
