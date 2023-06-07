///访问者模式
///封装一些作用于某种 数据结构中的各元素的操作，它可以在不改变数据结构的前提下定义作用于这些元素的新的操作
///● Visitor——抽象访问者 抽象类或者接口，声明访问者可以访问哪些元素，具体到程序中就是visit方法的参数定 义哪些对象是可以被访问的。
/// ● ConcreteVisitor——具体访问者 它影响访问者访问到一个类后该怎么干，要做什么事情。
/// ● Element——抽象元素 接口或者抽象类，声明接受哪一类访问者访问，程序上是通过accept方法中的参数来定义的。
/// ● ConcreteElement——具体元素 实现accept方法，通常是visitor.visit(this)，基本上都形成了一种模式了。
/// ● ObjectStruture——结构对象 元素产生者，一般容纳在多个不同类、不同接口的容器，如List、Set、Map等，在项目中，
/// 一般很少抽象出这个角色。 大家可以这样理解访问者模式，我作为一个访客（Visitor）到朋友家（Visited Class）去 拜访，
/// 朋友之间聊聊天，喝喝酒，再相互吹捧吹捧，炫耀炫耀，这都正常。聊天的时候，朋 友告诉我，他今年加官晋爵了，工资也涨了30%，
/// 准备再买套房子，那我就在心里盘算 （Visitor-self-method）“你这么有钱，我去年要借10万你都不借”，我根据朋友的信息，执行
/// 了自己的一个方法
///
///
///
///
///访问者模式的优点
/// ● 符合单一职责原则 具体元素角色也就是Employee抽象类的两个子类负责数据的加载，而Visitor类则负责报 表的展现，
/// 两个不同的职责非常明确地分离开来，各自演绎变化。 ● 优秀的扩展性 由于职责分开，继续增加对数据的操作是非常快捷的，
/// 例如，现在要增加一份给大老板的报表，这份报表格式又有所不同，直接在Visitor中增加一个方法，传递数据后进行整理打印。
/// ● 灵活性非常高 例如，数据汇总，就以刚刚我们说的Employee的例子，如果我现在要统计所有员工的工资之和，
/// 怎么计算？把所有人的工资for循环加一遍？是个办法，那我再提个问题，员工工资 ×1.2，部门经理×1.4，总经理×1.8
/// ，然后把这些工资加起来，你怎么处理？1.2，1.4，1.8是什 么？不是吧？！你没看到领导不论什么时候都比你拿得多，
/// 工资奖金就不说了，就是过节发个慰问券也比你多，就是这个系数在作祟。我们继续说你想怎么统计？使用for循环，
/// 然后使 用instanceof来判断是员工还是经理？这可以解决，但不是个好办法，好办法是通过访问者模式来实现，
/// 把数据扔给访问者，由访问者来进行统计计算。
///
///  访问者模式的缺点
///
/// ● 具体元素对访问者公布细节访问者要访问一个类就必然要求这个类公布一些方法和数据，
/// 也就是说访问者关注了其他类的内部细节，这是迪米特法则所不建议的。
/// ● 具体元素变更比较困难 具体元素角色的增加、删除、修改都是比较困难的，就上面那个例子，你想想你要是想增加一个成员变量，
/// 如年龄age，Visitor就需要修改，如果Visitor是一个还好办，多个呢？ 业务逻辑再复杂点呢？
/// ● 违背了依赖倒置转原则 访问者依赖的是具体元素，而不是抽象元素，这破坏了依赖倒置原则，特别是在面向对象的编程中，
/// 抛弃了对接口的依赖，而直接依赖实现类，扩展比较难。
///
///
///  访问者模式的使用场景
///
///
/// ● 一个对象结构包含很多类对象，它们有不同的接口，而你想对这些对象实施一些依赖于其具体类的操作，
/// 也就说是用迭代器模式已经不能胜任的情景。
/// ● 需要对一个对象结构中的对象进行很多不同并且不相关的操作，
/// 而你想避免让这些操 作“污染”这些对象的类。
/// 总结一下，在这种地方你一定要考虑使用访问者模式：业务规则要求遍历多个不同的对象。
/// 这本身也是访问者模式出发点，迭代器模式只能访问同类或同接口的数据（
/// 当然了，如果你使用instanceof，那么能访问所有的数据，这没有争论）
/// 而访问者模式是对迭代器模式的扩充，可以遍历不同的对象，然后执行不同的操作，也就是针对访问的对象不同，
/// 执行不同的操作。访问者模式还有一个用途，就是充当拦截器（Interceptor）角色，这个我们将在 混编模式中讲解。
///
///
// abstract class Employee {
//   static int male= 0; //男
//   static int female = 1; //女
//   late String name;
//
//   late int salary;
//
//   late int sex;
//
//   String getName() {
//     return name;
//   }
//
//   void setName(String name) {
//     this.name = name;
//   }
//
//   int getSalary() {
//     return salary;
//   }
//
//   void setSalary(int salary) {
//     this.salary = salary;
//   }
//
//   int getSex() {
//     return sex;
//   }
//
//   void setSex(int sex) {
//     this.sex = sex;
//   }
//
//   void report() {
//     String info = "姓名：" + name + "\t";
//     info = info + "性别：" + (sex == female ? "女" : "男") + "\t";
//     info = info + "薪水：" + "$salary" + "\t";
//     //获得员工的其他信息
//     info = info + getOtherInfo();
//     print(info);
//   }
//
//   String getOtherInfo();
// }
//
// class CommonEmployee extends Employee {
//   late String job;
//
//   String getJob() {
//     return job;
//   }
//
//   void setJob(String job) {
//     this.job = job;
//   }
//
//   @override
//   String getOtherInfo() {
//     return "工作" + job + "\t";
//   }
// }
//
// class Manager extends Employee {
//   late String performance;
//
//   String getPerformance() {
//     return performance;
//   }
//
//   void setPerformance(String performance) {
//     this.performance = performance;
//   }
//
//   @override
//   String getOtherInfo() {
//     return "工作情况" + performance + "\t";
//   }
// }
///我们来想一想，每个普通员工类和经理类都用一个方法 report（从父类继承过来的），他无法为每一个子类定制特殊的属性
///我们思考一下，如何提供一个能够为每个子类定制报表的方法呢？可以这样思考，普通 员工和管理层员工是两个不同的对象，
///例如，我邀请一个人过来参观我的家，参观者参观完 毕后分别进行描述，那参观的对象不同，描述的结果也当然不同。
///好，按照这思路，我们把 方法report提取到另外一个类Visitor中来实现
///


