///状态模式
///当一个对象内在状态改变时允许其改变行为，这个对象看起来像改变了其 类
///状态模式的核心是封装，状态的变更引起了行为的变更，
///从外部看起来就好像这个对象 对应的类发生了改变一样

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
    super.context.setLiftState(Context.runningState); //ÉèÖÃÎªÔËÐÐ×´Ì¬£»
    super.context.getLiftState().run();
  }

  @override
  void stop() {
    super.context.setLiftState(Context.stoppingState); //ÉèÖÃÎªÍ£Ö¹×´Ì¬£»
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
