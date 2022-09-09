import 'package:flutter/material.dart';
import 'package:style/page/draggable.dart';
import 'animation/curvedanimation.dart';


void main() {
  runApp(
     const MyApp()
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