abstract class Employee {
 static int male = 0;
static int female = 1;

 late String name;
 late int salary;
 late int sex;


 String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

 int getSalary() {
    return salary;
  }

 void setSalary(int salary) {
    this.salary = salary;
  }

int getSex() {
    return sex;
  }

 void setSex(int sex) {
    this.sex = sex;
  }

  void accept(IVisitor visitor);
}
class CommonEmployee extends Employee {

 late String job;

  String getJob() {
    return job;
  }

 void setJob(String job) {
    this.job = job;
  }

 @override
  void accept(IVisitor visitor){
   visitor.visitEmployee(this);
  }

}

 class Manager extends Employee {

 late String performance;

 String getPerformance() {
    return performance;
  }

 void setPerformance(String performance) {
    this.performance = performance;
  }

 @override
  void accept(IVisitor visitor){
    visitor.visitManager(this);
  }
}

//区分不同的访问者
abstract class IVisitor {

 void visitEmployee(CommonEmployee commonEmployee);

 void visitManager(Manager manager);

 int getTotalSalary();

}
///第一，通过循环遍历所有元素。
///● 第二，每个员工对象都定义了一个访问者。
///● 第三，员工对象把自己作为一个参数调用访问者visit方法。
///● 第四，访问者调用自己内部的计算逻辑，计算出相应的数据和表格元素。
///● 第五，访问者打印出报表和数据。
 class Visitor implements IVisitor {
  static int _MANAGER_COEFFICIENT = 5;

 static int _COMMONEMPLOYEE_COEFFICIENT = 2;

   int _commonTotalSalary = 0;

   int _managerTotalSalary =0;


 @override
  void visitEmployee(CommonEmployee commonEmployee) {
    print(getCommonEmployee(commonEmployee));
    calCommonSlary(commonEmployee.getSalary());
  }

 @override
  void visitManager(Manager manager) {
    print(getManagerInfo(manager));
    calManagerSalary(manager.getSalary());
  }

  String getBasicInfo(Employee employee){
    String info = "姓名：" + employee.getName() + "\t";
    info = info + "性别：" + (employee.getSex() == Employee.female?"女":"男") + "\t";
    info = info + "薪水：" + "${employee.getSalary()}" + "\t";

    return info;
  }
//经理
 String getManagerInfo(Manager manager){
    String basicInfo = getBasicInfo(manager);
    String otherInfo = "业绩："+manager.getPerformance() + "\t";
    return basicInfo + otherInfo;
  }
//普通员工
 String getCommonEmployee(CommonEmployee commonEmployee){
    String basicInfo = getBasicInfo(commonEmployee);
    String otherInfo = "工作："+commonEmployee.getJob()+"\t";
    return basicInfo + otherInfo;
  }


    void calManagerSalary(int salary){
     _managerTotalSalary = _managerTotalSalary + salary *_MANAGER_COEFFICIENT ;
   }

    void calCommonSlary(int salary){
   _commonTotalSalary = -_commonTotalSalary + salary*_COMMONEMPLOYEE_COEFFICIENT;
   }

   @override
  int getTotalSalary(){
     return _commonTotalSalary + _managerTotalSalary;
   }
}
