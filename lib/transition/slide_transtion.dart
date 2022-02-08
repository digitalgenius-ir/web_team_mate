import 'dart:async';

import 'package:flutter/cupertino.dart';

enum Direction {
  vertical,
  horizental
}

class SlideFadeTranstion extends StatefulWidget {
  Widget child;
  double offset;
  Curve curve;
  Direction direction;
  Duration delayStart;
  Duration animationDuration;

  SlideFadeTranstion(
      {Key? key, required this.child, this.offset = 1.0, this.curve = Curves
          .easeIn, this.direction = Direction
          .vertical, this.delayStart = const Duration(seconds: 0),
        this.animationDuration = const Duration(milliseconds: 800)
      }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SlideFadeTranstionState();
}

class SlideFadeTranstionState extends State<SlideFadeTranstion>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> animationSlide;
  late AnimationController animationController;
  late Animation<double> animationFade;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: widget.animationDuration);
    if (widget.direction == Direction.vertical) {
      animationSlide =
          Tween<Offset>(begin: Offset(0, widget.offset), end: Offset(0, 0))
              .animate(CurvedAnimation(
              parent: animationController, curve: widget.curve));
    } else {
      animationSlide =
          Tween<Offset>(begin: Offset(widget.offset, 0), end: Offset(0, 0))
              .animate(CurvedAnimation(
              parent: animationController, curve: widget.curve));
    }
    animationFade = Tween<double>(begin: -1.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: widget.curve));
    Timer(widget.delayStart,(){
      animationController.forward();
    }) ;
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: animationFade,

      child: SlideTransition(
        position: animationSlide,
        child: widget.child,

      ),
    );
  }

}