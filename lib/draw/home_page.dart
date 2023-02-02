import 'package:flutter/material.dart';
import 'package:style/draw/page/my_drawer.dart';

import 'draw_Axis.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 int _selectedIndex = 1;
 List<Widget> bodyList = const [AxisPage(), AxisPage(), AxisPage(), ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*      appBar: AppBar(
          title: const Text("App Name"),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.dashboard, color: Colors.white), //自定义图标
              onPressed: () {
                // 打开抽屉菜单
                Scaffold.of(context).openDrawer();
              },
            );
          })),*/
      drawer: const MyDrawer(),
      body: bodyList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar( // 底部导航
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label:'主页'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: '绘画'),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),//抽屉
    );
  }
 void _onItemTapped(int index) {
   setState(() {
     _selectedIndex = index;
   });
 }
 void _onAdd(){
 }
}
