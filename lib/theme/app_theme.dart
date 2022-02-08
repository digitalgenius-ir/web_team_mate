import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attendance/widgets/action_widgets.dart';
import 'colors.dart';
class AppTheme {
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.darkPrimaryColor,
    primaryColorLight: AppColors.lightPrimaryColor,
    accentColor: AppColors.accentColor,
    // ignore: deprecated_member_use
    accentIconTheme: const IconThemeData(color: AppColors.iconColorPlayer),
    backgroundColor: AppColors.background,
    // ignore: deprecated_member_use
    appBarTheme: const AppBarTheme(brightness: Brightness.dark, centerTitle: true),
    fontFamily: 'vazir',
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 26, fontWeight: FontWeight.w700, color: Colors.black),
      headline2: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      headline3: TextStyle(
          fontSize: 19, color: Colors.black54, fontWeight: FontWeight.w500),
      headline4: TextStyle(
          color: AppColors.textColorDark,
          fontSize: 18),
      headline5: TextStyle(fontSize: 17,color: Colors.black),
      headline6: TextStyle(fontSize: 16,color: Colors.black),
      subtitle1: TextStyle(
          fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600),
      subtitle2: TextStyle(
          fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w400),
      bodyText1: TextStyle(
          fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w600),
      bodyText2: TextStyle(
          fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w300),
      caption: TextStyle(
          fontSize: 8, color: Colors.black54, fontWeight: FontWeight.w400),
    ),
iconTheme: const IconThemeData(color: Colors.black),
scaffoldBackgroundColor: AppColors.background,
    splashColor: splashColor(),

    bottomAppBarColor: AppColors.darkAccentColor,
    dividerColor: AppColors.textColorDark,
    buttonTheme: ButtonThemeData(
        padding: const EdgeInsets.all(12),
        buttonColor: AppColors.primaryColor,
        disabledColor: Colors.black38,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(10.0),
        )), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.accentColor),
  );
}