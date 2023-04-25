///接口隔离原则
///● 实例接口（Object Interface），在Java中声明一个类，然后用new关键字产生一个实例，
///它是对一个类型的事物的描述，这是一种接口。比如你定义Person这个类，
///然后使用 Person zhangSan=new Person()产生了一个实例，这个实例要遵从的标准就是Person这个类，
///Person类就是zhangSan的接口。疑惑？看不懂？不要紧，那是因为让Java语言浸染的时间 太长了，
///只要知道从这个角度来看，Java中的类也是一种接口。
/// ● 类接口（Class Interface），Java中经常使用的interface关键字定义的接口。
/// 定义：建立单一接口，不要建立臃肿庞大的接口。再通俗一点讲：接口尽量细化，同时接口中的方法尽量少。
/// 和单一职责的区别：单一职责要求的是类和接口职责单一，注重的是职责，这是业务逻辑上的划分，而接口隔离原则要求接口的方法尽量少。
/// 例如一个接口的职责可能包含10个方法，这10个方法都放在一个接口 中，并且提供给多个模块访问，各个模块按照规定的权限来访问，
/// 在系统外通过文档约束“不使用的方法不要访问”，按照单一职责原则是允许的，按照接口隔离原则是不允许的，
/// 因为它要求“尽量使用多个专门的接口”
/// =======根据接口隔离原则拆分接口时，首先必须满足单一职责原则。
///
///

//高素质美女
abstract class IGreatTemperamentGirl {
  void greatTemperament();
}

abstract class IGoodBodyGirl {
  void goodLooking();

  void niceFigure();
}

///美女
class PettyGirl implements IGoodBodyGirl, IGreatTemperamentGirl {
  late final String name;

  PettyGirl({required this.name});

  @override
  void goodLooking() {
    print(name + "长得好看的脸美女");
  }

  @override
  void greatTemperament() {
    print(name + "高素质美女");
  }

  //好身材
  @override
  void niceFigure() {
    print(name + "好身材的美女");
  }
}

///抽象星探发现美女

abstract class AbstractSearcher {
  IGoodBodyGirl? goodBodyGirl;
  IGreatTemperamentGirl? greatTemperamentGirl;

  // 有好身材的女孩构造函数
  AbstractSearcher.withGoodBodyGirl(IGoodBodyGirl this.goodBodyGirl);

  // 有好气质的女孩构造函数
  AbstractSearcher.withGreatTemperamentGirl(IGreatTemperamentGirl this.greatTemperamentGirl);

  // 搜索女孩并展示信息
  void show();
}

//星探类
class Searcher extends AbstractSearcher {
  Searcher.withGoodBodyGirl(IGoodBodyGirl goodBodyGirl) : super.withGoodBodyGirl(goodBodyGirl);

  Searcher.withGreatTemperamentGirl(IGreatTemperamentGirl greatTemperamentGirl) : super.withGreatTemperamentGirl(greatTemperamentGirl);

  // 展示女孩的信息
  @override
  void show() {
    print("--------女孩的信息如下：---------------");
    if (goodBodyGirl != null) { // 展示有好身材的女孩
      goodBodyGirl!.goodLooking();
      goodBodyGirl!.niceFigure();
    }

    if (greatTemperamentGirl != null) { // 展示有好气质的女孩
      greatTemperamentGirl!.greatTemperament();
    }
  }
}

