 import 'package:style/decorate/person.dart';

class Finery extends Person{

  Person ? component;

  Finery(String name) : super(name);


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
