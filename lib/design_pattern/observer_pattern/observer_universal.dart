
///观察者通用模板

abstract class Observer {

 void update();
}


abstract class Subject {
  List<Observer> obsVector = [];

 void addObserver(Observer o){
    obsVector.add(o);
  }

 void delObserver(Observer o){
    obsVector.remove(o);
  }

 void notifyObserver(){
   for (var element in obsVector) {
     element.update();
   }
  }
}
//被观察者

 class ConcreteSubject extends Subject {

 void doSomething(){
   //做完事通知监听者
    super.notifyObserver();
  }
}

//观察者类
 class ConcreteObserver implements Observer {
   @override
  void update() {
    print("我观察到了");
  }

}
 class  ObserveClient {

 static void start() {
   //被观察者
  ConcreteSubject subject =  ConcreteSubject();
  Observer obs= ConcreteObserver();
  subject.addObserver(obs);
  subject.doSomething();
  }




}