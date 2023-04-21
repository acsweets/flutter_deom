import 'iuserbo.dart';
///单一职责原则
///只负责用户行为

abstract  class IUserBiz{
  bool changePassword(String oldPassword);

 bool deleteUser();


 void mapUser();

 void addOrg(IUserBO userBO,int orgID);

 void addRole(IUserBO userBO,int roleID);
}