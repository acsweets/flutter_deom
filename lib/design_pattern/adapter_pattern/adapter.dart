///适配器模式
///将一个类的接口变换成客户端所期待的另一种接口，
///从而使原本因接口不匹配而无法在一起工作的两个类能够在一起工 作。）
///适配器模式又叫做变压器模式，也叫做包装模式（Wrapper），
///但是包装模式可不止一个，还包括装饰模式。适配器模式的通用类图
///适配器模式就是把一个接口或类转换成其他的接口或类，从另一方面来说，适配器模式也就是一个包装模式，
///为什么呢？它把Adaptee包装成一个Target接口的类，加了一层衣服，包装成另外一个靓妞了
///
///
///适配器模式的优点
/// ● 适配器模式可以让两个没有任何关系的类在一起运行，只要适配器这个角色能够搞定 他们就成。
/// ● 增加了类的透明性 想想看，我们访问的Target目标角色，但是具体的实现都委托给了源角色
/// ，而这些对高 层次模块是透明的，也是它不需要关心的。
/// ● 提高了类的复用度 当然了，源角色在原有的系统中还是可以正常使用，而在目标角色中也可以充当新的演 员。
///● 灵活性非常好某一天，突然不想要适配器，没问题，删除掉这个适配器就可以了，
///其他的代码都不用 修改，基本上就类似一个灵活的构件，想用就用，不想就卸载。
///
///
///
/// 适配器模式的使用场景
/// 适配器应用的场景只要记住一点就足够了：你有动机修改一个已经投产中的接口时，适配器模式可能是最适合你的模式。
/// 比如系统扩展了，需要使用一个已有或新建立的类，但这 个类又不符合系统的接口，怎么办？使用适配器模式，这也是我们例子中提到的。
/// 适配器模式的注意事项
///适配器模式最好在详细设计阶段不要考虑它，它不是为了解决还处在开发阶段的问题，
///而是解决正在服役的项目问题，没有一个系统分析师会在做详细设计的时候考虑使用适配器模式
///，这个模式使用的主要场景是扩展应用中，就像我们上面的那个例子一样，系统扩展了，
///不符合原有设计的时候才考虑通过适配器模式减少代码修改带来的风险。
///再次提醒一点，项目一定要遵守依赖倒置原则和里氏替换原则，否则即使在适合使用适 配器的场合下，也会带来非常大的改造
///[依赖倒置原则:高层模块不应该依赖低层模块，两者都应该依赖其抽象；抽象不应该依赖细节；细节应该依赖抽象。]
///[里氏替换原则：只要父类能出现的地方子类就可以出现，而且替换为子类也不会产生任何错误或异常，使用者可能根本就不需要知道是父类还是子类。但 是，反过来就不行了，有子类出现的地方，父类未必就能适应]
///[迪米特法则的核心观念就是类间解耦，弱耦合，只有弱耦合了以后，类的复用率才可以提高]

abstract class IUserInfo {
  String getUserName();

  String getHomeAddress();

  String getMobileNumber();

  String getOfficeTelNumber();

  String getJobPosition();

  String getHomeTelNumber();
}

class UserInfo implements IUserInfo {
  @override
  String getHomeAddress() {
    print("家庭地址");
    return "null";
  }

  @override
  String getHomeTelNumber() {
    print("电话号码1582566443");
    return "null";
  }

  @override
  String getJobPosition() {
    print("工作位置");
    return "null";
  }

  @override
  String getMobileNumber() {
    print("电话号码");
    return "null";
  }

  @override
  String getOfficeTelNumber() {
    print("°工作号码");
    return "null";
  }

  @override
  String getUserName() {
    print("名字");
    return "";
  }
}

abstract class IOuterUser {
  Map getUserBaseInfo();

  Map getUserOfficeInfo();

  Map getUserHomeInfo();
}

class OuterUser implements IOuterUser {
  @override
  Map getUserBaseInfo() {
    Map baseInfoMap = {};

    baseInfoMap["userName"] = "张三";
    baseInfoMap["mobileNumber"] = "12753863752";

    return baseInfoMap;
  }

  @override
  Map getUserHomeInfo() {
    Map homeInfo = {};
    homeInfo["homeTelNumbner"] = "132554245375";
    homeInfo["homeAddress"] = "天津";
    return homeInfo;
  }

  @override
  Map getUserOfficeInfo() {
    Map officeInfo = {};
    officeInfo["jobPosition"] = "北京市";
    officeInfo["officeTelNumber"] = "0564789523";
    return officeInfo;
  }
}

///适配器适配两种不同的数据格式
class OuterUserInfo extends OuterUser implements IUserInfo {
  late final Map baseInfo = super.getUserHomeInfo();
  late final Map homeInfo = super.getUserHomeInfo();
  late final Map officeInfo = super.getUserOfficeInfo();

  @override
  String getHomeAddress() {
    String homeAddress = homeInfo["homeAddress"];
    print(homeAddress);
    return homeAddress;
  }

  @override
  String getHomeTelNumber() {
    String homeTelNumber = homeInfo["homeTelNumber"];
    print(homeTelNumber);
    return homeTelNumber;
  }

  @override
  String getJobPosition() {
    String jobPosition = officeInfo["jobPosition"];
    print(jobPosition);
    return jobPosition;
  }

  @override
  String getMobileNumber() {
    String mobileNumber = baseInfo["mobileNumber"];
    print(mobileNumber);
    return mobileNumber;
  }

  @override
  String getOfficeTelNumber() {
    String officeTelNumber = officeInfo["officeTelNumber"];
    print(officeTelNumber);
    return officeTelNumber;
  }

  @override
  String getUserName() {
    String userName = baseInfo["userName"];
    print(userName);
    return userName;
  }
}

///● Target目标角色
/// 该角色定义把其他类转换为何种接口，也就是我们的期望接口，例子中的IUserInfo接口 就是目标角色。
/// ● Adaptee源角色你想把谁转换成目标角色，这个“谁”就是源角色，
/// 它是已经存在的、运行良好的类或对象，经过适配器角色的包装，它会成为一个崭新、靓丽的角色。
/// ● Adapter适配器角色 适配器模式的核心角色，其他两个角色都是已经存在的角色，而适配器角色是需要新建 立的，
/// 它的职责非常简单：把源角色转换为目标角色，怎么转换？通过继承或是类关联的方式。
/// 各个角色的职责都已经非常清楚，我们再来看看其通用源码
/// ====================================================通用模板=========================
///
///
///
///
/// 原
abstract class Target {
  void request();
}

class Adaptee {
  void doSomething() {
    print("I'm kind of busy,leave me alone,pls!");
  }
}

class Adapter extends Adaptee implements Target {
  @override
  void request() {
    super.doSomething();
  }
}

class ConcreteTarget implements Target {
  @override
  void request() {
    print("I have nothing to do. if you need any help,pls call me!");
  }
}

///适配器模式的扩展

abstract class IOuterUserOfficeInfo {
//¹¤×÷ÇøÓòÐÅÏ¢
Map getUserOfficeInfo();
}

abstract class IOuterUserHomeInfo {

Map getUserHomeInfo();
}

abstract class IOuterUserBaseInfo {

Map getUserBaseInfo();

}