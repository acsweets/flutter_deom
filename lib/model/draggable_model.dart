import 'dart:ui';
import 'package:flutter/material.dart';

class DraggableModel extends ChangeNotifier {

  bool _disposed = false;
  Color pagecolor = Colors.black;

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
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