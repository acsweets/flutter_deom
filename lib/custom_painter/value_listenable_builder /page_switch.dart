import 'package:flutter/material.dart';

///动画形式的页面切换
///
class SwitchPage extends StatefulWidget {
  const SwitchPage({Key? key}) : super(key: key);

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  // 进度监听对象

  final ValueNotifier<double> factor = ValueNotifier<double>(1 / 5);

  // 页数监听对象
  final ValueNotifier<int> page = ValueNotifier<int>(1);

  // 页面滑动控制器
  PageController? _ctrl;

  // 测试组件 色块
  final List<Widget> testWidgets = [Colors.red, Colors.yellow, Colors.blue, Colors.green, Colors.orange]
      .map((e) => Container(
          decoration: BoxDecoration(
              color: e,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ))))
      .toList();

  Color get startColor => Colors.red; // 起点颜色
  Color get endColor => Colors.blue; // 终点颜色
  //圆角装饰
  BoxDecoration get boxDecoration => const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)));

  // 初始化
  @override
  void initState() {
    super.initState();
    _ctrl = PageController(
      viewportFraction: 0.9,
    )..addListener(() {
        double value = ((_ctrl?.page)! + 1) % 5 / 5;
        factor.value = value == 0 ? 1 : value;
      });
  }

  // 释放对象
  @override
  void dispose() {
    _ctrl?.dispose();
    page.dispose();
    factor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: factor,
        builder: (_, value, child) => Container(
          color: Color.lerp(startColor, endColor, factor.value),
          child: child, //<--- tag1
        ),
        child: Container(
          //<--- tag2
          child: Column(
            children: [
              _buildTitle(context),
              Expanded(
                  child: Container(
                child: _buildContent(),
                margin: const EdgeInsets.only(left: 8, right: 8),
                decoration: boxDecoration,
              ))
            ],
          ),
        ),
      ),
    );
  }

  ///  4. 背景的刷新
  ///关于背景的刷新，有点小门道。这里会体现出 ValueListenableBuilder中child  属性的作用。 主页内容放入 child 属性中，那么在触发 builder 时，会直接使用这个 child，
  ///不会再构建一遍 child。比如，现在当进度刷新时，不会触发 _buildTitle 方法，这说明 tag2 之下的组件没有被构建。如果将 tag2 的组件整体放到 tag1 的child 处时，那么伴随刷新
  ///， _buildTitle 方法会不断触发。这就是 child 属性的妙处。这点和 AnimatedBuilder 是一致的。当然你可以用 Stack 来叠放背景，不过这样感觉多此一举，还要额外搭上个 Stake 组件。
  Widget _buildTitle(BuildContext context) {
    print('---------_buildTitle------------');
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.api,
            color: Colors.white,
            size: 45,
          ),
          SizedBox(
            width: 20,
          ),
          ValueListenableBuilder(
            valueListenable: page,
            builder: _buildWithPageChange,
          ),
        ],
      ),
    );
  }
  Widget _buildContent() {
    ///主页内容
    return Container(
        padding: EdgeInsets.only(bottom: 80, top: 40),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) => page.value = index + 1,
                controller: _ctrl,
                itemCount: testWidgets.length,
                itemBuilder: (_, index) => AnimatedBuilder(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: testWidgets[index],
                    ),
                    animation: _ctrl!,
                    builder: (context, child) => _buildAnimOfItem(context, child!, index)),
              ),
            ),
            _buildProgress(),
          ],
        ));
  }

  Widget _buildAnimOfItem(BuildContext context, Widget child, int index) {
    double value;
    if (_ctrl!.position.haveDimensions) {
      value = (_ctrl?.page)! - index;
    } else {
      value = index.toDouble();
    }
    value = (1 - ((value.abs()) * .5)).clamp(0, 1).toDouble();
    value = Curves.easeOut.transform(value);
    return Transform(
      transform: Matrix4.diagonal3Values(1.0, value, 1.0),
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget _buildProgress() => Container(
        margin: EdgeInsets.only(bottom: 12, left: 48, right: 48, top: 10),
        height: 2,
        child: ValueListenableBuilder(
          valueListenable: factor,
          builder: (context, value, child) {
            return LinearProgressIndicator(
              value: factor.value,
              valueColor: AlwaysStoppedAnimation(
                Color.lerp(
                  startColor,
                  endColor,
                  factor.value,
                ),
              ),
            );
          },
        ),
      );



  Widget _buildWithPageChange(BuildContext context, int value, Widget? child) {
    return Text(
      "绘制集录 $value/5",
      style: TextStyle(fontSize: 30, color: Colors.white),
    );
  }
}
