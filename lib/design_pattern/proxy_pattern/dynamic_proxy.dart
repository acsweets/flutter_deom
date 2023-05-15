///动态代理
///动态代理是在实现阶段不用关心代理谁，
///而在运行阶段 才指定代理哪一个对象。
///相对来说，自己写代理类的方式就是静态代理。
///现在有一个非常流行的名称叫做面向横切面编程，也就是AOP（Aspect Oriented Programming），其核心就是采用了动态代理机制，
///
/// 在类图中增加了一个InvocationHandler接口和GamePlayIH类， 作用就是产生一个对象的 代理对象，
/// 其中InvocationHandler是JDK提供的动态代理接口，对被代理类的方法进行代理。
///

class GamePlayIH implements InvocationHandler {
  Object? obj;

  GamePlayIH({this.obj});

  @override
  dynamic invoke(Object proxy, Invocation invocation) {
    var method = invocation.memberName;
    var args = invocation.positionalArguments;
    var result = Function.apply(obj, [method, ...args]);
    return result;
  }
}
