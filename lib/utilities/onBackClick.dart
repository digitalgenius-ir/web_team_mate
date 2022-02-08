import 'package:flutter/material.dart';
import 'package:attendance/theme/dimens.dart';
import 'package:attendance/widgets/action_widgets.dart';

Future<bool> onBackClicked(BuildContext context,
    {required String description,
    required String title,
    required VoidCallback okOnPressed}) {
  var theme = Theme.of(context);
  showDialog(
    context: context,
    builder: (context) => Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(mediumSize(context))),
        title: Text(
          title,
          style: theme.textTheme.headline4!
              .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
        ),
        content: Text(
          description,
          style: theme.textTheme.bodyText1,
        ),
        actionsOverflowButtonSpacing: xxlargeSize(context),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              "خیر",
              style: theme.textTheme.subtitle1,
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(smallSize(context)),
              )),
              overlayColor:
                  MaterialStateColor.resolveWith((states) => splashColor()),
            ),
          ),
          TextButton(
            onPressed: okOnPressed,
            child: Text("بله",
                style: theme.textTheme.subtitle1!.copyWith(color: Colors.red)),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(smallSize(context)),
              )),
              overlayColor:
                  MaterialStateColor.resolveWith((states) => splashColor()),
            ),
          ),
        ],
      ),
    ),
  );
  return Future.value(false);
}
