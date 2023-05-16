import 'dart:core';
import 'dart:math';

///（用一个中介对象封装一系列的对象 交互，中介者使各对象不需要显示地相互作用
///从而使其耦合松散，而且可以独立地改变它 们之间的交互。
///进销存
///中介者Mediator定义了多个private方法，其目的是处理各个对象之间的依赖关系，
///就是 说把原有一个对象要依赖多个对象的情况移到中介者的private方法中实现。
///在实际项目中， 一般的做法是中介者按照职责进行划分，每个中介者处理一个或多个类似的关联请求。
///● Mediator 抽象中介者角色
/// 抽象中介者角色定义统一的接口，用于各同事角色之间的通信。
/// ● Concrete Mediator 具体中介者角色 具体中介者角色通过协调各同事角色实现协作行为，
/// 因此它必须依赖于各个同事角色。
/// ● Colleague 同事角色 每一个同事角色都知道中介者角色，而且与其他的同事角色通信的时候，一定要通过中介者角色协作。
/// 每个同事类的行为分为两种：一种是同事本身的行为，比如改变对象本身的状态，
/// 处理自己的行为等，这种行为叫做自发行为（Self-Method），
/// 与其他的同事类或中介 者没有任何的依赖；第二种是必须依赖中介者才能完成的行为，叫做依赖方法（Dep- Method）
///
///
///
///
/// 中介者模式的应用
/// 中介者模式的优点
/// 中介者模式的优点就是减少类间的依赖，
/// 把原有的一对多的依赖变成了一对一的依赖，
/// 同事类只依赖中介者，减少了依赖，当然同时也降低了类间的耦合。
///
///
///  中介者模式的缺点
///  中介者模式的缺点就是中介者会膨胀得很大，而且逻辑复杂，
///  原本N个对象直接的相互依赖关系转换为中介者和同事类的依赖关系，同事类越多，中介者的逻辑就越复杂。
///
///
///   中介者模式的使用场景
///   中介者模式简单，但是简单不代表容易使用，很容易被误用。在面向对象的编程中
///   ，对象和对象之间必然会有依赖关系，如果某个类和其他类没有任何相互依赖的关系，
///   那这个类 就是一个“孤岛”，在项目中就没有存在的必要了！就像是某个人如果永远独立生活，与任何人都没有关系，
///   那这个人基本上就算是野人了——排除在人类这个定义之外。 类之间的依赖关系是必然存在的，
///   一个类依赖多个类的情况也是存在的，存在即合理， 那是否可以说只要有多个依赖关系就考虑使用中介者模式呢？
///   答案是否定的中介者模式未必能帮你把原本凌乱的逻辑整理得清清楚楚，
///   而且中介者模式也是有缺点的，这个缺点在使用不当时会被放大，
///   比如原本就简单的几个对象依赖关系，如果为了使用模式而加入了中介者，
///   必然导致中介者的逻辑复杂化，因此中介者模式的使用需要“量力而行”！中介者模式适用于多个对象之间紧密耦合的情况，
///   紧密耦合的标准是：在类图中出现了蜘蛛网状结构。在这种情况下一定要考虑使用中介者模式，
///   这有利于把蜘蛛网梳理为星型结构，使原本复杂混 乱的关系变得清晰简单
///  例 ● 机场调度中心  MVC框架  媒体网关   中介服务
///销售类
// class Sale {
//   void sellIBMComputer(int number) {
//     Stock stock = Stock();
//     Purchase purchase =  Purchase();
//     if (stock.getStockNumber() < number) {
//
//       purchase.buyIBMcomputer(number);
//     }
//     print("");
//     stock.decrease(number);
//   }
//
//   int getSaleStatus() {
//     Random rand = Random();
//     int saleStatus = rand.nextInt(100);
//     print("");
//     return saleStatus;
//   }
//
//   void offSale() {
//     Stock stock = Stock();
//     print("");
//   }
// }
//
// //库存类
// class Stock {
//   static int COMPUTER_NUMBER = 100;
//
//   void increase(int number) {
//     COMPUTER_NUMBER = COMPUTER_NUMBER + number;
//     print("");
//   }
//
//   void decrease(int number) {
//     COMPUTER_NUMBER = COMPUTER_NUMBER - number;
//     print("º");
//   }
//
//   int getStockNumber() {
//     return COMPUTER_NUMBER;
//   }
//
//   void clearStock() {
//     Purchase purchase = Purchase();
//     Sale sale = Sale();
//     print("");
//     sale.offSale();
//     purchase.refuseBuyIBM();
//   }
// }
//
// //购买类
// class Purchase {
//   void buyIBMcomputer(int number) {
//     Stock stock = Stock();
//     Sale sale =  Sale();
//     int saleStatus = sale.getSaleStatus();
//
//     if (saleStatus > 80) {
//       print("");
//       stock.increase(number);
//     } else {
//       int buyNumber = (number / 2) as int;
//       print("");
//     }
//   }
//   void refuseBuyIBM() {
//     print("");
//   }
// }

