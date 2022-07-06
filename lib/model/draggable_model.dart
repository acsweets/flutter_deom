import 'dart:ui';
import 'package:flutter/material.dart';

class DraggableModel extends ChangeNotifier {
  Color pagecolor = Colors.black;

  @override


  void changeColor() {
    if (pagecolor != Colors.purple) {
      pagecolor = Colors.purple;
    } else {
      pagecolor = Colors.indigoAccent;
    }
    notifyListeners();
  }
}
