import 'package:flutter/material.dart';
import 'package:style/gesture/SpringPainter/spring_widget.dart';
import 'package:style/gesture/tap_paper/stamp_paper.dart';

class TapPage extends StatelessWidget {
  const TapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('印章实例'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100,left: 50),
        child: StampPaper(),
      ),
    );
  }
}
