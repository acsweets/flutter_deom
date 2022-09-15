import 'package:style/Strategy/cash_normal.dart';
import 'package:style/Strategy/cash_super.dart';

import '../utils/enmu.dart';
import 'cash_return.dart';
import 'cashrebate.dart';

class CashFactory {
  static CashSuper? createCashAccept(ChargeType type) {
    CashSuper? cs;
    switch (type) {
      case ChargeType.normal:
        cs = CashNormal();//正常
        print('${cs.acceptCash(600)}');
        break;
      case ChargeType.discount:
        cs = CashRebate( discount: 0.8);//打折
        break;
      case ChargeType.rebate:
        cs = CashReturn(moneyReturn: 50, moneyCondition: 300, );//返利
        print('${cs.acceptCash(600)}');
        break;
    }
    return cs;
  }
}
