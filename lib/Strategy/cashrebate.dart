import 'package:style/Strategy/cash_super.dart';

///打折收费类
///
class CashRebate extends CashSuper {
  final double discount ; //八折输入0.8

  CashRebate( {required this.discount,});
  ///重写收费方法
  ///
  @override
  double acceptCash(double money) {
    double total = money * discount;
    return total;
  }
}
