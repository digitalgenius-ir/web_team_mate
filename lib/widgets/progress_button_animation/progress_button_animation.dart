import 'package:attendance/theme/dimens.dart';
import 'package:attendance/transition/slide_transtion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AnimatedButton extends StatefulWidget {
  late bool isProgress;
  late VoidCallback onTap;
  late Widget child;

  AnimatedButton(
      {Key? key,
      required this.isProgress,
      required this.onTap,
      required this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ProgressButtonLoadingState();
}

class ProgressButtonLoadingState extends State<AnimatedButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.isProgress ? null : widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: EdgeInsets.only(
          top: standardSize(context)+smallSize(context),
          bottom: standardSize(context),
          right: widget.isProgress ? xxlargeSize(context) : standardSize(context),
          left: widget.isProgress ? xxlargeSize(context) : standardSize(context),
        ),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(standardSize(context))),
        height: kToolbarHeight,
        child: widget.isProgress
            ? SlideFadeTranstion(
                curve: Curves.fastLinearToSlowEaseIn,
                offset: 5,
                delayStart: Duration(milliseconds: 200),
                animationDuration: Duration(milliseconds: 500),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 6),
                        child: Text("لطفا منتظر بمانید",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white))),
                    Theme(
                        data: ThemeData(
                            cupertinoOverrideTheme: const CupertinoThemeData(
                                brightness: Brightness.dark,barBackgroundColor: Colors.white)),
                        child: const CupertinoActivityIndicator())
                  ],
                ),
              )
            : widget.child,
      ),
    );
  }
}
