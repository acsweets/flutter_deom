import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
///画布更好的刷新，触发重绘的最高效方式是:
// [1]：继承 [CustomPainter] 类，并在构造函数提供一个 'repaint' 参数，
//      当需要重新绘制时，该对象会进行通知它的监听者。
// [2]：继承 [Listenable] (比如通过 [ChangeNotifier])并实现 [CustomPainter]，
// 			这样对象本身就可以直接提供通知。最终发现了一个共性：当绘制中含有动画和滑动处理时，
// 			都会使用 repaint 设置监听对象来触发刷新，对于仅是静态的绘制，则使用时将绘制属性暴露出去，
// 			交由外界处理，需要刷新的话，只能通过重建画板对象。其实这也很容易理解： 动画 和 滑动 的触发频率非常高，
// 			所以才会用特殊的方式进行重绘。
// 那么画板的重绘必须只是通过 可监听对象 吗？并非如此，虽然可以通过可监听对象来触发画布刷新
// ，比如_PlaceholderPainter 中 color 成员变为 ValueNotifier<Color> ，但这样就会增加用户使用的复杂性。对于非频繁刷新的场景，
// 局部刷新也就够了，这应该就是源码中，在非 动画和滑动 中不使用 repaint 的原因。但对于频繁触发的绘制，如 动画 和 滑动  一定要用。
// 最后想说一句：任何东西都不会完美无缺。成年人的世界，没有对错，只有适合与不适合
//


class ShapePage extends StatefulWidget {
  const ShapePage({Key? key}) : super(key: key);

  @override
  State<ShapePage> createState() => _ShapePageState();
}

class _ShapePageState extends State<ShapePage> with SingleTickerProviderStateMixin {
  AnimationController? _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 3))..addListener(_update);
    _ctrl!.forward();
  }

  @override
  void dispose() {
    _ctrl!.dispose();
    super.dispose();
  }

  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomPaint(
        size: Size(100, 100),
        painter: ShapePainter(factor: _ctrl),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final Animation<double>? factor;
  ///依赖动画变化的值来刷新

  ShapePainter({this.factor}) : super(repaint: factor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.lerp(Colors.red, Colors.blue, factor!.value)!;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) {
    return oldDelegate.factor != factor;
    //值变化就刷新
  }
}
