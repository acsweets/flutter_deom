import 'package:flutter/material.dart';
import 'package:style/custom_painter/value_listenable_builder%20/page_switch.dart';
import 'package:style/custom_painter/value_listenable_builder%20/shape_painter.dart';
import 'package:style/custom_painter/value_listenable_builder%20/value_listenable_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主页'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                //跳转页面
                Navigator.of(context).push(MaterialPageRoute(
                  //没有传值
                    builder: (context) => ValueListenableBuilderPage()));
              },
              child: Container(
                height: 50,
                width: 100,
                color: Colors.yellow,
                child: Center(
                    child: Text(
                      '局部刷新',
                      style: TextStyle(color: Colors.orange),
                    )),
              )),
          TextButton(
              onPressed: () {
                //跳转页面
                Navigator.of(context).push(MaterialPageRoute(
                  //没有传值
                    builder: (context) => SwitchPage()));
              },
              child: Container(
                height: 50,
                width: 100,
                color: Colors.yellow,
                child: Center(
                    child: Text(
                      '页面切换',
                      style: TextStyle(color: Colors.orange),
                    )),
              )),
          TextButton(
              onPressed: () {
                //跳转页面
                Navigator.of(context).push(MaterialPageRoute(
                  //没有传值
                    builder: (context) => ShapePage()));
              },
              child: Container(
                height: 50,
                width: 100,
                color: Colors.yellow,
                child: Center(
                    child: Text(
                      '画个圆',
                      style: TextStyle(color: Colors.orange),
                    )),
              )),
        ],
      ),
    );
  }
}