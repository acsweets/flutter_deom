///建造者模式（Builder Pattern）也叫做生成器模式
///将一个复杂对象的构建与它的表示分离，
///使得同样的构建过程可以创建不同的表示
///● Product产品类 通常是实现了模板方法模式，也就是有模板方法和基本方法，
///这个参考的模板方法模式。例子中的BenzModel和BMWModel就属于产品类。
///● Builder抽象建造者 规范产品的组建，一般是由子类实现。例子中的CarBuilder就属于抽象建造者。
/// ● ConcreteBuilder具体建造者实现抽象类定义的所有方法，并且返回一个组建好的对象。
/// 例子中的BenzBuilder和 BMWBuilder就属于具体建造者。 ● Director导演类 负责安排已有模块的顺序，
/// 然后告诉Builder开始建造，在上面的例子中就是我们的老 大，××公司找到老大，说我要这个或那个类型的车辆模型，
/// 然后老大就把命令传递给我，我 和我的团队就开始拼命地建造，于是一个项目建设完毕了。
/// 建造者模式的通用源代码也比较简单，先看Product类，通常它是一个组合或继承（如模 板方法模式）产生的类
///
///
/// 建造者模式的优点
/// ● 封装性 使用建造者模式可以使客户端不必知道产品内部组成的细节，
/// 如例子中我们就不需要关 心每一个具体的模型内部是如何实现的，产生的对象类型就是CarModel。
/// ● 建造者独立，容易扩展 BenzBuilder和BMWBuilder是相互独立的，对系统的扩展非常有利。
/// ● 便于控制细节风险 由于具体的建造者是独立的，因此可以对建造过程逐步细化，而不对其他的模块产生任 何影响。
///建造者模式的使用场景
///
///
///● 相同的方法，不同的执行顺序，产生不同的事件结果时，可以采用建造者模式。
/// ● 多个部件或零件，都可以装配到一个对象中，但是产生的运行结果又不相同时，则可以使用该模式。
/// ● 产品类非常复杂，或者产品类中的调用顺序不同产生了不同的效能，这个时候使用建 造者模式非常合适。
/// ● 在对象创建过程中会使用到系统中的一些其他对象，这些对象在产品对象的创建过程 中不易得到时
/// ，也可以采用建造者模式封装该对象的创建过程。该种场景只能是一个补偿方法，
/// 因为一个对象不容易获得，而在设计阶段竟然没有发觉，而要通过创建者模式柔化创建过程，
/// 本身已经违反设计的最初目标。
///
///
/// 建造者模式的注意事项
/// 建造者模式关注的是零件类型和装配工艺（顺序）
/// ，这是它与工厂方法模式最大不同的 地方，虽然同为创建类模式，但是注重点不同。
///
///

///通过外部来设置顺序
// abstract class CarModel {
//   // 这个参数是一个用来记录汽车启动顺序的List
//   List<String> sequence = [];
//
//   // 启动，子类必须实现
//   void start();
//
//   // 停止，子类必须实现
//   void stop();
//
//   // 鸣笛，子类必须实现
//   void alarm();
//
//   // 引擎轰鸣，子类必须实现
//   void engineBoom();
//
//   // 运行，模板方法
//   void run() {
//     // 遍历启动顺序List，执行相应的操作
//     for (var actionName in sequence) {
//       if (actionName.toLowerCase() == 'start') {
//         start();  // 启动
//       } else if (actionName.toLowerCase() == 'stop') {
//         stop();  // 停止
//       } else if (actionName.toLowerCase() == 'alarm') {
//         alarm();  // 鸣笛
//       } else if (actionName.toLowerCase() == 'engine boom') {
//         engineBoom();  // 引擎轰鸣
//       }
//     }
//   }
//
//   // 设置启动顺序
//   void setSequence(List<String> sequence) {
//     this.sequence = sequence;
//   }
// }
//
// class BenzModel extends CarModel {
//
//   @override
//   void alarm() {
//     print('这辆奔驰车的警报是这样的...');
//   }  @override
//   void engineBoom() {
//     print('这辆奔驰车的引擎声是这样的...');
//   }
//
//   @override
//   void start() {
//     print('这辆奔驰车的启动方式是这样的...');
//   }
//
//   @override
//   void stop() {
//     print('这辆奔驰车的停止方式是这样的...');
//   }
//
// }
// class BMWModel extends CarModel {
//
//   @override
//   void alarm() {
//     print("警报器的声音是这样的...");
//   }
//
//   @override
//   void engineBoom() {
//     print("引擎发动声是这样的...");
//   }
//
//   @override
//   void start() {
//     print("车子启动是这样的...");
//   }
//
//   @override
//   void stop() {
//     print("车子停止是这样的...");
//   }
//
// }
//
// class Began {
//   static  void begin() {
//     /*
//    * 客户需要奔驰车，我要制造一个奔驰模型，
//    * 而且这个顺序不能乱，必须按照这个顺序制造出来，
//    * 这个顺序由客户决定，我就按照客户的要求制造就好了
//    */
//     BenzModel benz =  BenzModel();
//     // 存放run的顺序
//     List<String> sequence = [];
//     sequence.add("engine boom"); // 客户要求，run的时候先发动引擎
//     sequence.add("start"); // 启动起来
//     sequence.add("stop"); // 开了一段就停下来
//     // 把顺序给奔驰车
//     benz.setSequence(sequence);
//     benz.run();
//   }
//
// }

