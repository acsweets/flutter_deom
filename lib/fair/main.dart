/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fair/fair.dart';
import 'fair_home_page.dart';
void main() {
  // runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  FairApp.runApplication(
    _getApp(),
    plugins: {},
  );
}

dynamic _getApp() => FairApp(
  modules: {},
  delegate: {},
  child: MyApp(),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAIR Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      // home: FairWidget(
      //   /// path 可以是 assets 目录下的 bundle 资源，也可以是手机存储
      //   /// 里的 bundle 资源，如果是手机存储里的 bundle 资源需要使用绝对路径
      //     path: 'assets/bundle/lib_fair_fair_home_page.fair.json',
      //     data: {
      //       /// 此处的 key 必须是 fairProps，不可以自定义
      //       /// value 是一个 Map 类型的数据，最好是进行 jsonEncode() 操作
      //       'fairProps': jsonEncode({'title': '大家晚上好'})
      //     })

      home: FairWidget(
        path: 'assets/bundle/lib_fair_component_grid_gridview_template.fair.json',
        data: {
          'fairProps': jsonEncode({
            'auth': 'Internal Team',
            'title': 'Kickoff Meeting',
            'time':'8:00am',
            'location':'Kaleo Office - San Starbucks',
            'des':"Short description goes here and can ben more than one line. Two lines is the best lenth Short description goes here and can ben more than one line. Two lines is the best lenth",
            'detail':
            "Drag-and-drop builder and no-code configuration make it easy to add chat to your app. Professionally designed templates and custom styling will take your app to the next level.Drag-and-drop builder and no-code configuration make it easy to add chat to your app. Professionally designed templates and custom styling will take your app to the next level. Drag-and-drop builder and no-code configuration make it easy to add chat to your app. Professionally designed templates and custom styling will take your app to the next level. "
          })
        },
      ),
    );

  }
}*/
