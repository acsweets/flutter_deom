import 'package:flutter/material.dart';
import 'package:style/gesture/pan_painter/white_paper.dart';
import 'package:style/gesture/size.dart';
import 'package:style/gesture/tap_paper/tap_page.dart';

import 'SpringPainter/spring_page.dart';
import 'SpringPainter/spring_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主页'),
      ),
      body:/* Column(
        children: [
          TextButton(
              onPressed: () {
                //跳转页面
                Navigator.of(context).push(MaterialPageRoute(
                    //没有传值
                    builder: (context) => SpringPage()));
              },
              child: Container(
                height: 50,
                width: 100,
                color: Colors.yellow,
                child: Center(
                    child: Text(
                  '弹簧',
                  style: TextStyle(color: Colors.orange),
                )),
              )),
          TextButton(
              onPressed: () {
                //跳转页面
                Navigator.of(context).push(MaterialPageRoute(
                    //没有传值
                    builder: (context) => TapPage()));
              },
              child: MeasureSize(
                onChange: (size) {
                  print('$size');
                },
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.yellow,
                  child: Center(
                      child: Text(
                    '印章',
                    style: TextStyle(color: Colors.orange),
                  )),
                ),
              )),
          TextButton(
              onPressed: () {
                //跳转页面
                Navigator.of(context).push(MaterialPageRoute(
                  //没有传值
                    builder: (context) => TapPage()));
              },
              child: MeasureSize(
                onChange: (size) {
                  print('$size');
                },
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.yellow,
                  child: Center(
                      child: Text(
                        '画个圆',
                        style: TextStyle(color: Colors.orange),
                      )),
                ),
              )),
        ],
      ),*/
      const WhitePaper(),
    );
  }
}
