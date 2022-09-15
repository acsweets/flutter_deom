///超市页面
import 'package:flutter/material.dart';
import 'package:style/Strategy/cash_factory.dart';
import 'package:style/Strategy/cash_super.dart';
import 'package:style/utils/enmu.dart';

class Supermarket extends StatefulWidget {
  const Supermarket({Key? key}) : super(key: key);

  @override
  State<Supermarket> createState() => _SupermarketState();
}

late ChargeType type;

class _SupermarketState extends State<Supermarket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('俺是超市'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              payment(ChargeType.rebate, 600.0);
            },
            child: Container(height: 200, width: 200, color: Colors.red, child: Text('点我')),
          )
        ],
      ),
    );
  }
}

double? totalPrice;

void payment(ChargeType type, double money) {
  CashSuper? cashSuper = CashFactory.createCashAccept(type);
  totalPrice = cashSuper?.acceptCash(money);
  print('$totalPrice');
}
