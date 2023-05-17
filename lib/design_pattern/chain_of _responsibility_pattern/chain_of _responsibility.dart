import 'dart:math';

///责任链模式
///
/// 使多个对象都有机会处理请求，从而避免了请求的发送者和接受者之间的耦合关系。
/// 将这些对象连成一条链，并沿着这条链传递该请求直到有对象处理它为止。
/// 责任链模式的重点是在“链”上，由一条链去处理相似的请求在链中决定谁来处理这个请求，并返回相应的结果
///
///
/// 抽象的处理者实现三个职责：
/// 一是定义一个请求的处理方法handleMessage，唯一对外开放的方法；
/// 二是定义一个链的编排方法setNext，设置下一个处理者；
/// 三是定义了具体的请求 者必须实现的两个方法：定义自己能够处理的级别getHandlerLevel和具体的处理任务echo
///
///  责任链模式的优点
/// 责任链模式非常显著的优点是将请求和处理分开。
/// 请求者可以不用知道是谁处理的，处理者可以不用知道请求的全貌
/// （例如在J2EE项目开发中，可以剥离出无状态Bean由责任链处理），两者解耦，提高系统的灵活性。
///
///
///  责任链有两个非常显著的缺点：
///  一是性能问题，每个请求都是从链头遍历到链尾，特别是在链比较长的时候，性能是一个非常大的问题
///  。二是调试不很方便，特别是链条比较长， 环节比较多的时候，由于采用了类似递归的方式，调试的时候逻辑可能比较复杂。
///   链中节点数量需要控制，避免出现超长链的情况，一般的做法是在Handler中设置一个最大节点数量，
///   在setNext方法中判断是否已经是超过其阈值，超过则不允许该链建立，避免无意识地破坏系统性能
///
/// 在例子和通用源码中Handler是抽象类，融合了模板方法模式，每个实现类只要实现两个方法
/// ：echo方法处理请求和getHandlerLevel获得处理级别，想想单一职责原则和迪米特法则吧，
/// 通过融合模板方法模式，各个实现类只要关注的自己业务逻辑就成了，至于说什么事要自己处理，
/// 那就让父类去决定好了，也就是说父类实现了请求传递的功能，子类实现请求 的处理，
/// 符合单一职责原则，各个实现类只完成一个动作或逻辑，也就是只有一个原因引起类的改变，
/// 我建议大家在使用的时候用这种方法，好处是非常明显的了，子类的实现非常简单，责任链的建立也是非常灵活的。
/// 责任链模式屏蔽了请求的处理过程，你发起一个请求到底是谁处理的，这个你不用关心
/// ，只要你把请求抛给责任链的第一个处理者，最终会返回一个处理结果（当然也可以不做任何处理），
/// 作为请求者可以不用知道到底是需要谁来处理的，这是责任链模式的核心，
/// 同时责任链模式也可以作为一种补救模式来使用。
///
///
// abstract class IWomen {
//   int getType();
//
//   String getRequest();
// }
//
// class Women implements IWomen {
//   /*
// 	 *
// 	 * 1---未嫁
// 	 * 2---已婚
// 	 * 3---·丧偶
// 	 */
//   final int? type;
//   final String? request;
//
//   Women({this.type = 0, this.request = ""});
//
//   @override
//   int getType() {
//     return type!;
//   }
//
//   @override
//   String getRequest() {
//     return request!;
//   }
// }
//
// abstract class IHandler {
//   void handleMessage(IWomen women);
// }
//
// class Husband implements IHandler {
//   @override
//   void handleMessage(IWomen women) {
//     print("妻子的请示" + women.getRequest());
//     print("同意");
//   }
// }
//
// class Father implements IHandler {
//   @override
//   void handleMessage(IWomen women) {
//     print("女儿的请示" + women.getRequest());
//     print("同意");
//   }
// }
//
// class Son implements IHandler {
//   @override
//   void handleMessage(IWomen women) {
//     print("女儿的请示" + women.getRequest());
//     print("同意");
//   }
// }
//
// class Client {
//   static void client() {
//     //Ëæ»úÌôÑ¡¼¸¸öÅ®ÐÔ
//     Random rand = Random();
//     List<Women> womanList = [];
//     for (int i = 0; i < 5; i++) {
//       womanList.add(Women(type: rand.nextInt(4), request: "出门"));
//     }
//
//     //¶¨ÒåÈý¸öÇëÊ¾¶ÔÏó
//     IHandler father = Father();
//     IHandler husband = Husband();
//     IHandler son = Son();
//
//     for (var element in womanList) {
//       if (element.getType() == 1) {
//         print("\n--------向父亲请示-------");
//         father.handleMessage(element);
//       } else if (element.getType() == 2) {
//         print("\n--------向丈夫请示-------");
//         husband.handleMessage(element);
//       } else if (element.getType() == 3) {
//         print("\n--------向儿子请示-------");
//         son.handleMessage(element);
//       } else {
//         print("\n--------请示失败-------");
//       }
//     }
//   }
// }

