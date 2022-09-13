import 'package:style/calss/add_class.dart';

import 'operstion.dart';

///工厂模式
///到底要实例化化谁会不会增加实例化的对象，用一个单独的类来做这个创造实例的过程叫做工厂模式，可以实例化加 减乘除各种类型。

class OperationFactory{

  static Operation ? createOperate( String operate)
  {
    Operation ? oPer ;
    switch (operate){
      case "+":
        oPer = Add();
        break;
      case "-":
        oPer = Reduce();
        break;
    }
    return oPer;
  }





}