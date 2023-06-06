///定义对象间一种一对多的依赖关系，使得每 当一个对象改变状态，则所有依赖于它的对象都会得到通知并被自动更新。
///我们先来解释一下观察者模式的几个角色名称： ● Subject被观察者
///定义被观察者必须实现的职责，它必须能够动态地增加、取消观察者。
/// 它一般是抽象类 或者是实现类，仅仅完成作为被观察者必须实现的职责：管理观察者并通知观察者。
/// ● Observer观察者 观察者接收到消息后，即进行update（更新方法）操作，对接收到的信息进行处理。
/// ● ConcreteSubject具体的被观察者 定义被观察者自己的业务逻辑，同时定义对哪些事件进行通知。
/// ● ConcreteObserver具体的观察者 每个观察在接收到消息后的处理反应是不同，各个观察者有自己的处理逻辑。
/// ● 观察者和被观察者之间是抽象耦合 如此设计，则不管是增加观察者还是被观察者都非常容易扩展，而且在Java中都已经实 现的抽象层级的定义，在系统扩展方面更是得心应手。 ● 建立一套触发机制 根据单一职责原则，每个类的职责是单一的，那么怎么把各个单一的职责串联成真实世 界的复杂的逻辑关系呢？比如，我们去打猎，打死了一只母鹿，母鹿有三个幼崽，因失去了 母鹿而饿死，尸体又被两只秃鹰争抢，因分配不均，秃鹰开始斗殴，然后羸弱的秃鹰死掉， 生存下来的秃鹰，则因此扩大了地盘……这就是一个触发机制，形成了一个触发链。观察者 模式可以完美地实现这里的链条形式。 22.3.2 观察者模式的缺点 观察者模式需要考虑一下开发效率和运行效率问题，一个被观察者，多个观察者，开发 和调试就会比较复杂，而且在Java中消息的通知默认是顺序执行，一个观察者卡壳，会影响 整体的执行效率。在这种情况下，一般考虑采用异步的方式。 多级触发时的效率更是让人担忧，大家在设计时注意考虑。 22.3.3 观察者模式的使用场景 ● 关联行为场景。需要注意的是，关联行为是可拆分的，而不是“组合”关系。
///
/// 观察者模式的优点
/// ● 观察者和被观察者之间是抽象耦合 如此设计，则不管是增加观察者还是被观察者都非常容易扩展，
/// 而且在Java中都已经实 现的抽象层级的定义，在系统扩展方面更是得心应手。
/// ● 建立一套触发机制 根据单一职责原则，每个类的职责是单一的，那么怎么把各个单一的职责串联成真实世界的复杂的逻辑关系呢
/// 比如，我们去打猎，打死了一只母鹿，母鹿有三个幼崽，因失去了母鹿而饿死，尸体又被两只秃鹰争抢，因分配不均，秃鹰开始斗殴，
/// 然后羸弱的秃鹰死掉， 生存下来的秃鹰，则因此扩大了地盘……这就是一个触发机制，形成了一个触发链。
/// 观察者模式可以完美地实现这里的链条形式。 22.3.2 观察者模式的缺点 观察者模式需要考虑一下开发效率和运行效率问题，
/// 一个被观察者，多个观察者，开发 和调试就会比较复杂，而且在Java中消息的通知默认是顺序执行，
/// 一个观察者卡壳会影响整体的执行效率。在这种情况下，一般考虑采用异步的方式。 多级触发时的效率更是让人担忧，大家在设计时注意考虑
///
///
///  观察者模式的使用场景
/// ● 关联行为场景。需要注意的是，关联行为是可拆分的，而不是“组合”关系。
/// ● 事件多级触发场景。
/// ● 跨系统的消息交换场景，如消息队列的处理机制

/// ● 事件多级触发场景。
///
///
///● 跨系统的消息交换场景，如消息队列的处理机制。
///  观察者模式的注意事项 使用观察者模式也有以下两个重点问题要解决。
///  ● 广播链的问题 如果你做过数据库的触发器，你就应该知道有一个触发器链的问题，比如表A上写了一 个触发器
///  ，内容是一个字段更新后更新表B的一条数据，而表B上也有个触发器，要更新表 C，表C也有触发器……完蛋了，
///  这个数据库基本上就毁掉了！我们的观察者模式也是一样 的问题，一个观察者可以有双重身份，既是观察者
///  ，也是被观察者，这没什么问题呀，但是 链一旦建立，这个逻辑就比较复杂，可维护性非常差，根据经验建议
///  ，在一个观察者模式中 最多出现一个对象既是观察者也是被观察者，也就是说消息最多转发一次（传递两次），
///  这 还是比较好控制的。 注意 它和责任链模式的最大区别就是观察者广播链在传播的过程中消息是随时更改 的，
///  它是由相邻的两个节点协商的消息结构；而责任链模式在消息传递过程中基本上保持消 息不可变，如果要改变，
///  也只是在原有的消息上进行修正。 ● 异步处理问题 这个EJB是一个非常好的例子，被观察者发生动作了，
///  观察者要做出回应，如果观察者 比较多，而且处理时间比较长怎么办？那就用异步呗，
///  异步处理就要考虑线程安全和队列的 问题，这个大家有时间看看Message Queue，就会有更深的了解

//韩非子吃饭和玩
abstract class IHanFeiZi {
  void haveBreakfast();

  void haveFun();
}

//抽象的观察者
abstract class Observer {
  void update(String context);
}

//抽象的被观察者
abstract class Observable {
  void addObserver(Observer observer);

  void deleteObserver(Observer observer);

  void notifyObservers(String context);
}

//一个韩非子类
class HanFeiZi implements Observable, IHanFeiZi {
  //观察者列表
  List<Observer> observerList = [];

  //添加观察者
  @override
  void addObserver(Observer observer) {
    observerList.add(observer);
  }

//删除观察者
  @override
  void deleteObserver(Observer observer) {
    observerList.remove(observer);
  }

//通知观察者
  @override
  void notifyObservers(String context) {
    for (var element in observerList) {
      element.update(context);
    }
  }

  @override
  void haveBreakfast() {
    print("吃中饭了");
    notifyObservers("º观察到韩非子吃中饭");
  }

  @override
  void haveFun() {
    print("出来玩");
    notifyObservers("º观察到韩非子出来玩");
  }
}

class LiSi implements Observer {
  @override
  void update(String str) {
    print("李斯：观察到韩非子活动，开始向老板汇报了...");
    reportToQiShiHuang(str);
    print("李斯：汇报完毕...\n");
  }

  void reportToQiShiHuang(String reportContext) {
    print("李斯：报告，秦老板！韩非子有活动了-->" + reportContext);
  }
}

class LiuSi implements Observer {
  @override
  void update(String str) {
    print("王斯：观察到韩非子活动，开始向老板汇报了...");
    cry(str);
    print("王斯：哭死了...\n");
  }

  void cry(String context) {
   print("王斯：因为"+context+"，--所以我悲伤呀！");
  }
}
class WangSi implements Observer {
  @override
  void update(String str) {
    print("李斯：观察到韩非子活动，开始向老板汇报了...");
    reportToQiShiHuang(str);
    print("李斯：汇报完毕...\n");
  }

  void reportToQiShiHuang(String reportContext) {
    print("李斯：报告，秦老板！韩非子有活动了-->" + reportContext);
  }
}

