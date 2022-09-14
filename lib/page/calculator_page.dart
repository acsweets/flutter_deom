import 'package:flutter/material.dart';

import '../esay_factory/operation_factory.dart';
import '../esay_factory/operstion.dart';

class CalculatorPage extends StatefulWidget {

   CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}
TextEditingController textController = TextEditingController();
  Operation ?oPer;
class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('计算器'),
      ),
      body: Column(
       children: [
             Text('请输入您需要计算的数字'),
          TextField(
               controller:textController,
             ),
         GestureDetector(onTap: (){
           oPer = OperationFactory.createOperate("+");
           oPer?.numberA=15.0;
           oPer?.numberB=6.0;
           print('${oPer?.getResult()}');
         },child: Text('确定')),

       ],
      ),
    );
  }
}
