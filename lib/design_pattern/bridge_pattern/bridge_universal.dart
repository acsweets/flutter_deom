///我们先来看桥梁模式中的4个角色。
/// ● Abstraction——抽象化角色 它的主要职责是定义出该角色的行为，同时保存一个对实现化角色的引用，该角色一般是抽象类。
/// ● Implementor——实现化角色 它是接口或者抽象类，定义角色必需的行为和属性。
/// ● RefinedAbstraction——修正抽象化角色 它引用实现化角色对抽象化角色进行修正。
/// ● ConcreteImplementor——具体实现化角色 它实现接口或抽象类定义的方法和属性。桥梁模式中的几个名词比较拗口，
/// 大家只要记住一句话就成：抽象角色引用实现角色， 或者说抽象角色的部分实现是由实现角色完成的。我们来看其通用源码

///将抽象和实现解耦，使得两者可以独立地变化。
//实现化类
abstract class Implementor {
 void doSomething();

 void doAnything();
}

//抽象化角色
 abstract class Abstraction {
  final Implementor imp;
 Abstraction( this.imp);

 void request(){
   imp.doSomething();
  }


 Implementor getImp(){
    return imp;
  }
}


 class ConcreteImplementor1 implements Implementor{

 @override
  void doSomething(){

  }

@override
  void doAnything(){

  }
}
 class ConcreteImplementor2 implements Implementor{

@override
  void doSomething(){
  }
 @override
  void doAnything(){
  }
}

 class RefinedAbstraction extends Abstraction {

 RefinedAbstraction(Implementor _imp) : super(_imp);

   @override
  void request(){
    super.request();
    super.getImp().doAnything();
  }
}


 class Client {

 static void test() {
  Implementor imp =  ConcreteImplementor1();
  Abstraction abs =  RefinedAbstraction(imp);
  abs.request();
  }
}
