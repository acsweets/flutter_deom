///建造者模式的例子

class Product {

 void doSomething(){

  }
}


abstract class Builder {
  // 设置部件的抽象方法
  void setPart();

  // 构建产品的抽象方法
  Product buildProduct();
}


class ConcreteProduct extends Builder {
  Product product = Product();  // 设置产品部件
  void setPart() {
    /*
     * 产品部件的处理
     */
  }

  // 组装产品
  Product buildProduct() {
    return product;
  }
}
class Director {
  Builder builder = ConcreteProduct();

  // 创建非相同的产品
  Product getAProduct() {
    builder.setPart();
    // 设置不同的部件，建造非相同的产品
    return builder.buildProduct();
  }
}