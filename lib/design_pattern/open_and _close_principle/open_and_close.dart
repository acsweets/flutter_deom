import 'dart:core';

///开闭原则
///软件实体应该对扩展开放，对修改关闭，
///其含义是说一个软件实体应该通过扩展来实现变化，
///而不是通过修改已有的代码来实现变化。
/// 那什么又是软件实体呢？软件实体包括以下几个部分
///  项目或软件产品中按照一定的逻辑规则划分的模块。
/// ● 抽象和类。 ● 方法
/// 前提条件是：类必 须做到高内聚、低耦合，否则类文件的替换会引起不可预料的故障
///
///
//书店卖书的例子 ====万一有天加需求要打折应该怎么样做到高内聚 低耦合
abstract class IBook {
  String getName();

  int getPrice();

  String getAuthor();
}

//书类
class NovelBook implements IBook {
  final String name;

  final int price;

  final String author;

  NovelBook({
    required this.name,
    required this.price,
    required this.author,
  });

  @override
  String getAuthor() {
    return author;
  }

  @override
  String getName() {
    return name;
  }

  @override
  int getPrice() {
    return price;
  }
}

class BookStore {
  static final List<IBook> bookList = <IBook>[
    NovelBook(name: '黄金时代', price: 3800, author: '王小波'),
    NovelBook(name: '丰乳肥臀', price: 3000, author: '莫言'),
    NovelBook(name: '三体', price: 5600, author: '刘慈欣'),
  ];
}
//没有什么坎是过不去的 人生的得意失意，都会随着时间的流逝慢慢过去


///开闭原则是一个非常虚的原则，
///前面5个原则是对开闭原则的具体解释，
///但是开闭原则 并不局限于这么多，它“虚”得没有边界，
///就像“好好学习，天天向上”的口号一样，告诉我们 要好好学习，
///但是学什么，怎么学并没有告诉我们，需要去体会和掌握，
///开闭原则也是一个 口号，那我们怎么把这个口号应用到实际工作中呢？
/// 1. 抽象约束 抽象是对一组事物的通用描述，没有具体的实现，
/// 也就表示它可以有非常多的可能性， 可以跟随需求的变化而变化。
/// 因此，通过接口或抽象类可以约束一组可能变化的行为，并且 能够实现对扩展开放，
/// 其包含三层含义：
/// 第一，通过接口或抽象类约束扩展，对扩展进行边 界限定，不允许出现在接口或抽象类中不存在的public方法；
/// 第二，参数类型、引用对象尽 量使用接口或者抽象类，而不是实现类；
/// 第三，抽象层尽量保持稳定，一旦确定即不允许修 改。还是以书店为例，目前只是销售小说类书籍，单一经营毕竟是有风险的，
/// 于是书店新增 加了计算机书籍，它不仅包含书籍名称、作者、价格等信息，还有一个独特的属性：
/// 面向的 是什么领域，也就是它的范围，比如是和编程语言相关的，还是和数据库相关的，等等
///

//假如书店打折只需要继承抽象书类  完成价格的重写
class OffNovelBook extends NovelBook {
  OffNovelBook({required String name, required int price, required String author})
      : super(name: name, price: price, author: author);

  @override
  int getPrice() {
    int selfPrice = super.getPrice();
    int offPrice = 0;
    if (selfPrice > 4000) {
      offPrice = (selfPrice * 90) ~/ 100;
    } else {
      offPrice = (selfPrice * 80) ~/ 100;
    }

    return offPrice;
  }
}
//计算机类型的书的抽象
abstract class IComputerBook extends IBook {

  String getScope();
}



//计算机类型的书
class ComputerBook implements IComputerBook {
  final String name;
  final String scope;
  final String author;
  final int price;

  ComputerBook( {required   this.name, required this.scope,required  this.author,required this.price,});

 @override
  String getScope() {
    return scope;
  }

 @override
  String getAuthor() {
    return author;
  }

 @override
  String getName() {
    return name;
  }

@override
  int getPrice() {
    return price;
  }

}

