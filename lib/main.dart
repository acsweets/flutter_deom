import 'package:flutter/material.dart';
import 'package:style/page/chang_notifier.dart';
import 'package:style/page/draggable.dart';
import 'package:style/page/home_page.dart';
import 'package:style/page/inheritd.dart';
import 'package:style/page/message.dart';

import 'animation/curvedanimation.dart';
import 'job/JoblistScreen.dart';
import 'job/care.dart';

void main() {
/*  runApp(const MyApp());*/
  runApp(
      new AnimationApp()
   /* MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Jobs",
      initialRoute: '/',
      routes: {
        '/': (context) => CareScreen(),
      },
    ),*/
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '开启',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Draggabl(),
    );
  }
}

