import 'package:attendance/transition/slide_transtion.dart';
import 'package:flutter/material.dart';
import 'package:attendance/theme/dimens.dart';

Widget profileItemBox(BuildContext context,IconData icon,String title,VoidCallback onTap,bool isLast,int duration){
  var theme = Theme.of(context);
  return SlideFadeTranstion(
    direction: Direction.horizental,
    animationDuration: Duration(milliseconds: duration),
    delayStart: Duration(milliseconds: 200),
    curve: Curves.fastLinearToSlowEaseIn,
    offset: 5,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: smallSize(context)),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Icon(icon,color: Colors.white70),
                  Container(
                    margin: EdgeInsets.only(right: smallSize(context)),
                    child: Text(
                      title,
                      style: theme.textTheme.subtitle1!.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLast == false) Container(
            margin: EdgeInsets.symmetric(vertical: standardSize(context)),
            child: Divider(
              height: 0.5,
              color: Colors.white70,
            ),
          )
        ],
      ),
    ),
  );
}