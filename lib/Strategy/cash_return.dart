import 'package:style/Strategy/cash_super.dart';

///收费返利类
/// 初始化必须输入返利条件跟返利值
///
class CashReturn extends CashSuper{
  final  double moneyCondition =0;//条件
  final  double moneyReturn =0;//返利


  @override
  double acceptCash(double money) {
    // TODO: implement acceptCash
    throw UnimplementedError();
  }




}