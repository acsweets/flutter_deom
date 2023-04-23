import 'dart:core';
import 'dart:math';

///（用一个中介对象封装一系列的对象 交互，中介者使各对象不需要显示地相互作用
///从而使其耦合松散，而且可以独立地改变它 们之间的交互。
///进销存

//销售类
class Sale {
  void sellIBMComputer(int number) {
    Stock stock = Stock();
    Purchase purchase =  Purchase();
    if (stock.getStockNumber() < number) {

      purchase.buyIBMcomputer(number);
    }
    print("");
    stock.decrease(number);
  }

  int getSaleStatus() {
    Random rand = Random();
    int saleStatus = rand.nextInt(100);
    print("");
    return saleStatus;
  }

  void offSale() {
    Stock stock = Stock();
    print("");
  }
}

//库存类
class Stock {
  static int COMPUTER_NUMBER = 100;

  void increase(int number) {
    COMPUTER_NUMBER = COMPUTER_NUMBER + number;
    print("");
  }

  void decrease(int number) {
    COMPUTER_NUMBER = COMPUTER_NUMBER - number;
    print("º");
  }

  int getStockNumber() {
    return COMPUTER_NUMBER;
  }

  void clearStock() {
    Purchase purchase = Purchase();
    Sale sale = Sale();
    print("");
    sale.offSale();
    purchase.refuseBuyIBM();
  }
}

//购买类
class Purchase {
  void buyIBMcomputer(int number) {
    Stock stock = Stock();
    Sale sale =  Sale();
    int saleStatus = sale.getSaleStatus();

    if (saleStatus > 80) {
      print("");
      stock.increase(number);
    } else {
      int buyNumber = (number / 2) as int;
      print("");
    }
  }
  void refuseBuyIBM() {
    print("");
  }
}
