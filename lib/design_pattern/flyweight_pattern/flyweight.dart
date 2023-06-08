///享元模式
///池技术的重要实现方式,使用共享对象可有效地支持大量的细 粒度的对象。
///享元模式的定义为我们提出了两个要求：
///细粒度的对象和共享对象。我们知道分配太多的对象到应用程序中将有损程序的性能，同时还容易造成内存溢出
///那怎么避免呢？就是享元模式提到的共享技术。我们先来了解一下对象的内部状态和外部状态。
///要求细粒度对象，那么不可避免地使得对象数量多且性质相近，那我们就将这些对象的 信息分为两个部分：
///内部状态（intrinsic）与外部状态（extrinsic）。
/// ● 内部状态 内部状态是对象可共享出来的信息，存储在享元对象内部并且不会随环境改变而改变，
/// 如我们例子中的id、postAddress等，它们可以作为一个对象的动态附加信息，不必直接储存在具体某个对象中，属于可以共享的部分。
/// ● 外部状态 外部状态是对象得以依赖的一个标记，是随环境改变而改变的、不可以共享的状态，
///如我们例子中的考试科目+考试地点复合字符串，它是一批对象的统一标识，是唯一的一个索引值。
///
/// 享元模式的优点和缺点
/// 享元模式是一个非常简单的模式，它可以大大减少应用程序创建的对象，
/// 降低程序内存 的占用，增强程序的性能，但它同时也提高了系统复杂性，
/// 需要分离出外部状态和内部状 态，而且外部状态具有固化特性，不应该随内部状态改变而改变，
/// 否则导致系统的逻辑混 乱。
///
///
///享元模式的使用场景 在如下场景中则可以选择使用享元模式。
///● 系统中存在大量的相似对象。
/// ● 细粒度的对象都具备较接近的外部状态，而且内部状态与环境无关，也就是说对象没 有特定身份。
/// ● 需要缓冲池的场景
///
//抽象的享元对象
abstract class Flyweight {
  late String intrinsic;

  final String extrinsic;

  Flyweight(this.extrinsic);

  void operate();

  String getIntrinsic() {
    return intrinsic;
  }

  void setIntrinsic(String intrinsic) {
    this.intrinsic = intrinsic;
  }
}

//具体享元角色
class ConcreteFlyweight2 extends Flyweight {

  ConcreteFlyweight2(String _extrinsic) : super(_extrinsic);

  @override
  void operate() {}
}

//具体享元角色
class ConcreteFlyweight1 extends Flyweight {

  ConcreteFlyweight1(String _extrinsic) : super(_extrinsic);

  @override
  void operate() {}
}

class FlyweightFactory {
  static Map<String, Flyweight> pool = {};

  static Flyweight getFlyweight(String extrinsic) {
    late Flyweight flyweight;

    if (pool.containsKey(extrinsic)) {
      flyweight = pool["extrinsic"]!;
    } else {
      flyweight = ConcreteFlyweight1(extrinsic);

      pool["extrinsic"] = flyweight;
    }

    return flyweight;
  }
}
