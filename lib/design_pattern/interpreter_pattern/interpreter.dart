///解释器模式
///是一种按照规定语法进行解析的方案，在现在项目中使用较少，
///其定义如下
///给定一门语言，定义 它的文法的一种表示，并定义一个解释器，该解释器使用该表示来解释语言中的句子。
///
///
///解释器模式的优点
///
///解释器是一个简单语法分析工具，它最显著的优点就是扩展性，
///修改语法规则只要修改相应的非终结符表达式就可以了，若扩展语法，则只要增加非终结符类就可以了。
/// 解释器模式的缺点
///
///
/// ● 解释器模式会引起类膨胀 每个语法都要产生一个非终结符表达式，
/// 语法规则比较复杂时，就可能产生大量的类文 件，为维护带来了非常多的麻烦。
/// ● 解释器模式采用递归调用方法 每个非终结符表达式只关心与自己有关的表达式，每个表达式需要知道最终的结果，
/// 必须一层一层地剥茧，无论是面向过程的语言还是面向对象的语言，递归都是在必要条件下使用的，
/// 它导致调试非常复杂。想想看，如果要排查一个语法错误，
/// 我们是不是要一个断点一个断点地调试下去，直到最小的语法单元。
/// ● 效率问题 解释器模式由于使用了大量的循环和递归，效率是一个不容忽视的问题，
/// 特别是一用于解析复杂、冗长的语法时，效率是难以忍受的。
///
///  解释器模式使用的场景
/// ● 重复发生的问题可以使用解释器模式例如，多个应用服务器，
/// 每天产生大量的日志，需要对日志文件进行分析处理，
/// 由于各个服务器的日志格式不同，但是数据要素是相同的
/// 按照解释器的说法就是终结符表达式都 是相同的，但是非终结符表达式就需要制定了
/// 在这种情况下，可以通过程序来一劳永逸地 解决该问题。
///● 一个简单语法需要解释的场景 为什么是简单？看看非终结表达式，
///文法规则越多，复杂度越高，而且类间还要进行递 归调用（看看我们例子中的栈）。
///想想看，多个类之间的调用你需要什么样的耐心和信心去 排查问题。
///因此解释器模式一般用来解析比较标准的字符集，例如SQL语法分析，不过该 部分逐渐被专用工具所取代。
///在某些特用的商业环境下也会采用解释器模式，我们刚刚的例子就是一个商业环境，
///而且现在模型运算的例子非常多，目前很多商业机构已经能够提供出大量的数据进行分析。
///
///
///
/// 解释器模式的注意事项
/// 尽量不要在重要的模块中使用解释器模式，否则维护会是一个很大的问题。
/// 在项目中可以使用shell、JRuby、Groovy等脚本语言来代替解释器模式，弥补Java编译型语言的不足。
///我们在一个银行的分析型项目中就采用JRuby进行运算处理，避免使用解释器模式的四则运算，效率和性能各方面表现良好
///
///
///
/// 业务需求：输入一个模型公式（加、减运算）
/// 然后输入模型中的参数，运算出结果。 设计要求：
/// ● 公式可以运行时编辑，并且符合正常算术书写方式，例如a+b-c。
/// ● 高扩展性，未来增加指数、开方、极限、求导等运算符号时较少改动。
/// ● 效率可以不用考虑，晚间批量运算
///

abstract class Expression {
  int interpreter(Map<String, int> variables);
}

class VarExpression extends Expression {
  final String key;

  VarExpression({required this.key});

  @override
  int interpreter(Map<String, int> variables) {
    return variables["key"] ?? 0;
  }
}

abstract class SymbolExpression extends Expression {
  final Expression left;
  final Expression right;

  SymbolExpression({
    required this.left,
    required this.right,
  });
}

//  解释这个符号左边减去右边
class SubExpression extends SymbolExpression {
  SubExpression(Expression _left, Expression _right) : super(left: _left, right: _right);

  @override
  int interpreter(Map<String, int> variables) {
    return super.left.interpreter(variables) - super.right.interpreter(variables);
  }
}

//左边加去右边
class AddExpression extends SymbolExpression {
  AddExpression(Expression _left, Expression _right) : super(left: _left, right: _right);

  @override
  int interpreter(Map<String, int> variables) {
    return super.left.interpreter(variables) + super.right.interpreter(variables);
  }
}

class Calculator {
  late Expression expression;
  final String expStr;

  Calculator(this.expStr) {
    List<Expression> stack = [];
    List<String> chars = expStr.split('');
    Expression? left;
    Expression? right;
    for (int i = 0; i < chars.length; i++) {
      print("${chars}");
      switch (chars[i]) {
        case '+': //
          left = VarExpression(key: chars[i]);
          right = VarExpression(key: chars[++i]);
          stack.add(AddExpression(left, right));
          break;
        case '-':
          left = VarExpression(key: chars[i]);
          right = VarExpression(key: chars[++i]);
          stack.add(SubExpression(left, right));
          break;
        default:
          stack.add(VarExpression(key: chars[i]));
      }
    }
    expression = stack.first;
  }

  int run(Map<String, int> variables) {
    return expression.interpreter(variables);
  }
}


