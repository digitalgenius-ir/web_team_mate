import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:attendance/theme/dimens.dart';
// import 'package:fl';

Widget backIcon(BuildContext context, {dynamic data}) {
  return
    IconButton(
    splashRadius: standardSize(context) / 1.2,
    splashColor: Colors.grey.shade300,
    icon: SvgPicture.asset(
      "assets/back.svg",
      color: const Color(0xff474747),
      height: standardSize(context) / 1.2,
      width: standardSize(context) / 1.2,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}

standardSize1(BuildContext context) {
}


Color splashColor() {
  return Colors.grey.shade200;
}