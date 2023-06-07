import 'package:flutter/material.dart';
import 'package:style/design_pattern/liskov_substitution_principle/user_info.dart';
import 'package:style/design_pattern/single_responsibility_principle/abstrac_gun.dart';

import 'composite_pattern/composite.dart';
import 'dependence_inversion_principle,/depend.dart';
import 'facade_pattern/facade.dart';
import 'factory_method_pattern/factory_method.dart';
import 'interface_segregation_principle/interface_segregation.dart';
import 'least_knowledge_principle/least_knowledge.dart';
import 'memento_pattern/memento.dart';
import 'observer_pattern/observer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('主页'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    UserInfo userInfo = UserInfo(
                      userID: "3222",
                      userName: "王二",
                      password: "1235446",
                    );

                    print(userInfo.getPassword());
                  },
                  child: Text('单一职责原则'),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Soldier sanMao = Soldier();
                    sanMao.setGun(Rifle());
                    sanMao.killEnemy();
                  },
                  child: Text('里氏替换原则'),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    ToyGun toyGun = ToyGun();
                    toyGun.setShape(Rifle());
                    toyGun.setColor(Color(0xff452456));
                    print(toyGun.color);
                  },
                  child: Text('玩具'),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    ICar bmw = BMW();
                    Driver zhangSan = Driver(car: bmw);
                    zhangSan.drive();
                  },
                  child: Text('司机开车'),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    IGreatTemperamentGirl yanYan = PettyGirl(name: "艳艳");
                    AbstractSearcher searcher = Searcher.withGreatTemperamentGirl(yanYan);
                    searcher.show();
                  },
                  child: Text('寻找meimie'),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    InstallSoftware invoker = InstallSoftware();
                    invoker.installWizard(Wizard());
                  },
                  child: Text('安装软件'),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    AbstractHumanFactory yinYangLu = HumanFactory();
                    //第一次造人，火候不足，失败
                    print("--造出的第一批人是白色人种--");
                    // Human whiteHuman = yinYangLu.createHuman(WhiteHuman)!;
                    Human whiteHuman = yinYangLu.createHuman(PeopleType.white)!;
                    whiteHuman.getColor();
                    whiteHuman.talk();
                    //第二次造人，火候过足，失败
                    print("\n--造出的第二批人是黑色人种--");
                    //  Human blackHuman = yinYangLu.createHuman(BlackHuman)!;
                    Human blackHuman = yinYangLu.createHuman(PeopleType.black)!;
                    blackHuman.getColor();
                    blackHuman.talk();
                    //第三次造人，火候正好，成功
                    print("\n--造出的第三批人是黄色人种--");
                    // Human yellowHuman = yinYangLu.createHuman(YellowHuman)!;
                    Human yellowHuman = yinYangLu.createHuman(PeopleType.yellow)!;
                    yellowHuman.getColor();
                    yellowHuman.talk();
                  },
                  child: Text('女娲造人'),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Branch ceo = Client.compositeCorpTree();
//根节点
                    print(ceo.getInfo());
//子节点
                    print(Client.getTreeInfo(ceo));
                  },
                  child: Text('遍历树结构'),
                ),


              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Observer liSi =  LiSi();
                    Observer wangSi =  WangSi();
                    Observer liuSi =  LiuSi();
                    HanFeiZi hanFeiZi =  HanFeiZi();
                    hanFeiZi.addObserver(liSi);
                    hanFeiZi.addObserver(wangSi);
                    hanFeiZi.addObserver(liuSi);
                    hanFeiZi.haveBreakfast();
                  },
                  child: Text('观察者模式'),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    //只用传内容和地址就能完成寄信的功能
                    ModenPostOffice hellRoadPostOffice = new ModenPostOffice();
                    String address = "Happy Road No. 666,God Province,Heaven";
                    String context = "Hello,It's me,do you know who I am? I'm your old lover. I'd like to....";
                    hellRoadPostOffice.sendLetter(context, address);
                  },
                  child: Text('邮局寄信'),
                ),


                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Boy boy =  Boy();
                    Caretaker caretaker =  Caretaker();
                    boy.setState("心情很棒！");
                    print("=====男孩现在的状态¬======");
                    print(boy.getState());
                    //需要记录下当前状态呀,
                   // 创建备忘录
                    caretaker.setMemento(boy.createMemento());
                    //男孩去追女孩，状态改变
                    boy.changeState();
                    print("\n=====男孩追女孩子后的状态=¬======");
                    print(boy.getState());
                    //追女孩失败，恢复原状 ,,读取备忘录
                    boy.restoreMemento(caretaker.getMemento());
                    print("\n=====男孩恢复后的状态=======");
                    print(boy.getState());
                  },
                  child: Text('备忘录模式追女孩'),
                ),
              ],
            ),
          ],
        ));
  }
}
