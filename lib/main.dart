import 'package:flutter/material.dart';
import 'package:style/page/calculator_page.dart';
import 'package:style/page/decorate_page.dart';
import 'package:style/page/home_page.dart';
import 'package:style/page/providerExample.dart';
import 'package:provider/provider.dart';
import 'package:style/page/supermarket_page.dart';
import 'asyn/isolate_test.dart';
import 'model/user_model.dart';

void main() {
  runApp(
     const MyApp()
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '示例',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  IsolatePage(),
    );
   /*   Provider<UserModel>(
        create: (_) => UserModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProviderExample(),
        ),
      );*/
  }
}

