import 'base_strategy.dart';

///具体策略类 方法 封装算法或行为，继承基本类
///
class StrategyA extends Strategy{
  @override
  void algorithmInterface() {
  print('我是算法a');
  }
}
