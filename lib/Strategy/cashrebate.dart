import 'package:style/Strategy/cash_super.dart';

///打折收费类
///
class CashRebate extends CashSuper {
  late final double discount;//八折输入0.8
  ///重写收费方法
  ///
  @override
  double acceptCash(double money) {
    return money *discount;
  }
}
