import 'dart:math';

import 'package:flutter/material.dart';

class HandleWidget extends StatefulWidget {
  final double size;
  final double handleRadius;

  ///传入一个移动角度跟距离
  final void Function(double rotate, double distace) onMove;

  HandleWidget({Key? key, this.size = 60.0, this.handleRadius = 30.0, required this.onMove}) : super(key: key);

  @override
  _HandleWidgetState createState() => _HandleWidgetState();
}

class _HandleWidgetState extends State<HandleWidget> {
  ValueNotifier<Offset> _offset = ValueNotifier(Offset.zero);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: reset,
      onPanUpdate: parser,
      child: CustomPaint(
          size: Size(widget.size, widget.size), painter: _HandlePainter(handleR: widget.handleRadius, offset: _offset)),
    );
  }

  ///松手复位
  reset(DragEndDetails details) {
    _offset.value = Offset.zero;
    widget.onMove(0, 0);
  }

  parser(DragUpdateDetails details) {
    final offset = details.localPosition;
    double dx = 0.0;
    double dy = 0.0;
    dx = offset.dx - widget.size / 2;
    dy = offset.dy - widget.size / 2;
    var rad = atan2(dx, dy);
    if (dx < 0) {
      rad += 2 * pi;
    }

    var bgR = widget.size / 2 - widget.handleRadius;
    var thta = rad - pi / 2;
    var d = sqrt(dx * dx + dy * dy);
    if (d > bgR) {
      dx = bgR * cos(thta);
      dy = -bgR * sin(thta);
    }
    widget.onMove(thta, d);
    _offset.value = Offset(dx, dy);
  }
}

class _HandlePainter extends CustomPainter {
  var _paint = Paint();
  final ValueNotifier<Offset> offset;

  var handleR;

  _HandlePainter({this.handleR, required this.offset}) : super(repaint: offset) {
    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final bgR = size.width / 2 - handleR;
    canvas.translate(size.width / 2, size.height / 2);

    _paint.color = _paint.color.withAlpha(100);

    canvas.drawCircle(Offset(0, 0), bgR, _paint);//大圆
    _paint.color = _paint.color.withAlpha(150);
    canvas.drawCircle(Offset(offset.value.dx, offset.value.dy), handleR, _paint);
    canvas.drawLine(Offset.zero,offset.value, _paint);
  }

  @override
  bool shouldRepaint(_HandlePainter oldDelegate) => oldDelegate.handleR != handleR;
}
