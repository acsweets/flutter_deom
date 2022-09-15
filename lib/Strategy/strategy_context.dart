import 'package:style/Strategy/base_strategy.dart';

class Context{
  Strategy ?strategy;//初始化时传入具体的策略

  Context( this.strategy);
  //根据具体策略调用她的方法或者算法
  void contextInterface() {
    strategy?.algorithmInterface();
  }
}