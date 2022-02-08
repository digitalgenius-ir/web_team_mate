import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendance/theme/dimens.dart';

Widget progressButtonSmall(
    BuildContext context, String text, bool isProgress, VoidCallback onClickAction,
    {Color? color}) {
  var theme = Theme.of(context);
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      width: fullWidth(context) / 2.5,
      child: RaisedButton(
        disabledColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(xSmallSize(context))
        ),
        padding: EdgeInsets.symmetric(vertical: xSmallSize(context)),
        color: isProgress ? Colors.grey : color,
        onPressed: isProgress ? (){} : onClickAction,
        child: isProgress
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: mediumSize(context)),
              child: Text(
                'لطفا منتظر بمانید...',
                style: TextStyle(
                    fontSize: fullWidth(context) > 600
                        ? fullWidth(context) / 34
                        : fullWidth(context) / 24,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: iconSize(context),
              height: iconSize(context),
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                backgroundColor: Colors.indigo,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
              ),
            ),
          ],
        )
            : Text(
          text,
          style: TextStyle(
              fontSize: fullWidth(context) > 600
                  ? fullWidth(context) / 34
                  : fullWidth(context) / 24,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
