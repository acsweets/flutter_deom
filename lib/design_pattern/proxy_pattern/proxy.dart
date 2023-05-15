///代理模式
///为其他对象提供 一种代理以控制对这个对象的访问。代理模式也叫做委托模式，
///它是一项基本设计技巧。许多其他的模式，如状态模式、策 略模式、访问者模式本质上是在更特殊的场合采用了委托模式
///，而且在日常的应用中，代理 模式可以提供非常好的访问控制
///。在一些著名开源软件中也经常见到它的身影，如Struts2的 Form元素映射就采用了代理模式（准确地说是动态代理模式）。
///我们先看一下类图中的三个 角色的定义：
/// ● Subject抽象主题角色 抽象主题类可以是抽象类也可以是接口，
/// 是一个最普通的业务类型定义，无特殊要求。
/// ● RealSubject具体主题角色也叫做被委托角色、被代理角色。它才是冤大头，是业务逻辑的具体执行者。
/// ● Proxy代理主题角色 也叫做委托类、代理类。它负责对真实角色的应用，把所有抽象主题类定义的方法限制
/// 委托给真实主题角色实现，并且在真实主题角色处理完毕前后做预处理和善后处理工作。
///  代理模式的优点
///  ● 职责清晰 真实的角色就是实现实际的业务逻辑，不用关心其他非本职责的事务，通过后期的代理 完成一件事务，
///  附带的结果就是编程简洁清晰。 ● 高扩展性 具体主题角色是随时都会发生变化的，只要它实现了接口，甭管它如何变化
///  ，都逃不脱 如来佛的手掌（接口），那我们的代理类完全就可以在不做任何修改的情况下使用。
///  ● 智能化 这在我们以上的讲解中还没有体现出来，不过在我们以下的动态代理章节中你就会看到
///  代理的智能化有兴趣的读者也可以看看Struts是如何把表单元素映射到对象上的。
///
///
///  代理模式的使用场景
///  我相信第一次接触到代理模式的读者肯定很郁闷，为什么要用代理呀？
///  想想现实世界 吧，打官司为什么要找个律师？因为你不想参与中间过程的是是非非，
///  只要完成自己的答辩 就成，其他的比如事前调查、事后追查都由律师来搞定，这就是为了减轻你的负担。
///  代理模式的使用场景非常多，大家可以看看Spring AOP，这是一个非常典型的动态代理。
///
///
abstract class IGamePlayer {
  void login(String user, String password);

  void killBoss();

//升级
  void upgrade();
}

class GamePlayer implements IGamePlayer {
  ///加断言
  String name;

  GamePlayer({
    required this.name,
  });

  @override
  void killBoss() {
    print('$name 杀了boss');
  }

  @override
  void login(String user, String password) {
    print('登录$user µÄÓÃ»§ $name µÇÂ¼³É¹¦¡');
  }

  @override
  void upgrade() {
    print('$name 升级');
  }
}

//代理类
class GamePlayerProxy implements IGamePlayer {
  final IGamePlayer _gamePlayer;

  GamePlayerProxy(this._gamePlayer);

  @override
  void killBoss() {
    _gamePlayer.killBoss();
  }

  @override
  void login(String user, String password) {
    _gamePlayer.login(user, password);
  }

  @override
  void upgrade() {
    _gamePlayer.upgrade();
  }
}
// void main() {
//   //定义一个玩家对象
//   IGamePlayer player = GamePlayer(name: "张三");
//
//   //然后再定义一个代练者对象
//   IGamePlayer proxy = GamePlayerProxy(player);
//
//   //开始打游戏，记下时间戳
//   print("开始时间是：2009-8-25 10:45");
//   proxy.login("zhangSan", "password");//登录
//   proxy.killBoss();//打怪
//   proxy.upgrade();//升级
//   //记录结束游戏时间
//   print("结束时间是：2009-8-26 03:40");
// }
///● Subject抽象主题角色
abstract  class Subject {

 void request();
}

///RealSubject是一个正常的业务实现类，代理模式的核心就在代理类上
class RealSubject implements Subject {

   @override
  void request() {

  }

}
///代理实现类

class Proxy implements Subject {
  // 要代理的实现类
  Subject? subject;

  // 默认被代理者
  Proxy() {
   subject = Proxy();
  }

  Proxy.withSubject(Subject subject) {
    subject = subject;
  }

  // 通过构造函数传递代理者
  Proxy.withObjects(List<Object> objects) {
    // do something
  }

  // 实现接口中定义的方法
  @override
  void request() {
    before();
    subject?.request();
    after();
  }

  // 预处理
  void before() {
    // do something
  }

  // 后处理
  void after() {
    // do something
  }
}

