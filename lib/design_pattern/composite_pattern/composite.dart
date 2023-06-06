///定义
///将对象组合成树形结构以表 示“部分-整体”的层次结构，使得用户对单个对象和组合对象的使用具有一致性。
///● Component抽象构件角色 定义参加组合对象的共有方法和属性，可以定义一些默认的行为或属性
///比如我们例子中的getInfo就封装到了抽象类中。
///● Leaf叶子构件 叶子对象，其下再也没有其他的分支，也就是遍历的最小单位。
/// ● Composite树枝构件 树枝对象，它的作用是组合树枝节点和叶子节点形成一个树形结构
///
///组合模式的优点
///● 高层模块调用简单 一棵树形机构中的所有节点都是Component，局部和整体对调用者来说没有任何区别，
///也就是说，高层模块不必关心自己处理的是单个对象还是整个组合结构，简化了高层模块的代码。
///● 节点自由增加 使用了组合模式后，我们可以看看，如果想增加一个树枝节点、树叶节点是不是都很容易，
///只要找到它的父节点就成，非常容易扩展，符合开闭原则，对以后的维护非常有利。
///
///组合模式的缺点 组合模式有一个非常明显的缺点，看到我们在场景类中的定义，提到树叶和树枝使用时的定义了吗？
///直接使用了实现类！这在面向接口编程上是很不恰当的，与依赖倒置原则冲突，读者在使用的时候要考虑清楚，
///它限制了你接口的影响范围。 21.3.3 组合模式的使用场景 ● 维护和展示部分-整体关系的场景
///，如树形菜单、文件和文件夹管理。 ● 从一个整体中能够独立出部分模块或功能的场景。
///
/// 组合模式的注意事项
/// 只要是树形结构，就要考虑使用组合模式，这个一定要记住，
/// 只要是要体现局部和整体的关系的时候，而且这种关系还可能比较深，考虑一下组合模式吧。
///

// abstract class ILeaf {
//   String getInfo();
// }
//
// abstract class IRoot {
//   String getInfo();
//
//   // 增加数据节点，例如发展下方的发展一组
//   void add(IBranch branch);
//
//   // 增加子节点
//   void addLeaf(ILeaf leaf);
//
//   // 获取下级信息
//   List getSubordinateInfo();
// }
//
// abstract class IBranch {
//   // 增加数据节点，例如发展下方的发展一组
//   String getInfo();
//
//   void add(IBranch branch);
//
// // 增加子节点
//   void addLeaf(ILeaf leaf);
//
// // 获取下级信息
//   List getSubordinateInfo();
// }
// class Root implements IRoot {
//   //存储子节点的信息
//   final List subordinateList = [];
//
//   final String name;
//
//   final String position;
//
//   final int salary;
//
//   Root({
//     this.name = "",
//     this.position = "",
//     this.salary = 0,
//   });
//
//   @override
//   void add(IBranch branch) {
//     subordinateList.add(branch);
//   }
//
//   @override
//   void addLeaf(ILeaf leaf) {
//     subordinateList.add(leaf);
//   }
//
//   @override
//   String getInfo() {
//     String info = "";
//     info = "名称：" + name;
//     info = info + "\t职位：º" + position;
//     info = info + "\t薪水º" + '$salary';
//     return info;
//   }
//
//   @override
//   List getSubordinateInfo() {
//     return subordinateList;
//   }
// }
//
// //得到下级的信息 public ArrayList getSubordinateInfo() { return this.subordinateList; } }
// class Branch implements IBranch {
//   //存储子节点的信息
//   final List subordinateList = [];
//
//   final String name;
//
//   final String position;
//
//   final int salary;
//
//   Branch({
//     this.name = "",
//     this.position = "",
//     this.salary = 0,
//   });
//
//   @override
//   void add(IBranch branch) {
//     subordinateList.add(branch);
//   }
//
//   @override
//   void addLeaf(ILeaf leaf) {
//     subordinateList.add(leaf);
//   }
//
//   @override
//   String getInfo() {
//     String info = "";
//     info = "名称：" + name;
//     info = info + "\t职位：º" + position;
//     info = info + "\t薪水º" + '$salary';
//     return info;
//   }
//
//   @override
//   List getSubordinateInfo() {
//     return subordinateList;
//   }
// }
//
// class Leaf implements ILeaf {
//   //叶子叫什么名字
//   final String name;
//
//   // 叶子的职位
//   final String position;
//
// // 叶子的薪水
//   final int salary;
//
//   //通过构造函数传递信息
//   Leaf({
//     this.name = "",
//     this.position = "",
//     this.salary = 0,
//   });
//
//   //最小的小兵只能获得自己的信息了
//
//
//   @override
//   String getInfo() {
//     String info = "";
//     info = "名称：" + name;
//     info = info + "\t职位：" +position;
//     info = info + "\t薪水：" + "$salary";
//     return info;
//   }
// }
//

