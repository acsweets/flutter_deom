import 'package:flutter/material.dart';

class ValueListenableBuilderPage extends StatefulWidget {
  const ValueListenableBuilderPage({Key? key}) : super(key: key);

  @override
  State<ValueListenableBuilderPage> createState() => _ValueListenableBuilderPageState();
}

int i = 0;

class _ValueListenableBuilderPageState extends State<ValueListenableBuilderPage> {
  // 定义 ValueNotifier 对象 _counter
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('局部刷新'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                _incrementCounter();
              },
              child: Container(
                height: 50,
                width: 100,
                color: Colors.yellow,
                child: Center(
                    child: Text(
                  '局部刷新',
                  style: TextStyle(color: Colors.orange),
                )),
              )),
          ValueListenableBuilder<int>(
            builder: _buildWithValue,
            valueListenable: _counter,
          )
        ],
      ),
    );
  }

  void _incrementCounter() {
    _counter.value += 1;
  }

  Widget _buildWithValue(BuildContext context, int value, Widget? child) {
    return Text(
      '$value',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
