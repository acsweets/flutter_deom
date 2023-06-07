///门面模式（Facade Pattern）也叫做外观模式
///门面模式注重“统一的对象”，也就是提供一个访问子系统的接口，
///除了这个接口不允许 有任何访问子系统的行为发生
///再简单地说，门面对象是外界访问子系统内部的唯一通道，
///不管子系统内部是多么杂乱 无章，只要有门面对象在，就可以做到“金玉其外，败絮其中”。我们先明确一下门面模式的 角色
///。● Facade门面角色 客户端可以调用这个角色的方法。此角色知晓子系统的所有功能和责任。一般情况下，
/// 本角色会将所有从客户端发来的请求委派到相应的子系统去，也就说该角色没有实际的业务 逻辑，只是一个委托类。
/// ● subsystem子系统角色 可以同时有一个或者多个子系统。每一个子系统都不是一个单独的类，而是一个类的集合。
/// 子系统并不知道门面的存在。对于子系统而言，门面仅仅是另外一个客户端而已。

///
///门面模式的优点 门面模式有如下优点。
/// ● 减少系统的相互依赖 想想看，如果我们不使用门面模式，外界访问直接深入到子系统内部，
/// 相互之间是一种 强耦合关系，你死我就死，你活我才能活，这样的强依赖是系统设计所不能接受的，
/// 门面模式的出现就很好地解决了该问题，所有的依赖都是对门面对象的依赖，与子系统无关。
/// ● 提高了灵活性 依赖减少了，灵活性自然提高了。不管子系统内部如何变化，只要不影响到门面对象任你自由活动。
/// ● 提高安全性 想让你访问子系统的哪些业务就开通哪些逻辑，不在门面上开通的方法，你休想访问到。
///
///
/// 门面模式的缺点
/// 门面模式最大的缺点就是不符合开闭原则，对修改关闭，对扩展开放，看看我们那个门 面对象吧，它可是重中之重，
/// 一旦在系统投产后发现有一个小错误，你怎么解决？完全遵从 开闭原则，根本没办法解决。继承？覆写？都顶不上用
/// ，唯一能做的一件事就是修改门面角 色的代码，这个风险相当大，这就需要大家在设计的时候慎之又慎，多思考几遍才会有好收获。
///
///门面模式的使用场景
/// ● 为一个复杂的模块或子系统提供一个供外界访问的接口
/// ● 子系统相对独立——外界对子系统的访问只要黑箱操作即可 比如利息的计算问题，
/// 没有深厚的业务知识和扎实的技术水平是不可能开发出该子系统的，但是对于使用该系统的开发人员来说
/// 他需要做的就是输入金额以及存期，其他的都不用关心，返回的结果就是利息这时候，门面模式是非使用不可了。
/// ● 预防低水平人员带来的风险扩散 比如一个低水平的技术人员参与项目开发，为降低个人代码质量对整体项目的影响风险，
/// 一般的做法是“画地为牢”，只能在指定的子系统中开发，然后再提供门面接口进行访问操作。
///

abstract class ILetterProcess {
  void writeContext(String context);

  void fillEnvelope(String address);

  void letterInotoEnvelope();

  void sendLetter();
}

class LetterProcessImpl implements ILetterProcess {
  @override
  void writeContext(String context) {
    print("填写信的内容..." + context);
  }

  @override
  void fillEnvelope(String address) {
    print("填写收件人地址及姓名..." + address);
  }

  @override
  void letterInotoEnvelope() {
    print("°把信放到信封中...");
  }

  @override
  void sendLetter() {
    print("邮递信件...");
  }
}

class Police {
  void checkLetter(ILetterProcess letterProcess) {
    print("$letterProcess +信件已经检查过了...");
  }
}

class ModenPostOffice {
  ILetterProcess letterProcess = LetterProcessImpl();
  Police letterPolice = Police();

  void sendLetter(String context, String address) {
    letterProcess.writeContext(context);
    letterProcess.fillEnvelope(address);
    letterPolice.checkLetter(letterProcess);
    letterProcess.letterInotoEnvelope();
    letterProcess.sendLetter();
  }
}

/// 我们来看一下门面模式的通用源码，=======
///
///
///

class ClassA {
  void doSomethingA() {}
}

class ClassB {
  void doSomethingB() {}
}

class ClassC {
  void doSomethingC() {}
}

class Facade {
  ClassA a = ClassA();
  ClassB b = ClassB();
  ClassC c = ClassC();

  void methodA() {
    a.doSomethingA();
  }

  void methodB() {
    b.doSomethingB();
  }

  void methodC() {
    c.doSomethingC();
  }
}
///一个子系统可以有多个门面
///增加的门面非常简单，委托给了已经存在的门面对象Facade进行处理，为什么要使用委
/// 托而不再编写一个委托到子系统的方法呢？那是因为在面向对象的编程中，尽量保持相同的
/// 代码只编写一遍，避免以后到处修改相似代码的悲剧。
 class Facade2 {
  Facade facade =  Facade();


 void methodB(){
   facade.methodB();
  }
}
///门面不参与子系统内的业务逻辑
///假如methodC要先调用A不应该直接把业务逻辑加在门面里
//	public void methodC(){
// 		this.a.doSomethingA();
// 		this.c.doSomethingC();
// 	}

 class Context {
 ClassA a =  ClassA();
 ClassC c =  ClassC();
 void complexMethod(){
  a.doSomethingA();
  c.doSomethingC();
  }
}

//  void methodC(){
//   context.complexMethod();
// }

///通过这样一次封装后，门面对象又不参与业务逻辑了
///，在门面模式中，门面角色应该是稳定，它不应该经常变化，
///一个系统一旦投入运行它就不应该被改变