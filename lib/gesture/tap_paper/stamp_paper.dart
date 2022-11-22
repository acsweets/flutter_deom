import 'package:flutter/material.dart';
import 'package:style/gesture/tap_paper/stamp.dart';
import 'package:style/gesture/tap_paper/stamp_painter.dart';

import '../../utils/enmu.dart';
import 'back_groug_painter.dart';

class StampPaper extends StatefulWidget {
  @override
  _StampPaperState createState() => _StampPaperState();
}

class _StampPaperState extends State<StampPaper> with SingleTickerProviderStateMixin {
  final StampData stamps = StampData();
  int gridCount = 3; // 网格数
  double radius = 0; // 图章半径
  double width = 0;

  AnimationController? _controller;
  final Duration animDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: animDuration)..addListener(_listenAnim);
  }

  void _listenAnim() {
    if (_controller!.value == 1.0) {
      _controller!.reverse();
    }
    double rate = (0.9 - 1) * _controller!.value + 1;
    stamps.animateAt(containsIndex, rate * radius);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide * 0.8;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onDoubleTap: _clear,
      onTapCancel: _removeLast,
      child: CustomPaint(
        foregroundPainter: StampPainter(stamps: stamps, count: gridCount), // 图章在前景
        painter: BackGroundPainter(count: gridCount), // 网格在背景
        size: Size(width, width),
      ),
    );
  }

  GameState gameState = GameState.doing;

  bool get gameOver => gameState != GameState.doing;

  bool get contains => containsIndex != -1;

  void _onTapDown(TapDownDetails details) {
    if (gameOver) return;
    containsIndex = checkZone(details.localPosition);
    if (contains) {
      _controller!.forward();
      return;
    }

    radius = width / 2 / gridCount * 0.618;
    stamps.push(Stamp(radius: radius, center: details.localPosition, color: Colors.grey));
  }

  void _onTapUp(TapUpDetails details) {
    if (contains || gameOver) return;
    stamps.activeLast(color: stamps.stamps.length % 2 == 0 ? Colors.red : Colors.blue);
    gameState = stamps.checkWin(width / gridCount);

    if (gameState == GameState.redWin) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("红棋获胜!"),
        backgroundColor: Colors.red,
      ));
    }
    if (gameState == GameState.blueWin) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("蓝棋获胜!"), backgroundColor: Colors.blue));
    }
  }

  void _clear() {
    stamps.clear();
    gameState = GameState.doing;
  }

  void _removeLast() {
    if (contains || gameOver) return;
    stamps.removeLast();
  }

  ///校验是否已有图章
  int containsIndex = -1;

  int checkZone(Offset src) {
    double width = MediaQuery.of(context).size.shortestSide * 0.8;
    for (int i = 0; i < stamps.stamps.length; i++) {
      Rect zone = Rect.fromCircle(
          center: stamps.stamps[i].center, radius: width / gridCount / 2); // radius: width / gridCount / 2半径固定  中心点不断变化
      if (zone.contains(src)) {
        ///判断已有的图章 建立矩形中有包含这个点  证明这个图章重复返回图章数组的下标
        return i;
      }
    }
    //不重复
    return -1;
  }

  @override
  void dispose() {
    stamps.dispose();
    super.dispose();
  }
}
