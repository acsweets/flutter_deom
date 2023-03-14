import 'package:flutter/material.dart';

class Counter extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  addCount() {
    _count++;
    notifyListeners();
  }
}

Counter _counter = new Counter();

class ChangeNotifierTest extends StatefulWidget {
  @override
  _ChangeNotifierTestState createState() => _ChangeNotifierTestState();
}

class _ChangeNotifierTestState extends State<ChangeNotifierTest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _counter.addListener(() {
      //add listener
      Text('new count is :${_counter.count}');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _counter.dispose(); //remove listener
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChangeNotifier test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ChangeNotifier test bar'),
        ),
        body: Center(
          child: Container(
            child: GestureDetector(
                onTap: () {
                  _counter.addCount();
                },
                child: Row(
                  children: [
                    Text('${_counter.count}'),
                    Text(
                      'count',
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
