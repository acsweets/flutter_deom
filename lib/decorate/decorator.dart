import 'package:style/decorate/base_component.dart';
///装饰类
abstract class Decorator extends Component {
  Component? _component;
///先存起来
  void setComponent(Component component) {
    _component = component;
  }

  @override
  void operation() {
    if (_component != null) {
      _component?.operation();
    }
  }
}
