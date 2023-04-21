import 'package:style/design_pattern/liskov_substitution_principle/iuserbo.dart';

import 'iuserinfo.dart';
///单一职责原则的定义是：应该有且仅有一个原因引起类的变更。
///接口包含了两个职责，而且这两个职责的变化不相互影响，那就考虑拆分成两个接口
class UserInfo implements IUserInfo {
  late final String userName;
  late final String userID;
  late final String password;

 UserInfo({required this.userName, required this.userID, required this.password,});

  @override
  String getUserName() {

    return userName;
  }

  @override
  void setUserName(String userName) {
    this.userName = userName;
  }

  @override
  String getUserID() {
    return userID;
  }

  @override
  void setUserID(String userID) {
    this.userID = userID;
  }

  @override
  String getPassword() {
    return password;
  }

  @override
  void setPassword(String password) {
    this.password = password;
  }

  @override
  bool changePassword(String oldPassword) {
    return true;
  }

  @override
  bool deleteUser() {
    return true;
  }

  @override
  void mapUser() {

  }

  @override
  void addOrg(IUserBO userBO, int orgID) {}

  @override
  void addRole(IUserBO userBO, int roleID) {}
}
