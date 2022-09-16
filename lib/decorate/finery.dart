 import 'package:style/decorate/person.dart';

class Finery extends Person{

  Person ? component;


  void decorate(Person component ) {
    this.component = component;
  }

@override
  void show() {
    if( component!=null){
      component?.show();
    }
  }

}