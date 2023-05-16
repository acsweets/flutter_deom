///原型模式
///广告信这个模块
///用原型实例指定创建对象的种类，并且通过拷贝这些原型创建新的对象。
///简单，太简单了！原型模式的核心是一个clone方法，通过该方法进行对象的拷贝，
///Java 提供了一个Cloneable接口来标示这个对象是可拷贝的，为什么说是“标示”呢？翻开JDK的帮
/// 助看看Cloneable是一个方法都没有的，这个接口只是一个标记作用，
/// 在JVM中具有这个标记 的对象才有可能被拷贝。那怎么才能从“有可能被拷贝”转换为“可以被拷贝”呢？
///方法是覆盖 clone()方法，是的，你没有看错是重写clone()方法
///
/// 优点
///原型模式是在内存二进制流的拷贝，要比直接new一个对象性能好很多，特别是要在一
///个循环体内产生大量的对象时，原型模式可以更好地体现其优点。
/// ● 逃避构造函数的约束 这既是它的优点也是缺点，直接在内存中拷贝构造函数是不会执行的
///，优点就是减少了约束，缺点也是减少了约束，需要大家在实际应用时考虑。

/// 原型模式的使用场景
///
///
/// ● 资源优化场景 类初始化需要消化非常多的资源，这个资源包括数据、硬件资源等。
/// ● 性能和安全要求的场景 通过new产生一个对象需要非常繁琐的数据准备或访问权限，则可以使用原型模式。
/// ● 一个对象多个修改者的场景 一个对象需要提供给其他对象访问，而且各个调用者可能都需要修改其值时，可以考虑
/// 使用原型模式拷贝多个对象供调用者使用。 在实际项目中，原型模式很少单独出现，一般是和工厂方法模式一起出现，
/// 通过clone的 方法创建一个对象，然后由工厂方法提供给调用者。原型模式已经与Java融为一体，大家可以随手拿来使用
///
///
///
///原型模式先产生出一个包含大量共有信息的类，
///然后可以拷贝出副本，修正细节信息， 建立了一个完整的个性对象。
///我们今天讲的原型模式也就是由一个 正本可以创建多个副本的概念。
///可以这样理解：一个对象的产生可以不由零起步，直接从一 个已经具备一定雏形的对象克隆，
///然后再修改为生产需要的对象。也就是说，产生一个人， 可以不从1岁长到2岁，再到3岁……
///也可以直接找一个人，从其身上获得DNA，然后克隆一 个，直接修改一下就是30岁了！
///我们讲的原型模式也就是这样的功能。
///
///
///简单，太简单了！原型模式的核心是一个clone方法，通过该方法进行对象的拷贝
// class PrototypeClass implements Cloneable {
//   //覆写父类Object方法
//   @Override public PrototypeClass
//
//   clone() {
//     PrototypeClass prototypeClass = null;
//     try {
//       prototypeClass = (PrototypeClass)super.clone();
//     }
//     catch
//     (
//     CloneNotSupportedException e) {
//     //异常处理
//     }return
//     prototypeClass;
//   }
// }
//实现一个接口，然后重写clone方法，就完成了原型模式
///dart中木有深浅拷贝  寄===先了解一哈
///
// abstract class Cloneable{
//
// }
// class Mail implements Cloneable {
//   // 收件人
//   String receiver;
//
//   // 邮件主题
//   String subject;
//
//   // 称呼
//   String appellation;
//
//   // 邮件内容
//   String contxt;
//
//   // 邮件的尾部，一般都是加上"XXX版权所有"等信息
//   String tail;
//
//   // 构造函数
//   Mail(AdvTemplate advTemplate) {
//     this.contxt = advTemplate.getAdvContext();
//     this.subject = advTemplate.getAdvSubject();
//   }
//
//   // clone方法
//   Mail clone() {
//     Mail mail;
//     try {
//       mail = super.clone() as Mail;
//     } catch (e) {
//       // TODO Auto-generated catch block
//       throw e;
//     }
//     return mail;
//   }
//
//   // getter/setter方法
//   String getReceiver() {
//     return receiver;
//   }
//
//   void setReceiver(String receiver) {
//     this.receiver = receiver;
//   }
//
//   String getSubject() {
//     return subject;
//   }
//
//   void setSubject(String subject) {
//     this.subject = subject;
//   }
//
//   String getAppellation() {
//     return appellation;
//   }
//
//   void setAppellation(String appellation) {
//     this.appellation = appellation;
//   }
//
//   String getContxt() {
//     return contxt;
//   }
//
//   void setContxt(String contxt) {
//     this.contxt = contxt;
//   }
//
//   String getTail() {
//     return tail;
//   }
//
//   void setTail(String tail) {
//     this.tail = tail;
//   }
// }
//
// class AdvTemplate {
//   // 广告信件的主题
//   String advSubject = "XX企业新年抽奖活动";
//
//   // 广告信件的内容
//   String advContext = "恭喜您获得本次活动一等奖：XXXXXX";
//
//   // 获取广告信件的主题
//   String getAdvSubject() {
//     return advSubject;
//   }
//
//   // 获取广告信件的内容
//   String getAdvContext() {
//     return advContext;
//   }
// }
//
