import 'package:style/Strategy/cash_super.dart';

///正常收费类
class CashNormal extends CashSuper {
  ///重写收钱方法
  @override
  double acceptCash(double money) {
    return money;
  }
}
