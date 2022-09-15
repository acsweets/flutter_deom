import 'package:style/Strategy/cash_super.dart';

///收费返利类
/// 初始化必须输入返利条件跟返利值
///
class CashReturn extends CashSuper {
  final double moneyCondition; //条件
  final double moneyReturn; //返利

  CashReturn({
    required this.moneyReturn,
    required this.moneyCondition,
  });

  @override
  double acceptCash(double money) {
    double result = money;

    if (money > moneyCondition) {
      result = money - (money / moneyCondition) * moneyReturn;
    }

    return result;
  }
}
