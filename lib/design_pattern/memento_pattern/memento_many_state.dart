///  多状态的备忘录模式
///  增加了一个BeanUtils类，其中backupProp是把发起人的所有属性值转换到HashMap中，
///  方便备忘录角色存储；restoreProp方法则是把HashMap中的值返回到 发起人角色中。可能各位要说了
///  ，为什么要使用HashMap，直接使用Originator对象的拷贝不 是一个很好的方法吗？可以这样做，
///  你就破坏了发起人的通用性，你在做恢复动作的时候需要对该对象进行多次赋值操作，也容易产生错误。

class Memento {
  late final Map<String, Object> stateMap;

  Memento({
    required this.stateMap,
  });

  Map<String, Object> getStateMap() {
    return stateMap;
  }

  void setStateMap(Map<String, Object> stateMap) {
    this.stateMap = stateMap;
  }
}

class BeanUtils {
  //备份方法
  static Map<String, Object> backupProp(Object bean) {
    Map<String, Object> result = {};
    try {
      // //»ñµÃBeanÃèÊö
      // BeanInfo beanInfo = Introspector.getBeanInfo(bean.getClass());
      // //»ñµÃÊôÐÔÃèÊö
      // PropertyDescriptor[] descriptors = beanInfo.getPropertyDescriptors();
      // //±éÀúËùÓÐÊôÐÔ
      // for(PropertyDescriptor des:descriptors){
      //   //ÊôÐÔÃû³Æ
      //   String fieldName = des.getName();
      //   //¶ÁÈ¡ÊôÐÔµÄ·½·¨
      //   Method getter = des.getReadMethod();
      //   //¶ÁÈ¡ÊôÐÔÖµ
      //   Object fieldValue = getter.invoke(bean, new Object[]{});
      //   if(!fieldName.equalsIgnoreCase("class")){
      //     result.put(fieldName, fieldValue);
      //   }
      // }
      return result;
    } catch (e) {}
    return result;
  }

//恢复方法
  static void restoreProp(Object bean, Map<String, Object> propMap) {
    try {
      // //»ñµÃBeanÃèÊö
      // BeanInfo beanInfo = Introspector.getBeanInfo(bean.getClass());
      // //»ñµÃÊôÐÔÃèÊö
      // PropertyDescriptor[] descriptors = beanInfo.getPropertyDescriptors();
      // //±éÀúËùÓÐÊôÐÔ
      // for(PropertyDescriptor des:descriptors){
      //   //ÊôÐÔÃû³Æ
      //   String fieldName = des.getName();
      //   //Èç¹ûÓÐÕâ¸öÊôÐÔ
      //   if(propMap.containsKey(fieldName)){
      //     //Ð´ÊôÐÔµÄ·½·¨
      //     Method setter = des.getWriteMethod();
      //     setter.invoke(bean, new Object[]{propMap.get(fieldName)});
      //   }
      // }
    } catch (e) {
      //Òì³£´¦Àí
      print("shit");
      // e.printStackTrace();
    }
  }
}

class BeanInfo {}

class Originator {
  String state1 = "";
  String state2 = "";
  String state3 = "";

  String getState1() {
    return state1;
  }

  void setState1(String state1) {
    this.state1 = state1;
  }

  String getState2() {
    return state2;
  }

  void setState2(String state2) {
    this.state2 = state2;
  }

  String getState3() {
    return state3;
  }

  void setState3(String state3) {
    this.state3 = state3;
  }

  Memento createMemento() {
    return Memento(stateMap: BeanUtils.backupProp(this));
  }

  void restoreMemento(Memento _memento) {
    BeanUtils.restoreProp(this, _memento.getStateMap());
  }

  @override
  String toString() {
    return "state1=" + state1 + "\nstat2=" + state2 + "\nstate3=" + state3;
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

class Client {
  static void start() {
    Originator ori = Originator();

    Caretaker caretaker = Caretaker();

    ori.setState1("中国");
    ori.setState2("繁荣");
    ori.setState3("富强");
    print("===开始状态\n$ori");
    caretaker.setMemento(ori.createMemento());
    ori.setState1("民主");
    ori.setState2("有爱");
    ori.setState3("和谐");
    print("改变状态\n$ori");
    ori.restoreMemento(caretaker.getMemento());
    print("恢复状态\n$ori");
  }
}

/// 多备份的备忘录
///

abstract class IMemento1 {}

class Originator1 {
  String state = "";

  String getState() {
    return state;
  }

  void setState(String state) {
    this.state = state;
  }

  Memento1 createMemento() {
    return Memento1(state: state);
  }

  void restoreMemento(Memento1 _memento) {
      setState( _memento.getState() );
  }
}

class Memento1 implements IMemento1 {
 late final String state ;


  Memento1({this.state ="",});

  String getState() {
    return state;
  }

  void setState(String state) {
    this.state = state;
  }
}
