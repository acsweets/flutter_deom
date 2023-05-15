///强制代理  ====必须走代理
///在接口上增加了一个getProxy方法，真实角色GamePlayer可以指定一个自己的代理，除了代理外谁都不能访问
///代理角色也可以再次被代理，这里我们就没有继续延伸下去了，查找代理的方法就返回 自己的实例。
///强制代理的概念就是要从真实角色查找到代理角色，不允 许直接访问真实角色。
///高层模块只要调用getProxy就可以访问真实角色的所有方法，它根本就不需要产生一个代理出来
///代理的管理已经由真实角色自己完成。
///
///
abstract class IGamePlayer {
  void login(String user, String password);

  void killBoss();

  void upgrade();

  IGamePlayer getProxy(); //返回一个玩家
}

//代理的抽象类
abstract class IProxy {
  //计算费用
  //用来计算代理的费用
  void count();
}

class GamePlayerProxy implements IGamePlayer, IProxy {
  IGamePlayer? gamePlayer;

  GamePlayerProxy({this.gamePlayer});

  @override
  void killBoss() {
    gamePlayer?.killBoss();
  }

  @override
  void login(String user, String password) {
    gamePlayer?.login(user, password);
  }

  @override
  void upgrade() {
    gamePlayer?.upgrade();
    count();
  }

  @override
  IGamePlayer getProxy() {
    return this;
  }

  @override
  void count() {
    int money = 0;
    money += 10;
    print("升级总费用是：$money元");
  }
}

class GamePlayer implements IGamePlayer {
  String name = "";

  IGamePlayer? proxy;

  GamePlayer({
    required this.name,
  });

  @override
  IGamePlayer getProxy() {
    proxy = GamePlayerProxy();
    return proxy!;
  }

  //´
  @override
  void killBoss() {
    if (isProxy()) {
      print(name + "杀怪");
    } else {
      print("请使用指定的代理访问");
    }
  }

  @override
  void login(String user, String password) {
    if (isProxy()) {
      print("" + user + " µÄÓÃ»§ " + name + "登录");
    } else {
      print("请使用指定的代理访问");
      ;
    }
  }

  @override
  void upgrade() {
    if (isProxy()) {
      print(name + " 升级");
    } else {
      print("请使用指定的代理访问");
    }
  }

  bool isProxy() {
    if (proxy == null) {
      return false;
    } else {
      return true;
    }
  }
}

class Client {
  static void play() {
    //定义一个游戏的角色
    IGamePlayer player = GamePlayer(name: '张三');
// 获得指定的代理
    IGamePlayer proxy = player.getProxy();
// 开始打游戏，记下时间戳
    print("开始时间是：2009-8-25 10:45");
    proxy.login("zhangSan", "password");
    proxy.killBoss();
    proxy.upgrade();
// 记录结束游戏时间
    print("结束时间是：2009-8-26 03:40");
  }
}
