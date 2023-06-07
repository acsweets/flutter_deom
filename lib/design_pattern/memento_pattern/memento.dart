///备忘录模式
///提供了一种弥补真实世界缺陷的方法，让“后悔药”在程序的世界中真实可行，
///在不破坏封装性的前提下，捕获一个对象的内部状 态，并在该对象之外保存这个状态。
///这样以后就可将该对象恢复到原先保存的状态。
///备忘录模式就是一个对象的备份模式，提供了一种程序数据的备份方法
///
///

class Boy {
  String state = "";

  void changeState() {
    state = "心情不好";
  }

  String getState() {
    return state;
  }

  void setState(String state) {
    this.state = state;
  }

  Memento createMemento() {
    return Memento(state);
  }

  void restoreMemento(Memento _memento) {
    setState(_memento.getState());
  }
}

class Memento {
  String state = "";

  Memento(String _state) {
    state = _state;
  }

  String getState() {
    return state;
  }

  void setState(String state) {
    this.state = state;
  }
}

class Caretaker {
  late Memento memento;

  Memento getMemento() {
    return memento;
  }

  void setMemento(Memento memento) {
    this.memento = memento;
  }
}

///
///
///三个角色。
///● Originator发起人角色 记录当前时刻的内部状态，负责定义哪些属于备份范围的状态，负责创建和恢复备忘录数据。
///● Memento备忘录角色 负责存储Originator发起人对象的内部状态，在需要的时候提供发起人需要的内部状态。
///● Caretaker备忘录管理员角色对备忘录进行管理、保存和提供备忘录。
///通用模板
///
///

//备忘录
class Memento1 {
  String state = "";

  Memento1(String _state) {
    state = _state;
  }

  String getState() {
    return state;
  }

  void setState(String state) {
    this.state = state;
  }
}

///管理者
class Caretaker1 {
  late Memento1 memento;

  Memento1 getMemento() {
    return memento;
  }

  void setMemento(Memento1 memento) {
    this.memento = memento;
  }
}

 class Originator {
   String state = "";
 String getState() {
    return state;
  }

 void setState(String state) {
    this.state = state;
  }
 Memento1 createMemento(){
    return  Memento1(state);
  }

 void restoreMemento(Memento1 _memento){
    setState(_memento.getState());
  }
}

///由于备忘录模式有太多的变形和处理方式，每种方式都有它自己的优点和缺点，标准的备忘录模式很难在项目中遇到
///，基本上都有一些变换处理方式。因此，我们在使用备忘录模 式时主要了解如何应用以及需要注意哪些事项就成了。
///
///备忘录模式的使用场景
/// ● 需要保存和恢复数据的相关状态场景。
/// ● 提供一个可回滚（rollback）的操作；比如Word中的CTRL+Z组合键，IE浏览器中的后退按钮，文件管理器上的backspace键等。
/// ● 需要监控的副本场景中。例如要监控一个对象的属性，但是监控又不应该作为系统的 主业务来调用，它只是边缘应用，
/// 即使出现监控不准、错误报警也影响不大，因此一般的做 法是备份一个主线程中的对象，然后由分析程序来分析。
/// ● 数据库连接的事务管理就是用的备忘录模式，想想看，如果你要实现一个JDBC驱 动，你怎么来实现事务？还不是用备忘录模式嘛！
///
///
/// 备忘录模式的注意事项
/// ● 备忘录的生命期 备忘录创建出来就要在“最近”的代码中使用，要主动管理它的生命周期，建立就要使用，
/// 不使用就要立刻删除其引用，等待垃圾回收器对它的回收处理。
/// ● 备忘录的性能 不要在频繁建立备份的场景中使用备忘录模式（比如一个for循环中），
///
/// 原因有二：
/// 一是控制不了备忘录建立的对象数量；
/// 二是大对象的建立是要消耗资源的，系统的性能需要考虑。
///
///
/// 扩展
///  clone方式的备忘录

///我们可以通过复制的方式产生一个对象的内部 状态，这是一个很好的办法
///，发起人角色只要实现Cloneable就成
///发起人角色融合了发起人角色和备忘录角色，具有双重功效，
///
///
///