abstract class CarBuilder {
  // 定义一个抽象方法，设置车辆组装顺序
  void setSequence(List<String> sequence);

  // 定义一个抽象方法，获取组装完成的车辆模型
  CarModel getCarModel();
}

abstract class CarModel {
  //这个参数是执行顺序
  List<String> sequence = []; //抽象方法，启动
  void start();

  //抽象方法，停止
  void stop();

  //抽象方法，鸣笛
  void alarm();

  //抽象方法，引擎轰鸣
  void engineBoom();

  //最终的方法，将执行顺序传递过来，并按照顺序执行
  void run() {
    for (var i = 0; i < sequence.length; i++) {
      var actionName = sequence[i];
      if (actionName.toLowerCase() == "start") {
        start();
      } else if (actionName.toLowerCase() == "stop") {
        stop();
      } else if (actionName.toLowerCase() == "alarm") {
        alarm();
      } else if (actionName.toLowerCase() == "engine boom") {
        engineBoom();
      }
    }
  }

  //设置执行顺序
  void setSequence(List<String> sequence) {
    this.sequence = sequence;
  }
}

class BenzModel extends CarModel {
  @override
  void alarm() {
    print("这辆奔驰的警报声音是这样的...");
  }

  @override
  void engineBoom() {
    print("这辆奔驰的引擎声音是这样的...");
  }

  @override
  void start() {
    print("这辆奔驰启动起来是这样的...");
  }

  @override
  void stop() {
    print("这辆奔驰停车了...");
  }
}

class BenzBuilder extends CarBuilder {
  BenzModel benz = BenzModel();

  @override
  CarModel getCarModel() {
    return benz;
  }

  @override
  void setSequence(List<String> sequence) {
    benz.setSequence(sequence);
  }
}
class BMWModel extends CarModel {
  @override
  void alarm() {
    print("这辆宝马的警报声音是这样的...");
  }

  @override
  void engineBoom() {
    print("这辆宝马的引擎声音是这样的...");
  }

  @override
  void start() {
    print("这辆宝马启动起来是这样的...");
  }

  @override
  void stop() {
    print("这辆宝马停车了...");
  }
}

class BMWBuilder extends CarBuilder {
  BMWModel bmw = BMWModel();

  @override
  CarModel getCarModel() {
    return bmw;
  }

  @override
  void setSequence(List<String> sequence) {
    bmw.setSequence(sequence);
  }
}
class Director {
  List<String> sequence = [];
  BenzBuilder benzBuilder = BenzBuilder();
  BMWBuilder bmwBuilder = BMWBuilder();
  BenzModel getABenzModel() {
    sequence.clear();
    sequence.addAll(["start", "stop"]);
    benzBuilder.setSequence(sequence);
    return benzBuilder.getCarModel() as BenzModel;
  }

  BenzModel getBBenzModel() {
    sequence.clear();
    sequence.addAll(["engine boom", "start", "stop"]);
    benzBuilder.setSequence(sequence);
    return benzBuilder.getCarModel() as BenzModel;
  }

  BMWModel getCBMWModel() {
    sequence.clear();
    sequence.addAll(["alarm", "start", "stop"]);
    bmwBuilder.setSequence(sequence);
    return bmwBuilder.getCarModel() as BMWModel;
  }

  BMWModel getDBMWModel() {
    sequence.clear();
    sequence.add("start");
    bmwBuilder.setSequence(sequence);
    return bmwBuilder.getCarModel() as BMWModel;
  }
}