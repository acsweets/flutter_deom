import 'package:flutter/material.dart';
import 'package:style/design_pattern/liskov_substitution_principle/user_info.dart';
import 'package:style/design_pattern/single_responsibility_principle/abstrac_gun.dart';

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
              ],
            ),
          ],
        ));
  }
}
