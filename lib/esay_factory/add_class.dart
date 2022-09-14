import 'operstion.dart';

class Add extends Operation{
  @override
  double getResult() {
    double result = 0;
    result = numberA+numberB;
    return result;
  }


}

class Reduce extends Operation {
  @override
  double getResult() {
    double result = 0;
    result = numberA - numberB;
    return result;
  }
}