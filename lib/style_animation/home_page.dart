import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
///动画的核心
///动画使用的核心是围绕着动画控制器 AnimationController ，主要分为三个方面：
///
/// [1]. 动画控制器 AnimationController 对象的创建与销毁。
///[2]. 在合适的时机，通过 动画控制器执行开启动画的方法。
/// [3]. 监听 动画控制器 数值的变化，重构组件进行界面更新。
class TextAnimation extends StatefulWidget {
  const TextAnimation({Key? key}) : super(key: key);

  @override
  State<TextAnimation> createState() => _TextAnimationState();
}

class _TextAnimationState extends State<TextAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('文字渐变'),),
        body: Center(
          child: Text(
      '渐变的文字',
      style: TextStyle(
          fontSize: 60,
          foreground: getPaint(),
      ),
    ),
        ));
  }


  final List<Color> colors = [
    Color(0xFFF60C0C), Color(0xFFF3B913), Color(0xFFE7F716),
    Color(0xFF3DF30B), Color(0xFF0DF6EF), Color(0xFF0829FB),
    Color(0xFFB709F4), ];

  final List<double> pos = [ 1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0 ];

  //2.文字外框模糊效果
  // 通过 paint 的 maskFilter 属性，可以设置遮罩过滤器
  // ，MaskFilter.blur 会创建一个模糊遮罩。BlurStyle.solid 样式是内部不变，
  // 外部进行模糊，第二参是模糊的程度，如下是 3 的效果。
  Paint getPaint() {
    Paint paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 2..maskFilter = const MaskFilter.blur(BlurStyle.solid, 10);
    paint.shader = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(100, 0),
      colors,
      pos,
      TileMode.mirror,
      Matrix4.rotationZ(pi / 6).storage, // 旋转变换
    );
    return paint;
  }
}
