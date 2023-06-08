///我们先来看看状态模式中的3个角色。 ● State——抽象状态角色
/// 接口或抽象类，负责对象状态定义，并且封装环境角色以实现状态切换。
/// ● ConcreteState——具体状态角色 每一个具体状态必须完成两个职责：本状态的行为管理以及趋向状态处理，
/// 通俗地说，就是本状态下要做的事情，以及本状态如何过渡到其他状态。
/// ● Context——环境角色 定义客户端需要的接口，并且负责具体状态的切换。
/// 状态模式相对来说比较复杂，它提供了一种对物质运动的另一个观察视角，通过状态变 更促使行为的变化
/// ，就类似水的状态变更一样，一碗水的初始状态是液态，通过加热转变为 气态，状态的改变同时也引起体积的扩大，
/// 然后就产生了一个新的行为：鸣笛或顶起壶盖， 瓦特就是这么发明蒸汽机的。我们再来看看状态模式的通用源代码
///
///

///
class Context {
  static State STATE1 = ConcreteState1();
  static State STATE2 = ConcreteState2();

  late State CurrentState;

  State getCurrentState() {
    return CurrentState;
  }

  void setCurrentState(State currentState) {
    CurrentState = currentState;
    CurrentState.setContext(this);
  }

  void handle1() {
    CurrentState.handle1();
  }

  void handle2() {
    CurrentState.handle2();
  }
}
///抽象的状态，有两个状态
abstract class State {
  late Context context;

  void setContext(Context _context) {
    context = _context;
  }

  void handle1();

  void handle2();
}

class ConcreteState2 extends State {
  @override

  //切换到这个状态
  void handle1() {
    super.context.setCurrentState(Context.STATE1);
    super.context.handle1();
  }

  @override
  void handle2() {}
}

class ConcreteState1 extends State {
  @override
  void handle1() {}

  @override
  void handle2() {
    super.context.setCurrentState(Context.STATE2);
    super.context.handle2();
  }
}

class Client {
  static void test() {
    Context context = Context();
    context.setCurrentState(ConcreteState1());
    context.handle1();
    context.handle2();
  }
}
