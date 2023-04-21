///只负责用户属性
///单一职责原则
abstract  class IUserBO{
 void setUserID(String userID);

  String getUserID();

  void setPassword(String password);

 String getPassword();

  void setUserName(String userName);

  String getUserName();
}