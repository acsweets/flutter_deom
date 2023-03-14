import 'dart:convert';

import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class FairHomePage extends StatefulWidget {
  dynamic fairProps;

  @override
  State<FairHomePage> createState() => _FairHomePageState();
}



class _FairHomePageState extends State<FairHomePage> {
  @FairProps()
  var fairProps;

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    /// 需要将 widget.fairProps 赋值给 fairProps
    fairProps = widget.fairProps;
  }

  String getTitle() {
    return fairProps['title'];
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTitle()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              // 暂不支持 style: Theme.of(context).textTheme.headline4,
              // 可替换成:
              style: TextStyle(fontSize: 40, color: Color(0xffeb4237), wordSpacing: 0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

