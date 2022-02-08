import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendance/theme/colors.dart';
import 'package:attendance/theme/dimens.dart';

Widget progressButton(
    BuildContext context, String text, bool isProgress, VoidCallback onClickAction,
    {Color? color}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(mediumSize(context)),
        color: AppColors.darkAccentColor,
      ),
      width: fullWidth(context),
      child: ElevatedButton(
        onPressed: isProgress ? null : onClickAction,
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(mediumSize(context))),
            primary: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical:  isProgress ? mediumSize(context)/1.1 : mediumSize(context))
        ),
        child: isProgress
            ? Container(height: xlargeSize(context), width: xlargeSize(context), child: const CircularProgressIndicator(strokeWidth: 3,color: AppColors.background))
            : Text(
          text,
          style: TextStyle(
              fontSize: fullWidth(context) > 600
                  ? fullWidth(context) / 35
                  : fullWidth(context) / 25,
              color: Colors.white,
              fontFamily: "vazir",
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}