//  class Client {
// static void main() {
//   //首先产生了一个根节点
//  IRoot ceo = Root(name: "王大麻子",position: "总经理",salary: 100000);
//  //产生三个部门经理，也就是树枝节点
//  IBranch developDep =  Branch(name: "刘大瘸子",position: "研发部门经理",salary: 10000);
//  IBranch salesDep = Branch(name: "马二拐子",position: "销售部门经理",salary: 20000);
//  IBranch financeDep =  Branch(name: "赵三驼子",position: "财务部经理",salary: 30000);
//  //再把三个小组长产生出来
//  IBranch firstDevGroup =  Branch(name: "杨三乜斜",position: "开发一组组长",salary: 5000);
//  IBranch secondDevGroup =  Branch(name: "吴大棒槌",position: "开发二组组长",salary: 6000);
//  //剩下的就是我们这些小兵了,就是路人甲、路人乙
//  ILeaf a =  Leaf(name: "a",position: "开发人员",salary: 2000);
//  ILeaf b =  Leaf(name:"b",position:"开发人员",salary: 2000);
//  ILeaf c =  Leaf(name:"c",position:"开发人员",salary: 2000);
//  ILeaf d =  Leaf(name:"d",position:"开发人员",salary: 2000);
//  ILeaf e =  Leaf(name:"e",position:"开发人员",salary: 2000);
//  ILeaf f =  Leaf(name:"f",position:"开发人员",salary: 2000);
//  ILeaf g =  Leaf(name:"g",position:"开发人员",salary: 2000);
//  ILeaf h =  Leaf(name:"h",position:"销售人员",salary: 5000);
//  ILeaf i =  Leaf(name:"i",position:"销售人员",salary: 4000);
//  ILeaf j =  Leaf(name:"j",position:"财务人员",salary: 5000);
//  ILeaf k =  Leaf(name:"k",position:"CEO秘书",salary: 8000);
//  ILeaf zhengLaoLiu =  Leaf(name: "郑老六",position: "研发部副总",salary: 20000); //该产生的人都产生出来了，然后我们怎么组装这棵树 //首先是定义总经理下有三个部门经理 ceo.add(developDep); ceo.add(salesDep); ceo.add(financeDep); //总经理下还有一个秘书 ceo.add(k); //定义研发部门下的结构 developDep.add(firstDevGroup); developDep.add(secondDevGroup); //研发部经理下还有一个副总 developDep.add(zhengLaoLiu); //看看开发两个开发小组下有什么 firstDevGroup.add(a); firstDevGroup.add(b); firstDevGroup.add(c); secondDevGroup.add(d); secondDevGroup.add(e); secondDevGroup.add(f); //再看销售部下的人员情况 salesDep.add(h); salesDep.add(i); //最后一个财务 financeDep.add(j); //打印写完的树状结构
//   print(ceo.getInfo());
//  //该产生的人都产生出来了，然后我们怎么组装这棵树
// // 首先是定义总经理下有三个部门经理
//   ceo.add(developDep);
//   ceo.add(salesDep);
//   ceo.add(financeDep);
//   //总经理下还有一个秘书
//   developDep.add(firstDevGroup);
//   developDep.add(secondDevGroup);
//
// }
// }

abstract class ICorp {
  String getInfo();
}

abstract class IBranch {
  void addSubordinate(ICorp corp);

  List<ICorp> getSubordinate();
}

abstract class ILeaf extends ICorp {}

class Leaf implements ILeaf {
  final String name;

  final String position;

  final int salary;

  Leaf({this.name = "", this.position = "", this.salary = 0});

  @override
  String getInfo() {
    String info = "";
    info = "名字：" + name;
    info = info + "\t职位：" + position;
    info = info + "\t工资：" + '$salary';
    return info;
  }
}

class Branch implements IBranch, ICorp {
  final String name;

  final String position;

  final int salary;

  List<ICorp> subordinateList = [];

  Branch({this.name = "", this.position = "", this.salary = 0});

//属于添加子节点
  @override
  void addSubordinate(ICorp corp) {
    subordinateList.add(corp);
  }

  // 得到子节点
  @override
  List<ICorp> getSubordinate() {
    return subordinateList;
  }

