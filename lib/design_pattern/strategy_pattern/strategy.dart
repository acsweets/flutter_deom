import 'package:flutter/cupertino.dart';

///策略模式
///定义一组算法，将每个算法都封装起来，并且使它们之间可以互换
///这个定义是非常明确、清晰的，“定义一组算法”，看看我们的三个计谋是不是三个算 法？“将每个算法都封装起来”，
///封装类Context不就是这个作用吗？“使它们可以互换”当然可 以互换了，都实现是相同的接口，那当然可以相互转化了
///
///策略模式的优点
/// ● 算法可以自由切换 这是策略模式本身定义的，只要实现抽象策略，它就成为策略家族的一个成员，
/// 通过封装角色对其进行封装，保证对外提供“可自由切换”的策略。
/// ● 避免使用多重条件判断 如果没有策略模式，我们想想看会是什么样子？一个策略家族有5个策略算法，
/// 一会要 使用A策略，一会要使用B策略，怎么设计呢？使用多重的条件语句？多重条件语句不易维护，
/// 而且出错的概率大大增强。使用策略模式后，可以由其他模块决定采用何种策略，
/// 策略家族对外提供的访问接口就是封装类，简化了操作，同时避免了条件语句判断。
/// ● 扩展性良好 这甚至都不用说是它的优点，因为它太明显了。
/// 在现有的系统中增加一个策略太容易 了，只要实现接口就可以了，其他都不用修改，
/// 类似于一个可反复拆卸的插件，这大大地符 合了OCP原则。
///
///
/// 策略模式的缺点
/// ● 策略类数量增多 每一个策略都是一个类，复用的可能性很小，类数量增多。
/// ● 所有的策略类都需要对外暴露 上层模块必须知道有哪些策略，然后才能决定使用哪一个策略
/// ，这与迪米特法则是相违背的，我只是想使用了一个策略，我凭什么就要了解这个策略呢？
/// 那要你的封装类还有什么意义？这是原装策略模式的一个缺点，
/// 我们可以使用其他模式来修正这个缺陷，如工厂方法模式、代理模式或享元模式。
///
///
/// 策略模式的使用场景
/// ● 多个类只有在算法或行为上稍有不同的场景。
/// ● 算法需要自由切换的场景。
/// 例如，算法的选择是由使用者决定的，或者算法始终在进化，
/// 特别是一些站在技术前沿 的行业，连业务专家都无法给你保证这样的系统规则能够存在多长时间，
/// 在这种情况下策略模式是你最好的助手。
/// ● 需要屏蔽算法规则的场景。 现在的科技发展得很快，人脑的记忆是有限的（就目前来说是有限的），
/// 太多的算法你 只要知道一个名字就可以了，传递相关的数字进来，反馈一个运算结果，万事大吉。
///
///
/// 策略模式的注意事项 如果系统中的一个策略家族的具体策略数量超过4个，
///则需要考虑使用混合模式，解决策略类膨胀和对外暴露的问题，
///==============================================================
///我们的策略模式只是实现了算法策略的管理，但是我们没有严格地定义“适当的场景”拆开“适当的锦囊”，
///在实际项目中，我们一般通过工厂方法模式来实现策略类的声明，

//战略
abstract class IStrategy {
  void operate();
}

//战略1
class BackDoor implements IStrategy {
  @override
  void operate() {
    print("找乔国老帮忙，让吴国太给孙权施加压力");
  }
}

//战略2
class BlockEnemy implements IStrategy {
  @override
  void operate() {
    print("孙夫人断后");
  }
}

//战略3
class GivenGreenLight implements IStrategy {
  @override
  void operate() {
    print("求吴国太开绿灯,放行");
  }
}

///[Context]封装类（也就是锦囊），其作用是承装三个策略，方便赵云使用
class Context {
  //构造函数，你要使用哪个妙计
  final IStrategy strategy;

  Context({required this.strategy});

//使用计谋了，看我出招了
  void operate() {
    strategy.operate();
  }
}

class ZhaoYun {
  //赵云出场了，他根据诸葛亮给他的交代，依次拆开妙计
  static void start() {
    Context context;
    //刚刚到吴国的时候拆第一个
    print("---刚刚到吴国的时候拆第一个---");
    context = Context(strategy: BackDoor());
    //拿到妙计
    context.operate();
// 拆开执行
    print("\n\n\n\n\n\n\n\n");
    //刘备乐不思蜀了，拆第二个了
    print("---刘备乐不思蜀了，拆第二个了---");
    context = Context(strategy: GivenGreenLight());
    context.operate();
//执行了第二个锦囊
    print("\n\n\n\n\n\n\n\n");
// 孙权的小兵追来了，咋办？拆第三个
    print("---孙权的小兵追来了，咋办？拆第三个---");
    context = Context(strategy: BlockEnemy());
    context.operate();
// 孙夫人退兵
    print("\n\n\n\n\n\n\n\n");
  }
}

///策略模式使用的就是面向对象的继承和多态机制，非常容易理解和掌握，我们再来看看 策略模式的三个角色：
/// ● Context封装角色 它也叫做上下文角色，起承上启下封装作用，屏蔽高层模块对策略、算法的直接访问， 封装可能存在的变化。
/// ● Strategy抽象策略角色 策略、算法家族的抽象，通常为接口，定义每个策略或算法必须具有的方法和属性。
/// 各位看官可能要问了，类图中的AlgorithmInterface是什么意思，嘿嘿，algorithm是“运算法则”的 意思，结合起来意思就明白了吧。
/// ● ConcreteStrategy具体策略角色 实现抽象策略中的操作，该类含有具体的算法。

///==================================通用模板=================================

//策略的抽象类
abstract class Strategy {
  void doSomething();
}

class ConcreteStrategyA implements Strategy {
  @override
  void doSomething() {
    print("策略A");
  }
}

class ConcreteStrategyB implements Strategy {
  @override
  void doSomething() {
    print("策略B");
  }
}

//传一个策略进来
class Context1 {
  late final Strategy? strategy;

  Context1({this.strategy});

  //做事的时候就用这个策略

  void doAnythinig() {
    strategy?.doSomething();
  }
}

class Client1 {
  static void start1() {
    Strategy strategy = ConcreteStrategyA();
    Context1 context = Context1(strategy: strategy);
    context.doAnythinig();
  }
}

///=============================================================类似计算器每个计算都是一个策略====================

abstract class Calculator {
  int exec(int a, int b);
}

class Add implements Calculator {
  int exec(int a, int b) {
    return a + b;
  }
}

class Sub implements Calculator {
  int exec(int a, int b) {
    return a - b;
  }
}

class Context2 {
  final Calculator? cal;

  Context2({this.cal});

  int exec(int a, int b, String symbol) {
    return cal!.exec(a, b);
  }
}

class Client2 {
  static String ADD_SYMBOL = "+";

  static String SUB_SYMBOL = "-";

  static void start2() {
    int a = 2;
    String symbol = '+'; //·ûºÅ
    int b = 6;

    Context2? context;
    if (symbol == ADD_SYMBOL) {
      context = Context2(cal: Add());
    } else if (symbol == SUB_SYMBOL) {
      context = Context2(cal: Sub());
    }
    print("结果º" + '$a ' + symbol + "$b" + "=" + ' ${context?.exec(a, b, symbol)}');
  }
}
