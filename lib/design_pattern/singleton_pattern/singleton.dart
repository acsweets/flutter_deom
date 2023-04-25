import 'dart:math';

///单例模式
///要求一个类只能生成一个对象（皇帝），所有对象对它的依赖都是相同的
///因为只有一个对象，大家对它的脾气和习性都非常了解，建立健壮稳固的关系
///我们把皇帝这种特 殊职业通过程序来实现。
///确保某一个类 只有一个实例，而且自行实例化并向整个系统提供这个实例。）
///
//皇帝只有一个
// class Emperor {
//   static final Emperor emperor = Emperor();
//
//   Emperor();
//
//   static Emperor getInstance() {
//     return emperor;
//   }

 void say() {
    print("皇帝说===");
  }

///大臣类
class Minister {

  void seeEmperor() {
    for (int day = 0; day < 3; day++) {
      Emperor.say();
    }
  }
}
//皇帝最多两个
class Emperor {
  // 定义能产生的最大实例数量
  static int maxNumOfEmperor = 2;
  // 存储每个皇帝的姓名，使用List保存实例变量，每个对象的属性
  static List<String> nameList = [];
  // 存储皇帝实例，使用List保存对象
  static List<Emperor> emperorList = [];
  // 当前皇帝编号
  static int countNumOfEmperor = 0;


  // 无参构造函数，构造函数私有化，禁止使用new创建对象
  Emperor._();

  // 构造函数，使用私有化构造函数确保只能通过类的静态方法获取皇帝对象，传入皇帝姓名，添加到nameList列表中
  Emperor(String name) {
  nameList.add(name);
  }

  // 随机获取一个皇帝实例
  static Emperor getInstance() {
    for (int i = 0; i < maxNumOfEmperor; i++) {
      emperorList.add(Emperor("第${i + 1}任皇帝"));
    }
  var random = Random();
  countNumOfEmperor = random.nextInt(maxNumOfEmperor);
  return emperorList[countNumOfEmperor];
  }

  // 获取指定编号的皇帝实例
  static Emperor getInstanceByNum(int i) {
  return emperorList[i];
  }

  // 皇帝发话了
  static void say() {
  print(nameList[countNumOfEmperor]);
  }
}


///使用Dart的类定义语法来定义Singleton类。
///我们使用一个私有的构造函数来防止外部实例化Singleton类。
///同时，我们定义了一个静态成员变量_singleton来保存Singleton的唯一实例。
///在getSingleton方法中，我们直接返回了这个静态成员变量，从而保证了Singleton的唯一性。
/// 此外，我们也可以在Singleton类中定义静态方法，这些静态方法可以通过类名直接调用。
class Singleton {

  static final Singleton _singleton = Singleton._internal();

  Singleton._internal();

  static Singleton getSingleton() {
    return _singleton;
  }

  static void doSomething() {
    // do something
  }
}




