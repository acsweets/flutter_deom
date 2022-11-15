import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:style/clock/home_page.dart';
import 'package:style/draw/paper_page.dart';



void main() {
  // 确定初始化
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:   HomePage(),
      ),
    );
  }
}

