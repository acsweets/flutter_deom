///超市页面
import 'package:flutter/material.dart';

import 'package:style/utils/enmu.dart';

import '../decorate/concrete_component.dart';
import '../decorate/decorator_a.dart';

class DecoratePage extends StatefulWidget {
  const DecoratePage({Key? key}) : super(key: key);

  @override
  State<DecoratePage> createState() => _DecoratePageState();
}

late ChargeType type;

class _DecoratePageState extends State<DecoratePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('装饰'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              decorate();
            },
            child: Container(height: 200, width: 200, color: Colors.red, child: Text('点我')),
          )
        ],
      ),
    );
  }

  ///装饰的方法 实例化ConcreteComponent c 然后用ConcreteDecoratorA来实例化对象d1 来包装c
  void decorate() {
    ConcreteComponent c = ConcreteComponent();
    ConcreteDecoratorA d1 = ConcreteDecoratorA();
    d1.setComponent(c);
    d1.operation();
    print('$c');
  }
}
