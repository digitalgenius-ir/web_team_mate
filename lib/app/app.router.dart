// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../pages/authentication/login_page.dart';
import '../pages/authentication/sign_up_page.dart';
import '../pages/authentication/verification_page.dart';
import '../pages/home_page/home_page.dart';
import '../pages/splash_page/splash_page.dart';

class Routes {
  static const String splashPage = '/';
  static const String homePage = '/home-page';
  static const String verificationPage = '/verification-page';
  static const String loginPage = '/login-page';
  static const String signUpPage = '/sign-up-page';
  static const all = <String>{
    splashPage,
    homePage,
    verificationPage,
    loginPage,
    signUpPage,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashPage, page: SplashPage),
    RouteDef(Routes.homePage, page: HomePage),
    RouteDef(Routes.verificationPage, page: VerificationPage),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.signUpPage, page: SignUpPage),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SplashPage(),
        settings: data,
      );
    },
    HomePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomePage(),
        settings: data,
      );
    },
    VerificationPage: (data) {
      var args = data.getArgs<VerificationPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerificationPage(
          key: args.key,
          phoneNumber: args.phoneNumber,
          userID: args.userID,
          notificationToken: args.notificationToken,
          code: args.code,
          id: args.id,
          expireDate: args.expireDate,
          deviceID: args.deviceID,
        ),
        settings: data,
      );
    },
    LoginPage: (data) {
      var args = data.getArgs<LoginPageArguments>(
        orElse: () => LoginPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginPage(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
        settings: data,
      );
    },
    SignUpPage: (data) {
      var args = data.getArgs<SignUpPageArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpPage(
          args.phoneNumber,
          key: args.key,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// VerificationPage arguments holder class
class VerificationPageArguments {
  final Key? key;
  final String phoneNumber;
  final int userID;
  final String notificationToken;
  final String code;
  final int id;
  final String expireDate;
  final String deviceID;
  VerificationPageArguments(
      {this.key,
      required this.phoneNumber,
      required this.userID,
      required this.notificationToken,
      required this.code,
      required this.id,
      required this.expireDate,
      required this.deviceID});
}

/// LoginPage arguments holder class
class LoginPageArguments {
  final Key? key;
  final String phoneNumber;
  LoginPageArguments({this.key, this.phoneNumber = ''});
}

/// SignUpPage arguments holder class
class SignUpPageArguments {
  final String phoneNumber;
  final Key? key;
  SignUpPageArguments({required this.phoneNumber, this.key});
}
