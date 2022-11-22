import 'package:flutter/material.dart';
import 'package:style/gesture/SpringPainter/spring_painter.dart';

///_kDefaultSpringHeight 为弹簧默认高度；
///_kRateOfMove 是移动距离与形变量比值，比如 1.5 ，则说明手指向下移动了 15 个逻辑像素，弹簧形变量为 10 个逻辑像素。
const double _kDefaultSpringHeight = 100; //弹簧默认高度
const double _kRateOfMove = 1.5; //移动距离与形变量比值

class SpringWidget extends StatefulWidget {
  const SpringWidget({Key? key}) : super(key: key);

  @override
  _SpringWidgetState createState() => _SpringWidgetState();
}



class _SpringWidgetState extends State<SpringWidget>  with SingleTickerProviderStateMixin{
  ///改动如下，现在想要动态改变的量是高度值，将 height 类型定义为 ValueListenable<double>
  ///并通过 super(repaint: height) 将画板与可监听对象绑定。这样，当 height 值发生变化，就会通知直接画板重绘。
  ValueNotifier<double> height = ValueNotifier(_kDefaultSpringHeight);
  late AnimationController  _ctrl;
  double s = 0; // 移动距离
  double laseMoveLen = 0;
  final Duration animDuration = const Duration(milliseconds: 400);
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration)
      ..addListener(_updateHeightByAnim);
    animation = CurvedAnimation(parent: _ctrl, curve: Curves.bounceOut);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _updateSpace, //更新监听的高度 监听到后画板重绘
      onVerticalDragEnd: _animateToDefault,//拖动结束就动画恢复原样
      child: Container(
        width: 200,
        height: 200,
        color: Colors.grey.withAlpha(11),
        child: CustomPaint(
            painter: SpringPainter(height: height)),
      ),
    );
  }

  double get dx => -s/_kRateOfMove;

  void _updateSpace(DragUpdateDetails details) {
    s += details.delta.dy;
    height.value = _kDefaultSpringHeight + dx;
  }

  @override
  void dispose() {
    height.dispose();
    super.dispose();
  }
  void _animateToDefault(DragEndDetails details) {
    laseMoveLen = s;
    _ctrl.forward(from: 0);
  }

  void _updateHeightByAnim() {
    s = laseMoveLen * (1 - animation.value);
    height.value = _kDefaultSpringHeight + (-s / _kRateOfMove);
  }
}
