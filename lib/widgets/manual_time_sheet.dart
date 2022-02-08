import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:attendance/theme/colors.dart';
import 'package:attendance/theme/dimens.dart';
import 'package:attendance/utilities/animations.dart';

void customBottomSheet(
    BuildContext context, VoidCallback openOnTap, exitOnTap) {

  var theme = Theme.of(context);

  showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: true,
    isDismissible: true,
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(largeSize(context)),
        topLeft: Radius.circular(largeSize(context)),
      ),
    ),
    builder: (context) {
      return Container(
        margin: EdgeInsets.only(
            left: largeSize(context), right: standardSize(context)),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: largeSize(context), bottom: standardSize(context)),
                  height: xxSmallSize(context),
                  width: xxlargeSize(context) / 1.4,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(mediumSize(context))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FadeAnimation(
                      1,
                      Container(
                        alignment: Alignment.center,
                        width: fullWidth(context) / 2.5,
                        margin: EdgeInsets.only(
                          top: smallSize(context),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      xSmallSize(context)),
                                  side: const BorderSide(
                                      width: 2,
                                      color: AppColors.primaryColor))),
                          onPressed: openOnTap,
                          child: Container(
                            width: fullWidth(context),
                            height: xxlargeSize(context) * 2.6,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/sign-in.png',
                                    color: AppColors.primaryColor,
                                    height: xxlargeSize(context) * 1.6,
                                  ),
                                  Text("ورود",
                                      style: theme.textTheme.subtitle1!
                                          .copyWith(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeAnimation(
                      1,
                      Container(
                        alignment: Alignment.center,
                        width: fullWidth(context) / 2.5,
                        margin: EdgeInsets.only(
                          top: smallSize(context),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(xSmallSize(context)))
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      xSmallSize(context)),
                                  side: const BorderSide(
                                      width: 2,
                                      color: AppColors.primaryColor))),
                          onPressed: exitOnTap,
                          child: Container(
                            width: fullWidth(context),
                            height: xxlargeSize(context) * 2.6,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/log-out.png',
                                    color: AppColors.primaryColor,
                                    height: xxlargeSize(context) * 1.1,
                                  ),
                                  Text("خروج",
                                      style: theme.textTheme.subtitle1!
                                          .copyWith(
                                          color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      );
    },
  );
}
