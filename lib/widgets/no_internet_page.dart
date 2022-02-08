// ignore_for_file: deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:attendance/theme/dimens.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onPress;

  const NoInternetWidget(this.onPress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: fullWidth(context),
        height: fullHeight(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: fullWidth(context) / 2,
                height: fullHeight(context) / 4,
                child: Lottie.asset('assets/no_internet.json')),
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: mediumSize(context),
                    horizontal: largeSize(context)),
                child: Text(
                  "اتصال خود به اینترنت را بررسی کنید",
                  textAlign: TextAlign.center,
                )),
            RaisedButton(
                child: Text(
                  "تلاش مجدد",
                ),
                onPressed: onPress),
          ],
        ),
      ),
    );
  }
}
