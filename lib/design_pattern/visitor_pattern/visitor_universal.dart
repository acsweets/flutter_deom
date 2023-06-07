import 'dart:math';

///● Visitor——抽象访问者 抽象类或者接口，声明访问者可以访问哪些元素，
///具体到程序中就是visit方法的参数定义哪些对象是可以被访问的。
/// ● ConcreteVisitor——具体访问者它影响访问者访问到一个类后该怎么干，要做什么事情。
/// ● Element——抽象元素接口或者抽象类，声明接受哪一类访问者访问，程序上是通过accept方法中的参数来定义的。
/// ● ConcreteElement——具体元素 实现accept方法，通常是visitor.visit(this)，基本上都形成了一种模式了
/// ● ObjectStruture——结构对象 元素产生者，一般容纳在多个不同类、不同接口的容器，如List、Set、Map等，在项目中，
/// 一般很少抽象出这个角色。 大家可以这样理解访问者模式，我作为一个访客（Visitor）到朋友家（Visited Class）去 拜访，
/// 朋友之间聊聊天，喝喝酒，再相互吹捧吹捧，炫耀炫耀，这都正常。聊天的时候，朋 友告诉我，他今年加官晋爵了，工资也涨了30%，
/// 准备再买套房子，那我就在心里盘算 （Visitor-self-method）“你这么有钱，我去年要借10万你都不借”，我根据朋友的信息，执行
/// 了自己的一个方法。 我们来看看访问者模式的通用源码

abstract class IVisitor {
  void visitElement1(ConcreteElement1 el1);

  void visitElement2(ConcreteElement2 el2);
}

abstract class Element {
  void doSomething();

  void accept(IVisitor visitor);
}

class ConcreteElement1 extends Element {
  @override
  void doSomething() {}

  @override
  void accept(IVisitor visitor) {
    visitor.visitElement1(this);
  }
}

class ConcreteElement2 extends Element {
  @override
  void doSomething() {}

  @override
  void accept(IVisitor visitor) {
    visitor.visitElement2(this);
  }
}

 class Visitor implements IVisitor {

@override
  void visitElement1(ConcreteElement1 el1) {
    el1.doSomething();
  }

@override
  void visitElement2(ConcreteElement2 el2) {
    el2.doSomething();
  }
}



 class ObjectStruture {

static Element createElement(){
    Random rand =  Random();
    if(rand.nextInt(100) > 50){
      return  ConcreteElement1();
    }else{
      return  ConcreteElement2();
    }
  }
}

 class Client {
   static void test() {
  for(int i=0;i<10;i++){
  Element el = ObjectStruture.createElement();
  el.accept(Visitor());
  }
  }
}

///通过增加访问者，只要是具体元素就非常容易访问，对元素的遍历就更加容易了，
///甭管它是什么对象，只要它在一个容器中，都可以通过访问者来访问，任务集中化。这就是访问者模式。
