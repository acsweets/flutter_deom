///命令模式
///将一个请求封装成一个对象，从而让你使用不同的请求把客户端参数化，
///对请求排队或者记录请求日志，可以提供命令的撤销和恢复功能
///● Receive接收者角色 该角色就是干活的角色，命令传递到这里是应该被执行的，具体到我们上面的例子中就 是Group的三个实现类。 ● Command命令角色
///需要执行的所有命令都在这里声明。
///● Invoker调用者角色 接收到命令，并执行命令。在例子中，我（项目经理）就是这个角色。
/// 命令模式比较简单，但是在项目中非常频繁地使用，因为它的封装性非常好，
/// 把请求方 （Invoker）和执行方（Receiver）分开了，扩展性也有很好的保障，
/// 命令模式的优点
/// ● 类间解耦 调用者角色与接收者角色之间没有任何依赖关系，
/// 调用者实现功能时只需调用Command 抽象类的execute方法就可以，不需要了解到底是哪个接收者执行。
/// ● 可扩展性 Command的子类可以非常容易地扩展，而调用者Invoker和高层次的模块Client不产生严 重的代码耦合。
/// ● 命令模式结合其他模式会更优秀 命令模式可以结合责任链模式，实现命令族解析任务；结合模板方法模式，则可以减少 Command子类的膨胀问题。
///
/// 命令模式的缺点
/// 命令模式也是有缺点的，请看Command的子类：如果有N个命令，问题就出来 了，Command的子类就可不是几个，
/// 而是N个，这个类膨胀得非常大，这个就需要读者在项 目中慎重考虑使用。
///
///
/// 命令模式的使用场景
/// 只要你认为是命令的地方就可以采用命令模式，
/// 例如，在GUI开发中，一个按钮的点击 是一个命令，可以采用命令模式；
/// 模拟DOS命令的时候，当然也要采用命令模式；触发－反 馈机制的处理等
///
///
///在Dart中，抽象类和混入（mixin）是两种不同的语言特性，它们具有以下区别：
//
// 抽象类：
//
// 抽象类是通过使用 abstract 关键字来声明的类，它不能直接实例化。
// 抽象类可以包含抽象方法（使用 abstract 关键字声明的方法），这些方法没有具体的实现，只是定义了方法的签名。
// 子类必须实现抽象类中声明的所有抽象方法，否则子类也必须声明为抽象类。
// 抽象类可以有具体的实例变量和具体的方法实现。
// 一个类只能继承一个抽象类，即使抽象类可以作为继承链中的中间类。
// 混入（Mixin）：
//
// 混入是一种通过在类中插入代码来实现代码复用的方式，使用 with 关键字来引入混入。
// 混入类似于多继承的概念，一个类可以使用多个混入，并且可以在不同的类层次结构中重复使用。
// 混入可以包含实例变量、方法和属性，但不能有构造函数。
// 类可以通过混入来继承和使用混入类中的方法和属性，从而添加特定的功能。
// 混入的代码在类中的位置是线性的，即按照 with 关键字的顺序应用。
// 总结：
// 抽象类用于定义类层次结构、强制实现方法和提供部分实现，而混入则用于代码复用和添加特定功能。抽象类通过继承来实现，而混入通过插入代码来实现。抽象类在继承链中具有层次结构，而混入可以在不同的类层次结构中重复使用。


 abstract class Group {

 void find();

  void add();

 void delete();

  void change();

   void plan();

   void rollBack(){

  }
}
 abstract class Command {

   RequirementGroup rg =  RequirementGroup();
   PageGroup pg =  PageGroup();
   CodeGroup cg =  CodeGroup();
//执行
 void execute();

}

 class Invoker {
Command? command;


void setCommand(Command command){
    this.command = command;
  }

 void action(){
    command?.execute();
  }
}


 class DeletePageCommand extends Command {

 @override
  void execute() {

    super.pg.find();

    super.rg.delete();

    super.rg.plan();
  }

}


class CodeGroup extends Group {

@override
  void find() {
    print("ÕÒµ½´úÂë×é...");
  }


@override
  void add() {
   print("¿Í»§ÒªÇóÔö¼ÓÒ»Ïî¹¦ÄÜ...");
  }


@override
  void change() {
   print("¿Í»§ÒªÇóÐÞ¸ÄÒ»Ïî¹¦ÄÜ...");
  }

 @override
  void delete() {
    print("¿Í»§ÒªÇóÉ¾³ýÒ»Ïî¹¦ÄÜ...");
  }

@override
  void plan() {
    print("¿Í»§ÒªÇó´úÂë±ä¸ü¼Æ»®...");
  }

}


 class PageGroup extends Group {

 @override
  void find() {
    print("ÕÒµ½ÃÀ¹¤×é...");
  }

 @override
  void add() {
    print("¿Í»§ÒªÇóÔö¼ÓÒ»¸öÒ³Ãæ...");
  }

  @override
  void change() {
    print("¿Í»§ÒªÇóÐÞ¸ÄÒ»¸öÒ³Ãæ...");
  }

 @override
  void delete() {
    print("¿Í»§ÒªÇóÉ¾³ýÒ»¸öÒ³Ãæ...");
  }

 @override
  void plan() {
   print("¿Í»§ÒªÇóÒ³Ãæ±ä¸ü¼Æ»®...");
  }
}


 class RequirementGroup extends Group {

  @override
  void find() {
    print("ÕÒµ½ÐèÇó×é...");
  }

@override
  void add() {
   print("¿Í»§ÒªÇóÔö¼ÓÒ»ÏîÐèÇó...");
  }

 @override
  void change() {
  print("¿Í»§ÒªÇóÐÞ¸ÄÒ»ÏîÐèÇó...");
  }

   @override
  void delete() {
    print("¿Í»§ÒªÇóÉ¾³ýÒ»ÏîÐèÇó...");
  }

 @override
  void plan() {
   print("¿Í»§ÒªÇóÐèÇó±ä¸ü¼Æ»®...");
  }

}

 class AddRequirementCommand extends Command {

 @override
  void execute() {
    //ÕÒµ½ÐèÇó×é
    super.rg.find();

    //Ôö¼ÓÒ»·ÝÐèÇó
    super.rg.add();

    //Ò³ÃæÒ²ÒªÔö¼Ó
    super.pg.add();

    //¹¦ÄÜÒ²ÒªÔö¼Ó
    super.cg.add();

    //¸ø³ö¼Æ»®
    super.rg.plan();
  }

}
///================命令模式通用模板====================
///调用
class Invoker1 {
  Command? command;

 void setCommand(Command _command){
    command = _command;
  }

  void action(){
    command?.execute();
  }

}


///接受者
 abstract class Receiver {

 void doSomething();
}

 class ConcreteReciver2 extends Receiver{

 @override
  void doSomething(){

  }
}


class ConcreteReciver1 extends Receiver{


   @override
  void doSomething(){

  }
}


 abstract class Command1{
 final Receiver receiver;
 Command1({required this.receiver});
 void execute();
}
 class ConcreteCommand1 extends Command1 {
 ConcreteCommand1() : super(receiver: ConcreteReciver1());

 @override
  void execute() {
    super.receiver.doSomething();
  }
}
