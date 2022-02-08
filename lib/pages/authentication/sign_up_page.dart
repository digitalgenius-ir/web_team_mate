// ignore_for_file: unnecessary_null_comparison

import 'package:attendance/transition/slide_transtion.dart';
import 'package:attendance/widgets/progress_button_animation/progress_button_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as prefix;
import 'package:line_icons/line_icons.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:attendance/enums/snackbar_type.dart';
import 'package:attendance/pages/authentication/authentication_notifier.dart';
import 'package:attendance/pages/authentication/login_page.dart';
import 'package:attendance/pages/authentication/verification_page.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/theme/colors.dart';
import 'package:attendance/theme/dimens.dart';
import 'package:attendance/utilities/animations.dart';
import 'package:attendance/utilities/close_keybored.dart';
import 'package:attendance/utilities/onBackClick.dart';
import 'package:attendance/web_models/sign_up_web_model.dart';
import 'package:attendance/widgets/no_internet_page.dart';
import 'package:attendance/widgets/progress_button.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpPage extends StatefulWidget {
  String phoneNumber = '';

  SignUpPage(this.phoneNumber, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {

  final SnackbarService _snackBarService = locator<SnackbarService>();

  final textFieldKey = GlobalKey<FormState>();
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? passwordController;

  String passwordError = '';

  String? phoneNumber;

  late DateTime _birthDay = DateTime(1);
  prefix.DateFormat formatter = prefix.DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
  String formattedDate = '';

  bool isObscure = true;

  setBirthDay(DateTime opTime) {
    _birthDay = opTime;
  }

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    passwordController = TextEditingController();
    formattedDate = formatter.format(_birthDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<AuthenticationVM>.reactive(
        viewModelBuilder: () => AuthenticationVM(),
        disposeViewModel: true,
        builder: (context, model, child) {
          return WillPopScope(
            onWillPop: () => onBackClicked(
              context,
              description: 'آیا میخواهید از این صفحه خارج شوید ؟',
              title: 'خروج از صفحه',
              okOnPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                          phoneNumber: widget.phoneNumber),
                    ));
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                resizeToAvoidBottomInset: true,

                bottomNavigationBar: AnimatedButton(isProgress: model.isBusy, onTap:  () {
                  closeKeybored(context);
                  if (textFieldKey.currentState!
                      .validate()) {
                    model.signUpData(
                        context,
                        widget.phoneNumber,
                        firstNameController?.value.text ?? '',
                        lastNameController?.value.text ?? '',
                        passwordController?.value.text ?? '',
                        // '2003',
                        formattedDate,
                        '',
                        '',
                        // index: index
                    );

                  }
                }, child:
                SlideFadeTranstion(
                  animationDuration: const Duration(milliseconds: 500),
                  delayStart: const Duration(milliseconds: 200),
                  offset: 5,
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: Center(child: Text("ثبت نام",
                    style:  TextStyle(
                        fontSize: fullWidth(context) > 600
                            ? fullWidth(context) / 34
                            : fullWidth(context) / 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
                ),),
                // resizeToAvoidBottomPadding: true,
                backgroundColor: AppColors.background,

                body: model.hasError ? NoInternetWidget((){model.initialise();}) : GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),

                    child: Form(
                      key: textFieldKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: fullHeight(context) / 18),
                              height: fullHeight(context) / 4,
                              child: FadeAnimation(
                                  1,
                                  Image.asset(
                                    "assets/login.png",
                                  )),
                            ),
                          ), // this is logo
                          Container(
                            margin: EdgeInsets.only(
                              top: fullHeight(context) / 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                FadeAnimation(
                                  1,
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: mediumSize(context),
                                        right: xlargeSize(context),
                                        left: xlargeSize(context)),
                                    child: Text(
                                      "نام",
                                      style: theme.textTheme.subtitle1!
                                          .copyWith(color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                FadeAnimation(
                                  1,
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: xlargeSize(context),
                                        left: xlargeSize(context)),
                                    child: TextFormField(
                                      onChanged: (value) {},
                                      controller: firstNameController,
                                      maxLines: 1,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "لطفا فیلد را تکمیل کنید";
                                        }
                                        return null;
                                      },
                                      style: theme.textTheme.subtitle1,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(top: 30,bottom: 0,right: 12,left: 0),

                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black54),
                                            gapPadding: 0.0,
                                            borderRadius: BorderRadius.circular(
                                                smallSize(context))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors.accentColor),
                                            gapPadding: 0.0,
                                            borderRadius: BorderRadius.circular(
                                                smallSize(context))),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors.accentColor),
                                            gapPadding: 0.0,
                                            borderRadius: BorderRadius.circular(
                                                smallSize(context))),
                                        // hintText: "نام",
                                        labelText: "نام",
                                        labelStyle: theme.textTheme.subtitle2!.copyWith(color: Colors.black38,fontWeight: FontWeight.w600,fontSize: 14),

                                        hintStyle: theme.textTheme.subtitle1!
                                            .copyWith(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: mediumSize(context),
                                      bottom: mediumSize(context),
                                      right: xlargeSize(context),
                                      left: xlargeSize(context)),
                                  child: Text(
                                    "نام خانوادگی",
                                    style: theme.textTheme.subtitle1!
                                        .copyWith(color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                FadeAnimation(
                                  1,
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: xlargeSize(context),
                                        left: xlargeSize(context)),
                                    child: TextFormField(
                                      onChanged: (value) {},
                                      controller: lastNameController,
                                      maxLines: 1,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "لطفا فیلد را تکمیل کنید";
                                        }
                                        return null;
                                      },
                                      style: theme.textTheme.subtitle1,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(top: 30,bottom: 0,right: 12,left: 0),

                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black54),
                                            gapPadding: 0.0,
                                            borderRadius: BorderRadius.circular(
                                                smallSize(context))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors.accentColor),
                                            gapPadding: 0.0,
                                            borderRadius: BorderRadius.circular(
                                                smallSize(context))),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors.accentColor),
                                            gapPadding: 0.0,
                                            borderRadius: BorderRadius.circular(
                                                smallSize(context))),
                                        // hintText: "نام خانوادگی",
                                          labelText: "نام خانوادگی",
                                        labelStyle: theme.textTheme.subtitle2!.copyWith(color: Colors.black38,fontWeight: FontWeight.w600,fontSize: 14),

                                        hintStyle: theme.textTheme.subtitle1!
                                            .copyWith(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: mediumSize(context),
                                      bottom: mediumSize(context),
                                      right: xlargeSize(context),
                                      left: xlargeSize(context)),
                                  child: Text(
                                    "رمز عبور",
                                    style: theme.textTheme.subtitle1!
                                        .copyWith(color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                FadeAnimation(
                                  1,
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: xlargeSize(context),
                                        left: xlargeSize(context)),
                                    child: TextFormField(
                                      onChanged: (value) {},
                                      controller: passwordController,
                                      maxLines: 1,
                                      textDirection: TextDirection.rtl,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "لطفا فیلد را تکمیل کنید";
                                        }
                                        return null;
                                      },
                                      style: GoogleFonts.roboto(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w400),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      obscureText: isObscure,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(top: 30,bottom: 0,right: 12,left: 0),

                                        suffixIcon: Container(
                                          // margin: EdgeInsets.only(
                                          //     right: xxSmallSize(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isObscure = !isObscure;
                                              });
                                            },
                                            child: Icon(
                                              isObscure == false
                                                  ? LineIcons.eyeSlash
                                                  : LineIcons.eye,
                                              size: iconSize(context),
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.black54),
                                            gapPadding: 0.0,
                                            borderRadius: BorderRadius.circular(
                                                smallSize(context))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors.accentColor),
                                            gapPadding: 0.0,
                                            borderRadius: BorderRadius.circular(
                                                smallSize(context))),
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: AppColors.accentColor),
                                            gapPadding: 0.0,
                                            borderRadius: BorderRadius.circular(
                                                smallSize(context))),
                                        // hintText: "رمز عبور",
                                        labelText: "رمز عبور",
                                        labelStyle: theme.textTheme.subtitle2!.copyWith(color: Colors.black38,fontWeight: FontWeight.w600,fontSize: 14),

                                        hintStyle: theme.textTheme.subtitle1!
                                            .copyWith(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w600),
                                        helperMaxLines: 4,

                                        helperText: "رمز عبور باید حداقل 6 رقم و تشکیل شده از حداقل یک عدد ، یک حرف انگلیسی بزرگ، یک حرف انگلیسی کوچک  و یکی از اشکال ویژه (@-#) باشد",
                                        helperStyle: theme.textTheme.bodyText2!
                                            .copyWith(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: mediumSize(context),
                                      bottom: mediumSize(context),
                                      right: xlargeSize(context),
                                      left: xlargeSize(context)),
                                  child: Text(
                                    "شماره همراه",
                                    style: theme.textTheme.subtitle1!
                                        .copyWith(color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: xSmallSize(context),vertical: 12),
                                  width: fullWidth(context),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black54
                                    ),
                                      borderRadius: BorderRadius.circular(
                                      smallSize(context))
                                  ),
                                  margin: EdgeInsets.only(
                                      right: xlargeSize(context),
                                      left: xlargeSize(context)),
                                  child: Text(widget.phoneNumber,style: theme.textTheme.subtitle1,),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: mediumSize(context),
                                      bottom: mediumSize(context),
                                      right: xlargeSize(context),
                                      left: xlargeSize(context)),
                                  child: Text(
                                    "جنسیت",
                                    style: theme.textTheme.subtitle1!
                                        .copyWith(color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: xlargeSize(context),
                                      left: xlargeSize(context)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            model.getGenderType(0);
                                          });
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              Text(
                                                "مـرد",
                                                style: theme
                                                    .textTheme.subtitle1!
                                                    .copyWith(
                                                        color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                              Container(
                                                height: largeSize(context),
                                                width: largeSize(context),
                                                margin: EdgeInsets.only(
                                                    right:
                                                        standardSize(context)),
                                                child: Stack(children: [
                                                  AnimatedOpacity(
                                                    opacity: model.gender == 0
                                                        ? 0
                                                        : 1,
                                                    duration: Duration(
                                                        milliseconds: 350),
                                                    child: Image.asset(
                                                      'assets/empty_checkbox.png',
                                                      height:
                                                          largeSize(context),
                                                    ),
                                                  ),
                                                  AnimatedOpacity(
                                                    opacity: model.gender == 0
                                                        ? 1
                                                        : 0,
                                                    duration: Duration(
                                                        milliseconds: 350),
                                                    child: Image.asset(
                                                      'assets/checkbox.png',
                                                      height:
                                                          largeSize(context),
                                                    ),
                                                  ),
                                                ]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            model.getGenderType(1);
                                          });
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          margin: EdgeInsets.only(
                                              right: xlargeSize(context)),
                                          child: Row(
                                            children: [
                                              Text(
                                                "زن",
                                                style: theme
                                                    .textTheme.subtitle1!
                                                    .copyWith(
                                                        color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                              Container(
                                                height: largeSize(context),
                                                width: largeSize(context),
                                                margin: EdgeInsets.only(
                                                    right:
                                                        standardSize(context)),
                                                child: Stack(children: [
                                                  AnimatedOpacity(
                                                    opacity: model.gender == 1
                                                        ? 0
                                                        : 1,
                                                    duration: const Duration(
                                                        milliseconds: 350),
                                                    child: Image.asset(
                                                      'assets/empty_checkbox.png',
                                                      height:
                                                          largeSize(context),
                                                    ),
                                                  ),
                                                  AnimatedOpacity(
                                                    opacity: model.gender == 1
                                                        ? 1
                                                        : 0,
                                                    duration: const Duration(
                                                        milliseconds: 350),
                                                    child: Image.asset(
                                                      'assets/checkbox.png',
                                                      height:
                                                          largeSize(context),
                                                    ),
                                                  ),
                                                ]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            model.getGenderType(99);
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: xlargeSize(context)),
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              Text(
                                                "سایر",
                                                style: theme
                                                    .textTheme.subtitle1!
                                                    .copyWith(
                                                        color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                              Container(
                                                height: largeSize(context),
                                                width: largeSize(context),
                                                margin: EdgeInsets.only(
                                                    right:
                                                        standardSize(context)),
                                                child: Stack(children: [
                                                  AnimatedOpacity(
                                                    opacity: model.gender == 99
                                                        ? 0
                                                        : 1,
                                                    duration: Duration(
                                                        milliseconds: 350),
                                                    child: Image.asset(
                                                      'assets/empty_checkbox.png',
                                                      height:
                                                          largeSize(context),
                                                    ),
                                                  ),
                                                  AnimatedOpacity(
                                                    opacity: model.gender == 99
                                                        ? 1
                                                        : 0,
                                                    duration: Duration(
                                                        milliseconds: 350),
                                                    child: Image.asset(
                                                      'assets/checkbox.png',
                                                      height:
                                                          largeSize(context),
                                                    ),
                                                  ),
                                                ]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
/*
                                Center(
                                    child: ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return



                                      Container(
                                      width: fullWidth(context),
                                      margin: EdgeInsets.only(
                                          top: fullHeight(context) / 9,
                                          bottom: largeSize(context),
                                          left: largeSize(context),
                                          right: largeSize(context)),
                                      child: progressButton(sdsd
                                          context, "ثبت نام", model.isBusy,
                                              () {
                                            closeKeybored(context);
                                        if (textFieldKey.currentState!
                                            .validate()) {
                                            model.signUpData(
                                                context,
                                                widget.phoneNumber,
                                                firstNameController?.value.text ?? '',
                                                lastNameController?.value.text ?? '',
                                                passwordController?.value.text ?? '',
                                                // '2003',
                                                formattedDate,
                                                '',
                                                '',
                                                index: index);

                                        }
                                      }),
                                    );
                                  },
                                )),
*/
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