abstract class IWomen {
  int getType();

  String getRequest();
}

class Women implements IWomen {
  final int? type;

  late final String? request;

  // 构造函数
  Women({this.type = 0, this.request}) {
    // 进行请求的展示
    switch (type) {
      case 1:
        request = "女儿的请求是：" + request!;
        break;
      case 2:
        request = "妻子的请求是：" + request!;
        break;
      case 3:
        request = "母亲的请求是：" + request!;
        break;
    }
  }

  @override
  int getType() {
    return type!;
  }

  @override
  String getRequest() {
    return request!;
  }
}

abstract class Handler {
  static int FATHER_LEVEL_REQUEST = 1;
  static int HUSBAND_LEVEL_REQUEST = 2;
  static int SON_LEVEL_REQUEST = 3;
  final int level;

  Handler? nextHanlder;

  Handler({this.level = 0});

  void handleMessage(IWomen women) {
    if (women.getType() == level) {
      response(women);
    } else {
      if (nextHanlder != null) {
        nextHanlder!.handleMessage(women);
      } else {
        print("---------请示失败-----------\n");
      }
    }
  }

  void setNext(Handler _handler) {
    nextHanlder = _handler;
  }

  void response(IWomen women);
}

class Husband extends Handler {
  Husband() : super(level: Handler.HUSBAND_LEVEL_REQUEST);

  @override
  void response(IWomen women) {
    print("--------向丈夫请示-------");
    print(women.getRequest());
    print("同意\n");
  }
}

class Father extends Handler {
  Father() : super(level: Handler.FATHER_LEVEL_REQUEST);

  @override
  void response(IWomen women) {
    print("--------向父亲请示-------");
    print(women.getRequest());
    print("同意\n");
  }
}

class Son extends Handler {
  Son() : super(level: Handler.SON_LEVEL_REQUEST);

  @override
  void response(IWomen women) {
    print("--------向儿子请示-------");
    print(women.getRequest());
    print("同意\n");
  }
}

class Client {
  static void client() {
    Random rand = Random();
    List<IWomen> womanList = [];
    for (int i = 0; i < 5; i++) {
      womanList.add(Women(type: rand.nextInt(4), request: "逛街"));
    }

    Handler father = Father();
    Handler husband = Husband();
    Handler son = Son();
    father.setNext(husband);
    husband.setNext(son);

    for (var element in womanList) {
      father.handleMessage(element);
    }
  }
}

///==========================================================通用模板=====================
///
///
///
class Level {
  //定义一个请求和处理等级
}

//请求
class Request {
//请求的等级
  Level? getRequestLevel() {
    return null;
  }
}

//处理
class Response {
//处理者返回的数据
}

abstract class Handler1 {
  Handler1? nextHandler;

  //每个处理者都必须对请求做出处理
  //传入一个请求得到一个回复
  Response handlerMessage(Request request) {
    // 定义一个回复
    Response? response = Response();

    // 判断是否是自己的处理级别
    if (getHandlerLevel() == request.getRequestLevel()) {
      response = echo(request);
    } else {
      // 不属于自己的处理级别
      // 判断是否有下一个处理者
      if (nextHandler != null) {
        response = nextHandler!.handlerMessage(request);
      } else {
        // 没有适当的处理者，业务自行处理
      }
    }
    return response!;
  }

//传入下一个处理者
  void setNext(Handler1 _handler) {
    nextHandler = _handler;
  }

  Level? getHandlerLevel();

  Response? echo(Request request);
}

class ConcreteHandler1 extends Handler1 {
  @override
  Response? echo(Request request) {
    return null;
  }

  @override
  Level? getHandlerLevel() {
    return null;
  }
}

class ConcreteHandler2 extends Handler1 {
  @override
  Response? echo(Request request) {
    return null;
  }

  @override
  Level? getHandlerLevel() {
    return null;
  }
}

class ConcreteHandler3 extends Handler1 {
  @override
  Response? echo(Request request) {
    return null;
  }

  @override
  Level? getHandlerLevel() {
    return null;
  }
}


 class Client1 {
   static void client1() {
  Handler1 handler1 =  ConcreteHandler1();
  Handler1 handler2 =  ConcreteHandler2();
  Handler1 handler3 =  ConcreteHandler3();
  handler1.setNext(handler2);
  handler2.setNext(handler3);
  Response response = handler1.handlerMessage( Request());
  }
}
