///为创建一组相关或相互依赖的对象提供一个接口，而且无须指定它们的具体类
///抽象工厂模式是工厂方法模式的升级版本，在有多个业务品种、业务分类时，
///通过抽象工厂模式产生需要的对象是一种非常好的解决方式
///每个产品的实现类不是高层模块要关心的，它要关心的是什么？是接口
///是 抽象它不关心对象是如何创建出来，这由谁负责呢？工厂类只要知道工厂类是谁，
///我就 能创建出一个需要的对象，省时省力，优秀设计就应该如此

abstract class HumanFactory {
  Human createYellowHuman();

  Human createWhiteHuman();

  Human createBlackHuman();
}

//人的基类
abstract class Human {
//人的肤色
  void getColor();

//说的语言
  void talk();

//性别
  void getSex();
}

abstract class AbstractBlackHuman implements Human {
  @override
  void getColor() {
    print("黑人");
  }

  @override
  void talk() {
    print("我是黑人");
  }
}

abstract class AbstractWhiteHuman implements Human {
  @override
  void getColor() {
    print("白人");
  }

  @override
  void talk() {
    print("°我是白人");
  }
}

abstract class AbstractYellowHuman implements Human {
  @override
  void getColor() {
    print("黄人");
  }

  @override
  void talk() {
    print("我是黄人");
  }
}

class FemaleBlackHuman extends AbstractBlackHuman {
  //Å®ÐÔºÚÈË
  @override
  void getSex() {
    print("黑人女性");
  }
}

class FemaleWhiteHuman extends AbstractWhiteHuman {
  @override
  void getSex() {
    print("白人女性");
  }
}

class FemaleYellowHuman extends AbstractYellowHuman {
  @override
  void getSex() {
    print("黄人女性");
  }
}

class MaleBlackHuman extends AbstractBlackHuman {
  @override
  void getSex() {
    print("黑人男性");
  }
}

class MaleWhiteHuman extends AbstractWhiteHuman {
  @override
  void getSex() {
    print("白人男性");
  }
}

class MaleYellowHuman extends AbstractYellowHuman {
  @override
  void getSex() {
    print("黄人男性¬");
  }
}

//男性工厂
class FemaleFactory implements HumanFactory {
  //创建黑人
  @override
  Human createBlackHuman() {
    return FemaleBlackHuman();
  }

  //创建白人
  @override
  Human createWhiteHuman() {
    return FemaleWhiteHuman();
  }

  //创建黄人
  @override
  Human createYellowHuman() {
    return FemaleYellowHuman();
  }
}

//女性工厂
class MaleFactory implements HumanFactory {
  @override
  Human createBlackHuman() {
    return MaleBlackHuman();
  }

  @override
  Human createWhiteHuman() {
    return MaleWhiteHuman();
  }

  @override
  Human createYellowHuman() {
    return MaleYellowHuman();
  }
}


 class NvWa {

  static void stare( ) {

  //男性工厂
  HumanFactory maleHumanFactory =  MaleFactory();

  //女性工厂
  HumanFactory femaleHumanFactory =  FemaleFactory();


  Human maleYellowHuman = maleHumanFactory.createYellowHuman();

  Human femaleYellowHuman = femaleHumanFactory.createYellowHuman();


  femaleYellowHuman.getColor();
  femaleYellowHuman.talk();
  femaleYellowHuman.getSex();

  maleYellowHuman.getColor();
  maleYellowHuman.talk();
  maleYellowHuman.getSex();

  
  }
}