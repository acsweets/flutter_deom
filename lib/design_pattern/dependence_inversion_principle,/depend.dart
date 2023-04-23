///依赖倒置原则
/// 高层模块不应该依赖低层模块，两者都应该依赖其抽象；
///抽象不应该依赖细节；
///细节应该依赖抽象。
/// 模块间的依赖通过抽象发生，实现类之间不发生直接的依赖关系，其依赖关系是通过 接口或抽象类产生的；
/// 接口或抽象类不依赖于实现类；  实现类依赖接口或抽象类
///“面向接口编程”——OOD（Object-Oriented Design）大家只要记住 是“面向接口编程”就基本上抓住了依赖倒置原则的核心

//车子抽象类
abstract class ICar {
  void run();
}

//司机抽象类
abstract class IDriver {
  void setCar(ICar car);

  void drive();
}

//司机类
class Driver implements IDriver {
  late final ICar car;

  Driver({
    required this.car,
  });

  @override
  void setCar(ICar car) {
    this.car = car;
  }

  @override
  void drive() {
    print('司机在开车');
    car.run();
  }
}

//奔驰车
 class BMW  implements ICar{

  @override
  void run(){
    print("奔驰在跑");
  }
}


//奔驰车
class Benz  implements ICar{

  @override
  void run(){
    print("奔驰在跑");
  }
}

