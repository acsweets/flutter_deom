import 'package:flutter/material.dart';
import 'package:style/gesture/pan_painter/point_bean.dart';

import '../../utils/enmu.dart';
import 'line_bean.dart';
///3. 绘制数据的整合类白板是线集在屏幕上的体现，这里通过 PaintModel 类进行整合，让他继承自 ChangeNotifier，表示他是一个可监听对象，这样和画板联合使用就相得益彰。
/// PaintModel 对象可以通过 notifyListeners 直接通知画板进行重绘，从而避免使用 setState 对组件进行重构。
///下面定义了一些基本的方法，主要作用就是维护 _lines 列表，这里有一个 activeLine 的概念，表示当前绘制的点。
/// 当触点按下时，会添加一个 doing 状态的 line ，在抬手时，会置为 done 。这样可以保证只有一个activeLine，
///在移动中通过 pushPoint 来收集 Point 放入 activeLine 中，这样整体逻辑就会很清晰。
class PaintModel extends ChangeNotifier {
  List<Line> _lines = [];

  List<Line> get lines=>_lines;

  Line get activeLine =>
      _lines.singleWhere((element) => element.state == PaintState.doing,
          orElse: () => null as Line );

  void pushLine(Line line) {
    _lines.add(line);
  }

  void pushPoint(Points point) {
    if (activeLine == null) return;
    activeLine.points.add(point);
    notifyListeners();
  }

  void doneLine() {
    if (activeLine == null) return;
    activeLine.state = PaintState.done;
    notifyListeners();
  }

  void clear(){
    _lines.forEach((line) => line.points.clear());
    _lines.clear();
    notifyListeners();
  }

  void removeEmpty() {
    _lines.removeWhere((element) => element.points.length == 0);
  }
}