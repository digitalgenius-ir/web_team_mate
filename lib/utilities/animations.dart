import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = TimelineTween();

    return PlayAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (BuildContext context, Widget? child, TimelineValue<dynamic> animation) =>
          Opacity(
            opacity: delay,
            child: Transform.translate(
                offset: Offset(0, 0), child: child),
          ),
    );
  }
}
