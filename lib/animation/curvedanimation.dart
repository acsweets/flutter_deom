import 'package:flutter/material.dart';


class AnimationApp extends StatelessWidget {
  const AnimationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Animation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(
        title: '动画示例',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key ?key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

// 需要Ticker
class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late CurvedAnimation curveEaseIn, bounceIn, linear, decelerate;
  bool _animationFlag = true;
  late Animation<double> animation;//自定义变化

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration:  const Duration(milliseconds: 2000), vsync: this);
    curveEaseIn = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    bounceIn =  CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    linear =  CurvedAnimation(parent: controller, curve: Curves.linear);
    decelerate =
     CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    buildItemWidget(
         animation, MaterialColor color, String itemText) {
      return  Column(
        children: <Widget>[
          FadeTransition(
            opacity: animation,
            child:  FlutterLogo(
              size: 100.0,
              style:FlutterLogoStyle.horizontal,
              textColor: color,
            ),
          ),
           Text(itemText)
        ],
      );
    }

    return  Scaffold(
      appBar:AppBar(
        title:  Text(widget.title),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          if (_animationFlag) {
            controller.forward();
          } else {
            controller.reverse();
          }
          _animationFlag = !_animationFlag;
        },
        child:  const Icon(Icons.star),
      ),
      body: Center(
        child: GridView.extent(
          maxCrossAxisExtent: 170.0,
          padding: const EdgeInsets.all(12.0),
          children: <Widget>[
            buildItemWidget( CurvedAnimation(parent: controller, curve: Curves.ease), Colors.blue, 'Curves.easeIn'),
            buildItemWidget( animation, Colors.red, 'Curves.easeIn'),
   /*  buildItemWidget(curveEaseIn, Colors.blue, 'Curves.easeIn'),//curveEase 渐隐，渐显
   buildItemWidget(bounceIn, Colors.amber, 'Curves.bounceIn'),//闪烁，
            buildItemWidget(linear, Colors.red, 'Curves.linear'),//线性隐藏
            buildItemWidget(decelerate, Colors.indigo, 'Curves.decelerate'),//隐的慢显的快
            buildItemWidget(
                CurvedAnimation(parent: controller, curve: Curves.elasticIn), Colors.pink, 'Curves.elasticIn'),
            buildItemWidget(CurvedAnimation(parent: controller, curve: Curves.ease), Colors.purple, 'Curves.ease'),*/
          ],
        ),
      ),
    );
  }
}