abstract class AbstractColleague {
  AbstractMediator mediator;

  AbstractColleague({required this.mediator});
}

abstract class AbstractMediator {
  Purchase purchase;

  Sale sale;

  Stock stock;

  AbstractMediator(this.stock, this.purchase, this.sale) {
    purchase = Purchase(this);
    sale = Sale(this);
    stock = Stock(this);
  }

  void execute(String str, var objects);
}

//中介者
class Mediator extends AbstractMediator {
  Mediator(Stock stock, Purchase purchase, Sale sale) : super(stock, purchase, sale);

//处理
  @override
  void execute(String str, var objects) {
    if (str == 'purchase.buy') {
      buyComputer(objects as int);
    } else if (str == 'sale.sell') {
      sellComputer(objects as int);
    } else if (str == 'sale.offsell') {
      offSell();
    } else if (str == 'stock.clear') {
      clearStock();
    }
  }

  void buyComputer(int number) {
    int saleStatus = super.sale.getSaleStatus();
    if (saleStatus > 80) {
      print('购买IBM电脑：$number 台');
      super.stock.increase(number);
    } else {
      int buyNumber = (number / 2) as int;
      print('购买IBM电脑：$buyNumber 台');
    }
  }

  void sellComputer(int number) {
    if (super.stock.getStockNumber() < number) {
      super.purchase.buyIBMcomputer(number);
    }
    super.stock.decrease(number);
  }

  void offSell() {
    print('折价销售IBM电脑 ${stock.getStockNumber()} 台');
  }

  void clearStock() {
    super.sale.offSale();
    super.purchase.refuseBuyIBM();
  }
}

//进
class Purchase extends AbstractColleague {
  Purchase(AbstractMediator mediator) : super(mediator: mediator);

  void buyIBMcomputer(int number) {
    super.mediator.execute("purchase.buy", number);
  }

  void refuseBuyIBM() {
    print('不再采购IBM电脑');
  }
}

//销
class Sale extends AbstractColleague {
  Sale(AbstractMediator mediator) : super(mediator: mediator);

  void sellIBMComputer(int number) {
    super.mediator.execute("sale.sell", number);
    print('销售IBM电脑 $number 台');
  }

  int getSaleStatus() {
    Random rand = Random();
    int saleStatus = rand.nextInt(100);
    print('IBM电脑的销售情况为：$saleStatus');
    return saleStatus;
  }

  void offSale() {
    super.mediator.execute("sale.offsell", '');
  }
}

//存
class Stock extends AbstractColleague {
  Stock(AbstractMediator mediator) : super(mediator: mediator);

  static int COMPUTER_NUMBER = 100;

  void increase(int number) {
    COMPUTER_NUMBER = COMPUTER_NUMBER + number;
    print('库存数量为：$COMPUTER_NUMBER');
  }

  void decrease(int number) {
    COMPUTER_NUMBER = COMPUTER_NUMBER - number;
    print('库存数量为：$COMPUTER_NUMBER');
  }

  int getStockNumber() {
    return COMPUTER_NUMBER;
  }

  void clearStock() {
    print('库存数量为：$COMPUTER_NUMBER');
    super.mediator.execute("stock.clear", '');
  }
}

///=================================================================

abstract class Mediator1 {
  late ConcreteColleague1 c1;
  late ConcreteColleague2 c2;


  ConcreteColleague1 getC1() {
    return c1;
  }

  void setC1(ConcreteColleague1 c1) {
    this.c1 = c1;
  }

  ConcreteColleague2 getC2() {
    return c2;
  }

  void setC2(ConcreteColleague2 c2) {
    this.c2 = c2;
  }

  void doSomething1();

  void doSomething2();
}

class ConcreteMediator extends Mediator1 {
  ConcreteMediator();

  @override
  void doSomething1() {
    super.c1.selfMethod1();
    super.c2.selfMethod2();
  }

  @override
  void doSomething2() {
    super.c1.selfMethod1();
    super.c2.selfMethod2();
  }
}

abstract class Colleague {
  Mediator1 mediator;

  Colleague({
    required this.mediator,
  });
}

class ConcreteColleague2 extends Colleague {
  ConcreteColleague2(Mediator1 mediator) : super(mediator: mediator);

  void selfMethod2() {}

  void depMethod2() {
    super.mediator.doSomething2();
  }
}

class ConcreteColleague1 extends Colleague {
  ConcreteColleague1(Mediator1 mediator) : super(mediator: mediator);

  void selfMethod1() {}

  void depMethod1() {
    super.mediator.doSomething1();
  }
}
