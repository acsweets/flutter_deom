import 'package:style/decorate/decorator.dart';

///具体装饰类a
///

class ConcreteDecoratorA extends Decorator {
  String? _addState;

  ///本类独有的功能呢

  @override
  void operation() {
    ///首先运行原component的operation(),再执行本类的功能，如addState相当对原component进行装饰
    super.operation();
    _addState = '我是a类所独有';
    print('$_addState');
  }
}
