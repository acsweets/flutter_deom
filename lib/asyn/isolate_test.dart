import 'dart:isolate';
import 'dart:ui';

import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolatePage extends StatefulWidget {
  const IsolatePage({Key? key}) : super(key: key);

  @override
  State<IsolatePage> createState() => _IsolatePageState();
}

class _IsolatePageState extends State<IsolatePage> {
  late ReceivePort receivePort;

  @override
  void initState() {
    receivePort = ReceivePort();
    IsolateNameServer.registerPortWithName(receivePort.sendPort, 'myPortName');
    receivePort.listen((message) {
      print('接收端口收到信息 $message');
      // 在这里添加你的处理逻辑
      // ...
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" isolated使用"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              SendPort? sendPort = IsolateNameServer.lookupPortByName('myPortName');
              sendPort?.send('我向ReceivePort发送了一个信息');
            },
            child: Text("点击向端口发送信息"),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('myPortName');
    super.dispose();
  }
}
