import 'package:flutter/material.dart';

import '../utils/Colors.dart';
import 'Company.dart';
import 'DetailScreen.dart';


class CircleCompanyLogo extends StatefulWidget {
  final String company;
  const CircleCompanyLogo({
    required this.company,
  }) : super();

  @override
  CircleCompanyLogoState createState() {
    return new CircleCompanyLogoState();
  }
}

class CircleCompanyLogoState extends State<CircleCompanyLogo>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return new CircleWithAnimation(widget: widget);
  }

  @override
  bool get wantKeepAlive => true;
}

class CircleWithAnimation extends StatefulWidget {
  const CircleWithAnimation({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final CircleCompanyLogo widget;

  @override
  CircleWithAnimationState createState() {
    return new CircleWithAnimationState();
  }
}

class CircleWithAnimationState extends State<CircleWithAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: FractionalTranslation(
        child: Material(
          type: MaterialType.circle,
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(width: 1.0, color: Colors.transparent)),
              height: 50.0,
              width: 50.0,
              child: FutureBuilder<Company>(
                future: getDomain(widget.widget.company.trim()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage('https://logo.clearbit.com/flutter.io'),
                    );
                  } else {
                    return new Center(
                      child: CircularProgressIndicator(
                        valueColor:
                        new AlwaysStoppedAnimation<Color>(MyColors.bkColor),
                      ),
                    );
                  }
                },
              )),
        ),
        translation: Offset(-0.5, 0.82),
      ),
    );
  }
}