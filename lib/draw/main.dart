import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:style/clock/home_page.dart';
import 'package:style/draw/paper_page.dart';
import 'draw_Axis.dart';

void main() {
  // 确定初始化
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body:  AxisPage(),
      ),
    );
  }
}

