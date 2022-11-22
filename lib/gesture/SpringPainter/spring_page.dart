import 'package:flutter/material.dart';
import 'package:style/gesture/SpringPainter/spring_widget.dart';

class SpringPage extends StatelessWidget {
  const SpringPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('弹簧实例'),
      ),
      body: Container(
        child: SpringWidget(),
      ),
    );
  }
}
