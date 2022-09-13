import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {

  String name = "Jimi";

  void changeName() {
    name = "王八";
    notifyListeners();
  }
}