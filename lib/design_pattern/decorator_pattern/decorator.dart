///装饰模式
///动态地给一个对象添加一些额外的职责。 就增加功能来说，装饰模式相比生成子类更为灵活。
///
/// 装饰模式的优点
/// ● 装饰类和被装饰类可以独立发展，而不会相互耦合。换句话说，Component类无须知 道Decorator类，
/// Decorator类是从外部来扩展Component类的功能，而Decorator也不用知道具 体的构件。
/// ● 装饰模式是继承关系的一个替代方案。我们看装饰类Decorator，不管装饰多少层，返回的对象还是Component，
/// 实现的还是is-a的关系。 ● 装饰模式可以动态地扩展一个实现类的功能，这不需要多说，装饰模式的定义就是如此。
///
///
///  装饰模式的缺点
///  对于装饰模式记住一点就足够了：多层的装饰是比较复杂的。
///  为什么会复杂呢？你想想 看，就像剥洋葱一样，你剥到了最后才发现是最里层的装饰出现了问题，想象一下工作量
///  吧，因此，尽量减少装饰类的数量，以便降低系统的复杂度。
///
///
///  装饰模式的使用场景
/// ● 需要扩展一个类的功能，或给一个类增加附加功能。
/// ● 需要动态地给一个对象增加功能，这些功能可以再动态地撤销。
/// ● 需要为一批的兄弟类进行改装或加装功能，当然是首选装饰模式
///
///================例子就是把一个比较平庸的成绩单装饰成家 长认可的成绩单。========================

//抽象的成绩单
abstract class SchoolReport {
//成绩单
  void report();

//签名
  void sign(String name);
}

abstract class Decorator extends SchoolReport {
  final SchoolReport sr;

  Decorator({required this.sr});

  @override
  void report() {
    sr.report();
  }

  @override
  void sign(String name) {
    sr.sign(name);
  }
}

//装饰类用于装饰成绩单
class SortDecorator extends Decorator {
  SortDecorator(SchoolReport sr) : super(sr: sr);

  void reportSort() {
    print("我的排名是...");
  }

  @override
  void report() {
    super.report();
    reportSort();
  }
}

//装饰类用于装饰成绩单
class HighScoreDecorator extends Decorator {
  HighScoreDecorator(SchoolReport sr) : super(sr: sr);

  void reportHighScore() {
    print("最高分是67");
  }

  @override
  void report() {
    reportHighScore();
    super.report();
  }
}

//装饰类用于装饰成绩单
class FouthGradeSchoolReport extends SchoolReport {
  @override
  void report() {
    //³É¼¨µ¥µÄ¸ñÊ½ÊÇÕâ¸öÑù×ÓµÄ
    print("尊敬的XXX家长:");
    print(" ......");
    print(" 语文 62 数学65 体育 98 自然 63");
    print(" .......");
    print(" 家长签名： ");
  }

  @override
  void sign(String name) {
    print("家长签名为：" + name);
  }
}

///通用模板===========================================
///有四个角色需要说明：
///● Component抽象构件 Component是一个接口或者是抽象类，就是定义我们最核心的对象，也就是最原始的对象，如上面的成绩单。
///注意在装饰模式中，必然有一个最基本、最核心、最原始的接口或抽象类充当  [Component]抽象构件。
/// ● [ConcreteComponent ]具体构件 [ConcreteComponent ]是最核心、最原始、最基本的接口或抽象类的实现，你要装饰的就是它。
/// ● Decorator装饰角色 一般是一个抽象类，做什么用呢？实现接口或者抽象方法，它里面可不一定有抽象的方法呀，
/// 在它的属性里必然有一个private变量指向Component抽象构件。
/// ● 具体装饰角色 [ConcreteDecorator1]和[ConcreteDecorator2]是两个具体的装饰类，
///你要把你最核心的、最原始的、最基本的东西装饰成其他东西。
///丑陋的成绩单装饰成老爹认可的

abstract class Component {
  void operate();
}

class ConcreteComponent extends Component {
  @override
  void operate() {
    print("do Something");
  }
}

abstract class Decorator1 extends Component {
  final Component? component;

  Decorator1({this.component});

  @override
  void operate() {
    component!.operate();
  }
}

class ConcreteDecorator1 extends Decorator1 {
  ConcreteDecorator1(Component component) :super(component: component);
  void method1() {
   print("method1 ");
  }

  @override
  void operate() {
    method1();
    super.operate();
  }
}

class ConcreteDecorator2 extends Decorator1 {
  ConcreteDecorator2(Component component) :super(component: component);
  void method2() {
    print("method2 ");
  }

  @override
  void operate() {
    method2();
    super.operate();
  }
}


 class Client {

 static void client() {
  Component component = ConcreteComponent();
  component = ConcreteDecorator1(component);//先被他装饰
  component = ConcreteDecorator2(component);//再被他装饰
  component.operate();
  }
}