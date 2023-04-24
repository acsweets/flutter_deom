import 'dart:math';

///迪米特法则（Law of Demeter，LoD）也称为最少知识原则（Least Knowledge Principle，LKP），
///虽然名字不同，但描述的是同一个规则：一个对象应该对其他对象有最少的了解。
///通俗地讲，一个类应该对自己需要耦合或调用的类知道得最少，你（被耦合或调 用的类）的内部是如何复杂都和我没关系，
///那是你的事情，我就知道你提供的这么多public 方法，我就调用这么多，其他的我一概不关心。
///
/// 一个类公开的public属性或方法越多，
/// 修改时涉及的面也就越大，变更引起的风险扩散 也就越大。
/// 因此，为了保持朋友类间的距离，在设计时需要反复衡量：是否还可以再减少 public方法和属性，
/// 是否可以修改为private、package-private（包类型，在类、方法、变量前 不加访问权限，则默认为包类型）
/// 、protected等访问权限，是否可以加上final关键字等。
///注意 迪米特法则要求类“羞涩”一点，尽量不要对外公布太多的public方法和非静态的
///public变量，尽量内敛，多使用private、package-private、protected等访问权限。
///迪米特法则的核心观念就是类间解耦，弱耦合，只有弱耦合了以后，类的复用率才可以提高

//场景-老师叫体育委员去清点女同学  老师类应该与女同学类不直接联系
class Girl {}

class Teacher {
  void commond(GroupLeader groupLeader) {
    groupLeader.countGirls();
  }
}

class GroupLeader {
  late final List<Girl> listGirls;

  GroupLeader(this.listGirls);

  void countGirls() {
    print("一共${listGirls.length}个女同学");
  }
}

//场景2  安装软件类不应该跟向导类过度耦合
//=======修改前
// class InstallSoftware {
//   void installWizard(Wizard wizard) {
//     int first = wizard.first();
//     //¸
//     if (first > 50) {
//       int second = wizard.second();
//       if (second > 50) {
//         int third = wizard.third();
//         if (third > 50) {
//           wizard.first();
//         }
//       }
//     }
//   }
// }
//
// class Wizard {
//   Random rand = Random();
//
//   //µÚÒ»²½
//   int first() {
//     print("第一步");
//     return rand.nextInt(100);
//   }
//
//   int second() {
//     print("第二步");
//     return rand.nextInt(100);
//   }
//
//   int third() {
//     print("第三步");
//     return rand.nextInt(100);
//   }
// }

//重构后
class Wizard {
  Random rand = Random();

  int first() {
    print("安装第一步");
    return rand.nextInt(100);
  }

  int second() {
    print("安装第二步");
    return rand.nextInt(100);
  }

  int third() {
    print("安装第三步");
    return rand.nextInt(100);
  }

  void installWizard() {
    int first = this.first();
    if (first > 50) {
      int second = this.second();
      if (second > 50) {
        int third = this.third();
        if (third > 50) {
          this.first();
        }
      }
    }
  }
}

///安装软件类
class InstallSoftware {

void installWizard(Wizard wizard){
    //
    wizard.installWizard();
  }
  void abc(){

  }
}


