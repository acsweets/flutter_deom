import 'dart:ui';

import 'package:flutter/material.dart';

///里氏替换原则
///定义：（如果对每一个类型为S的对象o1，都有类型为T的对 象o2，使得以T定义的所有程序P在所有的对象o1都代换成o2时，程序P的行为没有发生变 化，那么类型S是类型T的子类型。）
///定义：只要父类能出现的地方子类就可以出现，而且 替换为子类也不会产生任何错误或异常
///使用者可能根本就不需要知道是父类还是子类但是，反过来就不行了，有子类出现的地方，父类未必就能适应
///● 代码共享，减少创建类的工作量，每个子类都拥有父类的方法和属性；
/// ● 提高代码的重用性；
/// ● 子类可以形似父类，但又异于父类，“龙生龙，凤生凤，老鼠生来会打洞”是说子拥有 父的“种”，“世界上没有两片完全相同的叶子”是指明子与父的不同；
/// ● 提高代码的可扩展性，实现父类的方法就可以“为所欲为”了，君不见很多开源框架的 扩展接口都是通过继承父类来完成的；
/// ● 提高产品或项目的开放性。 自然界的所有事物都是优点和缺点并存的，即使是鸡蛋，有时候也能挑出骨头来，继承 的缺点如下：
/// ● 继承是侵入性的。只要继承，就必须拥有父类的所有属性和方法；
/// ● 降低代码的灵活性。子类必须拥有父类的属性和方法，让子类自由的世界中多了些约束
/// ● 增强了耦合性。当父类的常量、变量和方法被修改时，需要考虑子类的修改，而且在缺乏规范的环境下，这种修改可能带来非常糟糕的结果——大段的代码需要重构。
///

abstract class AbstractGun {
  abstract String shape;

  void shoot();

  void getShape();
}

class Rifle extends AbstractGun {
  @override
  void shoot() {
    print("步枪射击");
  }

  @override
  void getShape() {
    print("步枪形状");
  }

  @override
  String shape = "步枪";
}

class Handgun extends AbstractGun {
  @override
  void shoot() {
    print("手枪射击");
  }

  @override
  void getShape() {
    print("手枪形状");
  }

  @override
  String shape = "手枪";
}

class MachineGun extends AbstractGun {
  @override
  void shoot() {
    print("机枪射击");
  }

  @override
  void getShape() {
    print("机枪形状");
  }

  @override
  String shape = "机枪";
}

///玩具枪 可以抽象个玩具类继承
///ToyGun脱离继承，建立一个独立的父类，为了实现代码复用，可以与AbstractGun建 立关联委托关系
///可以在AbstractToy中声明将声音、形状都委托
///给AbstractGun处理，仿真枪嘛，形状和声音都要和真实的枪一样了，然后两个基类下的子类自由延展，互不影响。
abstract class AbstractToy {
  abstract Color color;
  late String shape;
}

class ToyGun extends AbstractToy {

  void setShape(AbstractGun _gun) {
    shape = _gun.shape;
    print(shape);
  }


  void setColor(Color color) {
    this.color = color;
    print("颜色更改$color ");
  }

  @override
  Color color = Colors.blue;


}

//士兵类
class Soldier {
  late AbstractGun gun;

  void setGun(AbstractGun _gun) {
    gun = _gun;
  }

  void killEnemy() {
    gun.shoot();
    print("杀死敌人");
  }
}

class AUG extends Rifle {
  void zoomOut() {
    print("使用望远镜观察");
  }

  @override
  void shoot() {
    print("AUG射击");
  }
}

class G3 extends Rifle {
  void zoomOut() {
    print("看清敌人");
  }

  @override
  void shoot() {
    print("G3射击");
  }
}

//狙击枪
class Snipper {
  late AUG aug;

  void setRifle(AUG _aug) {
    aug = _aug;
  }

  void killEnemy() {
    aug.zoomOut();

    aug.shoot();
  }
}
