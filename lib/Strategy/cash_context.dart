import 'package:style/Strategy/cash_normal.dart';
import 'package:style/Strategy/cash_super.dart';
import 'package:style/Strategy/cashrebate.dart';

import '../utils/enmu.dart';
import 'cash_return.dart';

class CashContext {
  late final CashSuper cs; //传入一个收费
  final ChargeType type;

  ///构造方法传入不同的收费策略
  CashContext({
    required this.type,
  }) {
    switch (type) {
      case ChargeType.normal:
        CashNormal csa = CashNormal();
        cs = csa;
        break;
      case ChargeType.rebate:
        CashReturn csb = CashReturn(moneyCondition: 300, moneyReturn: 20); //返利
        cs = csb;
        break;
      case ChargeType.discount:
        CashRebate csc = CashRebate(discount: 0.3); //打折
        cs = csc;
        break;
    }
  }

  double getResult(double money) {
    return cs.acceptCash(money);
  }
}
