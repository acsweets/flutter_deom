import 'package:flutter/material.dart';

class SkewShadowText extends StatefulWidget {
  const SkewShadowText({Key? key}) : super(key: key);

  @override
  State<SkewShadowText> createState() => _SkewShadowTextState();
}

class _SkewShadowTextState extends State<SkewShadowText>  with SingleTickerProviderStateMixin {
 late AnimationController _ctrl;
 final Duration animDuration = const Duration( milliseconds: 800);
 final TextStyle commonStyle =  TextStyle(fontSize: 60, color: Colors.blue);
 final TextStyle shadowStyle = TextStyle(fontSize: 60,
     color: Colors.blue.withAlpha(88));
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
