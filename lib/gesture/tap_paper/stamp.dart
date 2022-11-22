import 'dart:math';

import 'package:flutter/material.dart';

import '../../utils/enmu.dart';

class Stamp {
  Color color;
  Offset center;
  double radius;
  Path ?_path;

  Stamp({
    this.color = Colors.blue,
    required this.center,
    this.radius = 20,
  });

  Path get path {
    if (_path == null) {
      _path = Path();
      double r = radius;
      double rad = 30 / 180 * pi;

      _path!.moveTo(center.dx, center.dy);
      _path!.relativeMoveTo(r * cos(rad), -r * sin(rad));
      _path!.relativeLineTo(-2 * r * cos(rad), 0);
     _path!.relativeLineTo(r * cos(rad), r + r * sin(rad));
        _path!.relativeLineTo(r * cos(rad), -(r + r * sin(rad)));
      _path!.moveTo(center.dx, center.dy);
      _path!.relativeMoveTo(0, -r);
      _path!.relativeLineTo(-r * cos(rad), r + r * sin(rad));
      _path!.relativeLineTo(2 * r * cos(rad), 0);
      _path!.relativeLineTo(-r * cos(rad), -(r + r * sin(rad)));

      return _path!;
    } else {
      return _path!;
    }
  }
  void rePath() {
    _path = null;
    _path = path;
  }
}

class StampData extends ChangeNotifier {
  final List<Stamp> stamps = [];
  final Paint _paint = Paint();

  void push(Stamp stamp) {
    stamps.add(stamp);
    notifyListeners();
  }

  void removeLast() {
    stamps.removeLast();
    notifyListeners();
  }

  void activeLast({Color color = Colors.blue}) {
    stamps.last.color = color;
    notifyListeners();
  }

  void clear() {
    stamps.clear();
    notifyListeners();
  }

  void animateAt(int index, double radius) {
    stamps[index].radius = radius;
    stamps[index].rePath();
    notifyListeners();
  }

  // 校验胜负，返回游戏状态
  GameState
  checkWin(double length){
    bool redWin = _checkWinByColor(length,Colors.red);
    if(redWin) return GameState.redWin;

    bool blueWin = _checkWinByColor(length,Colors.blue);
    if(blueWin) return GameState.blueWin;
    return GameState.doing;
  }


  // 校验某种颜色点是否获胜
  bool _checkWinByColor(double length,Color color) {
    List<Offset> red = stamps
        .where((element) => element.color == color)
        .map((e) => e.center)
        .toList();
    List<Point<int>> redPoints = red
        .map<Point<int>>((e) => Point<int>(e.dx ~/ length, e.dy ~/ length))
        .toList();
    return _checkWinInline(redPoints, 3);
  }
// 核心方法，校验 [points] 坐标，是否满足
// 四方向上 [max] 个连珠
  bool _checkWinInline(List<Point<int>> points, int max) {
    //长度不够直接返回
    if (points.length < max) return false;

    for (int i = 0; i < points.length; i++) {
      int x = points[i].x;
      int y = points[i].y;
      if (_check(x, y, points, CheckModel.horizontal,max)) {
        return true;
      } else if (_check(x, y, points, CheckModel.vertical,max)) {
        return true;
      } else if (_check(x, y, points, CheckModel.leftDiagonal,max)) {
        return true;
      } else if (_check(x, y, points, CheckModel.rightDiagonal,max)) {
        return true;
      }
    }
    return false;
  }
  // 最核心方法，检测某点 [x,y] 的 [checkModel] 方向
// 是否存在满足 [max] 连珠
  bool _check(int x, int y, List<Point> points, CheckModel checkModel,int max) {
    int count = 1;
    Point checkPoint;
    for (int i = 1; i < max; i++) {
      switch (checkModel) {
        case CheckModel.horizontal: checkPoint = Point(x - i, y); break;
        case CheckModel.vertical: checkPoint = Point(x, y - i); break;
        case CheckModel.leftDiagonal: checkPoint = Point(x - i, y + i);break;
        case CheckModel.rightDiagonal: checkPoint = Point(x + i, y + i); break;
      }
      if (points.contains(checkPoint)) {count++;} else {break;}
    }
    if (count == max) return true;
    return false;
  }
}