  String getInfo() {
    String info = "";
    info = "名字:" + name;
    info = info + "\t职位:" + position;
    info = info + "\t工资:" + '$salary';
    return info;
  }
}

class Client {
  static Branch compositeCorpTree() {
    Branch root = Branch(name: "刘二瘸子", position: "总经理", salary: 10000);

    Branch developDep = Branch(name: "刘大瘸子", position: "研发部门经理", salary: 10000);
    Branch salesDep = Branch(name: "马二拐子", position: "销售部门经理", salary: 20000);
    Branch financeDep = Branch(name: "赵三驼子", position: "财务部经理", salary: 30000);

    Branch firstDevGroup = Branch(name: "杨三乜斜", position: "开发一组组长", salary: 5000);
    Branch secondDevGroup = Branch(name: "吴大棒槌", position: "开发二组组长", salary: 6000);

    Leaf a = Leaf(name: "a", position: "开发人员", salary: 2000);
    Leaf b = Leaf(name: "b", position: "开发人员", salary: 2000);
    Leaf c = Leaf(name: "c", position: "开发人员", salary: 2000);
    Leaf d = Leaf(name: "d", position: "开发人员", salary: 2000);
    Leaf e = Leaf(name: "e", position: "开发人员", salary: 2000);
    Leaf f = Leaf(name: "f", position: "开发人员", salary: 2000);
    Leaf g = Leaf(name: "g", position: "开发人员", salary: 2000);
    Leaf h = Leaf(name: "h", position: "销售人员", salary: 5000);
    Leaf i = Leaf(name: "i", position: "销售人员", salary: 4000);
    Leaf j = Leaf(name: "j", position: "财务人员", salary: 5000);
    Leaf k = Leaf(name: "k", position: "CEO秘书", salary: 8000);
    Leaf zhengLaoLiu = Leaf(name: "郑老六", position: "研发部副总", salary: 20000);

    root.addSubordinate(k);
    root.addSubordinate(developDep);
    root.addSubordinate(salesDep);
    root.addSubordinate(financeDep);

    developDep.addSubordinate(zhengLaoLiu);
    developDep.addSubordinate(firstDevGroup);
    developDep.addSubordinate(secondDevGroup);

    firstDevGroup.addSubordinate(a);
    firstDevGroup.addSubordinate(b);
    firstDevGroup.addSubordinate(c);
    secondDevGroup.addSubordinate(d);
    secondDevGroup.addSubordinate(e);
    secondDevGroup.addSubordinate(f);

    salesDep.addSubordinate(h);
    salesDep.addSubordinate(i);

    financeDep.addSubordinate(j);

    return root;
  }

  static String getTreeInfo(Branch root) {
    List<dynamic> subordinateList = root.getSubordinate();
    String info = "";
    for (dynamic s in subordinateList) {
      if (s is Leaf) {
        // 如果是叶子节点就直接获取信息
        info = info + s.getInfo() + "\n";
      } else {
        // 如果是一个分支节点
        //递归遍历
        info = info + s.getInfo() + "\n" + getTreeInfo(s);
      }
    }
    return info;
  }
}

///通用模板
///

abstract class Corp {
  final String name;

  final String position;

  final int salary;

  List<Corp> subordinateList = [];

  Corp({this.name = "", this.position = "", this.salary = 0});

  String getInfo() {
    String info = "";
    info = "名字:" + name;
    info = info + "\t职位:" + position;
    info = info + "\t工资:" + '$salary';
    return info;
  }
}
//叶子
class Lea extends Corp {
  Lea(String _name, String _position, int _salary)
      : super(
          name: _name,
          position: _position,
          salary: _salary,
        );
}

//结点
 class Branc extends Corp {

    @override
     List<Corp> subordinateList = [];

    Branc(String _name, String _position, int _salary)
        : super(
      name: _name,
      position: _position,
      salary: _salary,
    );


    void addSubordinate(Corp corp) {
      subordinateList.add(corp);
    }

    List<Corp> getSubordinate() {
      return subordinateList;
    }
  }

///场景类实现子节点的添加以及遍历
//static Branch compositeCorpTree()
//static String getTreeInfo(Branch root) {
//     List<dynamic> subordinateList = root.getSubordinate();
//     String info = "";
//     for (dynamic s in subordinateList) {
//       if (s is Leaf) {
//         // 如果是叶子节点就直接获取信息
//         info = info + s.getInfo() + "\n";
//       } else {
//         // 如果是一个分支节点
//         //递归遍历
//         info = info + s.getInfo() + "\n" + getTreeInfo(s);
//       }
//     }
//     return info;
//   }


