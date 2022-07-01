import 'package:flutter/material.dart';

import '../model/draggable_model.dart';

class Draggabl extends StatefulWidget {
  const Draggabl({
    Key? key,
  }) : super(key: key);

  @override
  State<Draggabl> createState() => _DraggablState();
}

class _DraggablState extends State<Draggabl> {
  late DraggableModel model;

  @override
  void initState() {
    super.initState();

    model = DraggableModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: model.pagecolor,
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.map),
              onPressed: () {
                model.changeColor();
                setState(() {});
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: model.pagecolor,
        elevation: 0.0, //标题下的阴影
        actions: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
            splashColor: Colors.white,
            onTap: () {},
          )
        ],
      ),
      body: Container(),
    );
  }
}
