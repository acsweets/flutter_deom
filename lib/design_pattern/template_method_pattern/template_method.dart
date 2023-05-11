import 'package:flutter/cupertino.dart';

///定义一个操作中的算法的框架，而将一些步骤延迟到子类中。
///使得子类可以不改 变一个算法的结构即可重定义该算法的某些特定步骤。）
///模板方法模式确实非常简单，仅仅使用了Java的继承机制，但它是一个应用非常广泛的模式。
///其中，AbstractClass叫做抽象模板，它的方法分为两类：
/// ● 基本方法 基本方法也叫做基本操作，是由子类实现的方法，并且在模板方法被调用。
/// ● 模板方法可以有一个或几个，一般是一个具体方法，也就是一个框架，实现对基本方法的调度，
/// 完成固定的逻辑。 注意 为了防止恶意的操作，一般模板方法都加上final关键字，不允许被覆写。
/// ===========================
///  模板方法模式的优点
///  ● 封装不变部分，扩展可变部分 把认为是不变部分的算法封装到父类实现，而可变部分的则可以通过继承来继续扩展。
///  ● 提取公共部分代码，便于维护
/// ● 行为由父类控制，子类实现 基本方法是由子类实现的，因此子类可以通过扩展的方式增加相应的功能，符合开闭原则
/// ===========================
/// 模板方法模式的使用场景
///● 多个子类有公有的方法，并且逻辑基本相同时。
///● 重要、复杂的算法，可以把核心算法设计为模板方法，周边的相关细节功能则由各个子类实现。
///● 重构时，模板方法模式是一个经常使用的模式，把相同的代码抽取到父类中，然后通过钩子函数见“模板方法模式的扩展”）约束其行为
///

// abstract class HummerModel {
//   //开始
//   void start();
//
// //停止
//   void stop();
//
// //鸣笛
//   void alarm();
//
// //引擎
//   void engineBoom();
//
// //跑
//   void run();
// }




// class HummerH1Model extends HummerModel {
//
//
//   @override
//   void alarm() {
//     print("悍马1鸣笛.");
//   }
//
//
//   @override
//   void engineBoom() {
//     print("悍马1引擎轰隆隆");
//   }
//
//   @override
//   void start() {
//     print("悍马1开始跑");
//   }
//
//   @override
//   void stop() {
//     print("悍马1停止跑");
//   }
//
//   @override
//   void run() {
//     start();
//
//     engineBoom();
//
//     alarm();
//
//     stop();
//   }
//
// }

abstract class HummerModel {

  // 启动，子类必须实现
  void start();

  // 停止，子类必须实现
  void stop();

  // 鸣笛，子类必须实现
  void alarm();

  // 引擎轰鸣，子类必须实现
  void engineBoom();

  // 运行，模板方法
  void run() {
    // 启动
    start();

    // 引擎轰鸣
    engineBoom();

    // 如果需要鸣笛，则执行
    if (isAlarm()) {
      alarm();
    }

    // 停止
    stop();
  }


  // 是否需要鸣笛，默认需要
  bool isAlarm() => true;
}


 class HummerH1Model extends HummerModel {
bool alarmFlag = true;  //ÊÇ·ñÒªÏìÀ®°È

  @override
  void alarm() {
    print("悍马1鸣笛.");
  }


  @override
  void engineBoom() {
    print("悍马1引擎轰隆隆");
  }

  @override
  void start() {
    print("悍马1开始跑");
  }

  @override
  void stop() {
    print("悍马1停止跑");
  }

  @override
  @protected
  bool isAlarm() {
    return alarmFlag;
  }

 void setAlarm(bool isAlarm){
    alarmFlag = isAlarm;
  }

}


class HummerH2Model extends HummerModel {

  @override
  void alarm() {
    print("悍马2鸣笛.");
  }


  @override
  void engineBoom() {
    print("悍马2引擎轰隆隆");
  }

  @override
  void start() {
    print("悍马2开始跑");
  }

  @override
  void stop() {
    print("悍马2停止跑");
  }

}
