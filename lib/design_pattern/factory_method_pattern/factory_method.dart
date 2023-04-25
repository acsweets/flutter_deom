import 'dart:math';
import 'dart:developer';

///工厂方法构造函数  （定义一个用于创建对象的接口，让子类决定实例化哪一个类。工厂方法使一个类的实例化延迟到其子类。
///==================================================
///例女娲造人的例子：首先，女娲采集黄土捏 成人的形状，
///然后放到八卦炉中烧制，最后放置到大地上生长，工艺过程是没有错的，但是 意外随时都会发生：
///第一次烤泥人，感觉应该熟了，往大地上一放，哇，没烤熟！于是一个白人诞生了！（这也是缺乏经验的最好证明。）
///第二次烤泥人，上一次没烤熟，这次多烤一会儿，放到世间一看，嘿，熟过头了，于是 黑人诞生了！
///第三次烤泥人，一边烧制一边察看，直到表皮微黄，嘿，刚刚好，于是黄色人种出现 了！
///这个造人过程是比较有意思的，是不是可以通过软件开发来实现这个过程呢？
///古人 云：“三人行，必有我师焉”，
///在面向对象的思维中，万物皆对象，是对象我们就可以通过软 件设计来实现。首先对造人过程进行分析，
///该过程涉及三个对象：女娲、八卦炉、三种不同 肤色的人。女娲可以使用场景类Client来表示，
///八卦炉类似于一个工厂，负责制造生产产品 （即人类），三种不同肤色的人，
///他们都是同一个接口下的不同实现类，都是人嘛，只是肤 色、语言不同，对于八卦炉来说都是它生产出的产品。
///=================================================================
///-[AbstractHumanFactory]是一个抽象类，定义了一个八卦炉具有的整体功能，
///[HumanFactory] 为实现类，完成具体的任务——创建人类；Human接口是人类的总称
///，其三个实现类分别为三类人种；[NvWa]类是一个场景类，负责模拟这个场景，执行相关的任务。
///我们定义的每个人种都有两个方法：getColor（获得人的皮肤颜色）和talk（交谈），
///

abstract class Human {
  void getColor();

  void talk();
}

class YellowHuman implements Human {
  @override
  void getColor() {
    print("Yellow human skin color.");
  }

  @override
  void talk() {
    print("Yellow human is talking...");
  }
}

class BlackHuman implements Human {
  @override
  void getColor() {
    print("Black human skin color.");
  }

  @override
  void talk() {
    print("Black human is talking...");
  }
}

class WhiteHuman implements Human {
  @override
  void getColor() {
    print("White human skin color.");
  }

  @override
  void talk() {
    print("White human is talking...");
  }
}

abstract class AbstractHumanFactory {
  Human? createHuman(PeopleType t);
//  T? createHuman<T extends Human>(Type t);
}

class HumanFactory implements AbstractHumanFactory {
  @override
  Human? createHuman(PeopleType t) {
    switch (t) {
      case PeopleType.white:
        return WhiteHuman();
      case PeopleType.black:
        return BlackHuman();
      case PeopleType.yellow:
        return YellowHuman();
      default:
        return null;
    }
  }
// T? createHuman<T extends Human>(Type t) {
//   Human? human;
//   try {
//     switch (t.toString()) {
//       case "WhiteHuman":
//         human = WhiteHuman();
//         break;
//       case "BlackHuman":
//         human = BlackHuman();
//         break;
//       case "YellowHuman":
//         human = YellowHuman();
//         break;
//       default:
//         throw "Invalid human type";
//     }
//   } catch (e) {
//     print("HumanFactory Error: $e");
//   }
//   return human as T;
// }
//
}

enum PeopleType {
  white,
  yellow,
  black,
}
