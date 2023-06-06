
///组合模式有两种不同的实现：透明模式和安全模式，
///透明的组合模式，透明模式是把用来组合使用 的方法放到抽象类中，
///比如add()、remove()以及getChildren等方法（顺便说一下，
///getChildren 一般返回的结果为Iterable的实现类，很多，大家可以看JDK的帮助），
///不管叶子对象还是树 枝对象都有相同的结构，通过判断是getChildren的返回值确认
///是叶子节点还是树枝节点，如果处理不当，这个会在运行期出现问题，不是很建议的方式；
///安全模式就不同了，它是把树枝节点和树叶节点彻底分开，树枝节点单独拥有用来组合的方法，这种方法比较安全，


 abstract class Corp {

  final String name ;

  final String position ;

  final int salary ;

  late final Corp ?parent ;

  Corp({
  this.name = "",
  this.position = "",
  this.salary = 0
  });

String getInfo(){
    String info = "";
    info = "名字" + name;
    info = info + "\t"+position;
    info = info + "\t" + "$salary";
    return info;
  }


  void setParent(Corp _parent){
    parent = _parent;
  }

 Corp getParent(){
    return parent!;
  }
}
class Lea extends Corp {
  Lea(String _name, String _position, int _salary)
      : super(
    name: _name,
    position: _position,
    salary: _salary,
  );
}


 class Branch extends Corp {
List<Corp> subordinateList = [];

Branch(String _name, String _position, int _salary)
    : super(
  name: _name,
  position: _position,
  salary: _salary,
);
void addSubordinate(Corp corp) {
  corp.setParent(this);
  subordinateList.add(corp);
}

List<Corp> getSubordinate() {
  return subordinateList;
}
  }




