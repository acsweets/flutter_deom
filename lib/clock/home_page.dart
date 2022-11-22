import 'package:flutter/material.dart';
import 'package:style/clock/widget/buttons_tools.dart';
import 'package:style/clock/widget/stop_watch_widget.dart';

import 'enum.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: buildActions(),
        ),
        body: Column(

          children: [
            Center(child: buildStopwatchPanel()),
            /*  buildRecordPanel(),*/
            buildTools(),
          ],
        ));
  }

  Widget buildStopwatchPanel() {
    // MediaQuery.of(context).size 可以获取屏幕的尺寸
    double radius = MediaQuery.of(context).size.shortestSide/2*0.75;
    Duration duration =  Duration(minutes: 3,seconds: 28,milliseconds: 50);
    return StopwatchWidget( // 使用 StopwatchWidget
      radius: radius,
      duration: duration,
    );
  }
  StopWatchType _type = StopWatchType.none;
  Widget buildTools() {
    return ButtonTools(
      state: _type,
      onRecoder: onRecoder,
      onReset: onReset,
      toggle: toggle,
    );
  }

  void onReset() {}
  void onRecoder() {}
  void toggle() {}
  Widget buildRecordPanel() {
    return widget;
  }

  List<Widget> buildActions() {
    return [
      PopupMenuButton<String>(
        itemBuilder: _buildItem,
        onSelected: _onSelectItem,
        icon: const Icon(Icons.more_vert_outlined, color: Color(0xff262626)),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      )
    ];
  }

  List<PopupMenuEntry<String>> _buildItem(BuildContext context) {
    return const [
      PopupMenuItem<String>(
        value: "设置",
        child: Center(child: Text("设置")),
      )
    ];
  }

  void _onSelectItem(String value) {}
}
