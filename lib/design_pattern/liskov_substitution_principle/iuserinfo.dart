import 'iuserbiz.dart';
import 'iuserbo.dart';
///单一职责原则
//这个接口包含了用户行为和属性
abstract class IUserInfo implements IUserBiz, IUserBO {}
