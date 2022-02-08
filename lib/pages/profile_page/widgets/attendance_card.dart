import 'package:flutter/material.dart';
import 'package:attendance/theme/colors.dart';
import 'package:attendance/theme/dimens.dart';

Widget attendanceCard(BuildContext context) {
  var theme = Theme.of(context);
  return Container(
    width: fullWidth(context),
    margin: EdgeInsets.only(bottom: mediumSize(context)),
    padding: EdgeInsets.symmetric(
        horizontal: standardSize(context), vertical: mediumSize(context)),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(smallSize(context)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("دوشنبه", style: theme.textTheme.bodyText1),
            Container(
                margin: EdgeInsets.only(top: xSmallSize(context)),
                child: Text("2/9/1400", style: theme.textTheme.subtitle1)),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ورود :",
                style: theme.textTheme.subtitle1!
                    .copyWith(color: AppColors.primaryColor)),
            Container(
              margin: EdgeInsets.only(top: xSmallSize(context)),
              child: Text("خروج :",
                  style: theme.textTheme.subtitle1!
                      .copyWith(color: AppColors.primaryColor)),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(right: xSmallSize(context)),
                child: Text("09 : 9",
                    style: theme.textTheme.subtitle1!
                        .copyWith(color: Colors.black))),
            Container(
                margin: EdgeInsets.only(
                    right: xSmallSize(context), top: xSmallSize(context)),
                child: Text("18 : 20",
                    style: theme.textTheme.subtitle1!
                        .copyWith(color: Colors.black))),
          ],
        ),
      ],
    ),
  );
}
