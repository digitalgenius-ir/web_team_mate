import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:attendance/app/app.router.dart';
import 'package:attendance/pages/authentication/sign_up_page.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/theme/colors.dart';
import 'package:attendance/theme/dimens.dart';

void showSignUpDialog(BuildContext context, String title, {required String phoneNumber}) {
  NavigationService navigationService = locator<NavigationService>();
  var theme = Theme.of(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          height: fullWidth(context) / 1.3,
          width: fullWidth(context),
          decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: BorderRadius.circular(smallSize(context))),
          child: Column(
            children: [
              Spacer(),

              // SizedBox(
              //   height: mediumSize(context),
              // ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(standardSize(context)),
                decoration: BoxDecoration(
                    color: const Color(0xfff0f0f6),
                    borderRadius: BorderRadius.circular(standardSize(context))),
                width: fullWidth(context) / 4.5,
                height: fullWidth(context) / 4.5,
                child: Image.asset('assets/attention.png'),
              ),
              Spacer(),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: xxSmallSize(context)),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline5!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: xxSmallSize(context)),
                  child: Text(
                    "برای ثبت نام روی دکمه تایید بزنید",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.subtitle1!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  navigationService.pushNamedAndRemoveUntil(Routes.signUpPage,arguments: SignUpPageArguments(phoneNumber: phoneNumber));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediumSize(context),
                        vertical: smallSize(context)),
                    primary: const Color(0xfff0f0f6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(smallSize(context)),
                    )),
                child: Text(
                  'تایید',
                  style: theme.textTheme.subtitle1,
                ),
              ),
              // SizedBox(
              //   height: smallSize(context),
              // ),
              Spacer(),

            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(smallSize(context))),
        contentPadding: const EdgeInsets.all(1),
      );
    },
  );
}
