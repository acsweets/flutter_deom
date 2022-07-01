import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> colors = [
    Colors.red, Colors.yellow, Colors.blue, Colors.green,
    Colors.orange, Colors.purple, Colors.cyanAccent];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column(
        children: <Widget>[
          const SizedBox(height: 200,),
          Wrap(
            children: _buildDraggable(),
            spacing: 10,
          ),
          const SizedBox(
            height: 20,
          ),
          DragTarget<int>(
              onAccept: _onAccept,
              onWillAccept: (data) => data != null,
              builder: buildTarget
          )
        ],
      ),
    );
  }

  Widget buildTarget(context, candidateData, rejectedData) => Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: const Center(
        child: Icon(Icons.delete_sweep, color: Colors.white),
      ));

  List<Widget> _buildDraggable() => colors
      .map((Color color) => Draggable<int>(
      child: buildContent(color),
      data: colors.indexOf(color),
      childWhenDragging: buildWhenDragging(),
      feedback: buildFeedback(color)),
  ).toList();

  Widget buildContent(Color color) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      child: Text(
        colors.indexOf(color).toString(),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
//拖动的时候的组件
  Widget buildFeedback(Color color) {
    return Container(
      width: 25,
      height: 25,
      decoration:
      BoxDecoration(color: color.withAlpha(100), shape: BoxShape.circle),
    );
  }
//拖动时候原位置的组件
  Widget buildWhenDragging() {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: const Icon(Icons.delete_outline, size: 20, color: Colors.white,
      ),
    );
  }

  void _onAccept(int data) {
    setState(() {
      colors.removeAt(data);
    });
  }
}