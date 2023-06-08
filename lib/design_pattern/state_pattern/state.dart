///状态模式
///当一个对象内在状态改变时允许其改变行为，这个对象看起来像改变了其类
///状态模式的核心是封装，状态的变更引起了行为的变更，
///从外部看起来就好像这个对象 对应的类发生了改变一样
///状态模式的优点 ● 结构清晰 避免了过多的switch...case或者if...else语句的使用，
///避免了程序的复杂性,提高系统的可 维护性。● 遵循设计原则 很好地体现了开闭原则和单一职责原则
///，每个状态都是一个子类，你要增加状态就要增 加子类，你要修改状态，你只修改一个子类就可以了。
/// ● 封装性非常好 这也是状态模式的基本要求，状态变换放置到类的内部来实现，外部的调用不用知道类内部如何实现状态和行为的变换
///
///
/// 状态模式的缺点
/// 状态模式既然有优点，那当然有缺点了。但只有一个缺点，子类会太多，
///也就是类膨胀。如果一个事物有很多个状态也不稀奇，如果完全使用状态模式就会有太多的子类
///不好管理，这个需要大家在项目中自己衡量。其实有很多方式可以解决这个状态问题，
///如在数据库中建立一个状态表，然后根据状态执行相应的操作，这个也不复杂，看大家的习惯和嗜好了。
///
///
/// 状态模式的使用场景
/// ● 行为随状态改变而改变的场景 这也是状态模式的根本出发点，例如权限设计，
/// 人员的状态不同即使执行相同的行为结 果也会不同，在这种情况下需要考虑使用状态模式。
/// ● 条件、分支判断语句的替代者 在程序中大量使用switch语句或者if判断语句会导致程序结构不清晰，
/// 逻辑混乱使用状态模式可以很好地避免这一问题，它通过扩展子类实现了条件的判断处理。
///
///
/// 状态模式的注意事项
/// 状态模式适用于当某个对象在它的状态发生改变时，它的行为也随着发生比较大的变化，
/// 也就是说在行为受状态约束的情况下可以使用状态模式，而且使用时对象的状态最好不要超过5个。
///
///

abstract class LiftState {
  late Context context;

  void setContext(Context _context) {
    context = _context;
  }

  void open();

  void close();

  void run();

  void stop();
}

class ClosingState extends LiftState {
  @override
  void close() {
    print("电梯门关闭");
  }

  @override
  void open() {
    super.context.setLiftState(Context.openningState);
    super.context.getLiftState().open();
  }

  @override
  void run() {
    super.context.setLiftState(Context.runningState);
    super.context.getLiftState().run();
  }

  @override
  void stop() {
    super.context.setLiftState(Context.stoppingState);
    super.context.getLiftState().stop();
  }
}


 class OpenningState extends LiftState {

@override
  void close() {
    super.context.setLiftState(Context.closeingState);
    super.context.getLiftState().close();
  }


@override
  void open() {
  print("电梯门开启");
  }

 @override
  void run() {
    //do nothing;
  }

 @override
  void stop() {
    //do nothing;
  }

}
 class RunningState extends LiftState {

 @override
  void close() {
    //do nothing
  }

 @override
  void open() {
    //do nothing
  }

 @override
  void run() {
  print("电梯正在运行");
  }

@override
  void stop() {
    super.context.setLiftState(Context.stoppingState); //
    super.context.getLiftState().stop();
  }

}
 class StoppingState extends LiftState {

 @override
  void close() {
    //do nothing;
  }

   @override
  void open() {
    super.context.setLiftState(Context.openningState);
    super.context.getLiftState().open();
  }

 @override
  void run() {
    super.context.setLiftState(Context.runningState);
    super.context.getLiftState().run();
  }

  @override
  void stop() {
   print("电梯停止");
  }

}

class Context {
  static OpenningState openningState = OpenningState();
  static ClosingState closeingState = ClosingState();
  static RunningState runningState = RunningState();
  static StoppingState stoppingState = StoppingState();

  late LiftState liftState;

  LiftState getLiftState() {
    return liftState;
  }

  void setLiftState(LiftState liftState) {
    this.liftState = liftState;

    this.liftState.setContext(this);
  }

  void open() {
    liftState.open();
  }

  void close() {
    liftState.close();
  }

  void run() {
    liftState.run();
  }

  void stop() {
    liftState.stop();
  }
}
