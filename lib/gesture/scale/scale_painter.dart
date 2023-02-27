import 'package:flutter/material.dart';

class ScaleGestureDemo  extends StatefulWidget {
  const ScaleGestureDemo({Key? key}) : super(key: key);

  @override
  State<ScaleGestureDemo> createState() => _ScaleGestureDemoState();
}

class _ScaleGestureDemoState extends State<ScaleGestureDemo> {
  final ValueNotifier<Matrix4> matrix = ValueNotifier<Matrix4>(Matrix4.identity());
  Matrix4 recodeMatrix = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300*0.75,
      width: 300,
      color: Colors.cyanAccent.withAlpha(1),
      child: GestureDetector(
    //    onScaleUpdate: ,
       // onScaleEnd: ,
       // child: ,
      ),
    );
  }
}
class GesturePainter extends CustomPaint{
  const GesturePainter({Key? key}) : super(key: key);





}
