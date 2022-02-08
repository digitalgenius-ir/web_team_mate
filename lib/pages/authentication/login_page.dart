import 'package:attendance/pages/authentication/widget_txt_feild.dart';
import 'package:attendance/transition/slide_transtion.dart';
import 'package:attendance/widgets/progress_button_animation/progress_button_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attendance/pages/authentication/authentication_notifier.dart';
import 'package:attendance/pages/authentication/sign_up_page.dart';
import 'package:attendance/pages/authentication/verification_page.dart';
import 'package:attendance/theme/colors.dart';
import 'package:attendance/theme/dimens.dart';
import 'package:attendance/utilities/animations.dart';
import 'package:attendance/utilities/close_keybored.dart';
import 'package:attendance/utilities/onBackClick.dart';
import 'package:attendance/widgets/progress_button.dart';
import 'package:stacked/stacked.dart';
import 'package:attendance/widgets/sign_up_dialog.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  String phoneNumber;

  LoginPage({Key? key, this.phoneNumber = ''}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final textFieldKey = GlobalKey<FormState>();
  double imageOpacity = 1;
  TextEditingController? textFieldController;

  @override
  void initState() {
    textFieldController = TextEditingController(text: widget.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).viewInsets.bottom != 0){
      setState(() {
        imageOpacity = 0;
      });
    }

    var theme = Theme.of(context);
    return ViewModelBuilder<AuthenticationVM>.reactive(
        viewModelBuilder: () => AuthenticationVM(),
        disposeViewModel: true,
        builder: (context, model, child) => WillPopScope(
              onWillPop: () {
                return onBackClicked(context,
                    description: 'آیا میخواهید از برنامه خارج شوید ؟',
                    title: 'خروج از برنامه', okOnPressed: () {
                  SystemNavigator.pop();
                });
              },
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: AppColors.background,
                  bottomNavigationBar:
                  AnimatedButton(
                    isProgress:
                      model.busy(model.sendCode),
                      onTap:  () {
                        if (textFieldKey.currentState!.validate()) {
                          closeKeybored(context);
                          model.verifyPhoneNumber(
                              context, textFieldController?.text ?? '', false);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                        }
                      },
                    child: SlideFadeTranstion(
                      animationDuration: const Duration(milliseconds: 500),
                      delayStart: const Duration(milliseconds: 200),
                      offset: 5,
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Center(child: Text("ادامه",
                      style:  TextStyle(
                          fontSize: fullWidth(context) > 600
                              ? fullWidth(context) / 34
                              : fullWidth(context) / 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      )),
                    ),

                  ),


                  // Container(
                  //   margin: EdgeInsets.only(
                  //       right: xlargeSize(context),
                  //       left: xlargeSize(context),
                  //       bottom: xxlargeSize(context)),
                  //     width: fullWidth(context),
                  //     child: progressButton(
                  //         context, "ادامه", model.busy(model.sendCode), () {
                  //       if (textFieldKey.currentState!.validate()) {
                  //         closeKeybored(context);
                  //         model.verifyPhoneNumber(
                  //             context, textFieldController?.text ?? '', false);
                  //         // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  //       }
                  //     })),

                  body: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          right: xlargeSize(context),
                          left: xlargeSize(context),
                          top: fullHeight(context) / 12,
                      ),
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (OverscrollIndicatorNotification overScroll) {
                          overScroll.disallowGlow();
                          return true;
                        },
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: SizedBox(
                                  height: fullHeight(context) / 4,
                                  child: Image.asset(
                                    "assets/login.png",
                                    fit: BoxFit.cover,
                                  )),
                            ), // this is logo
                              Container(
                                margin: EdgeInsets.only(top: largeSize(context)),
                                child: Text(
                                  "به اپلیکیشن هوشمند حضور و غیاب آنلاین\nخوش آمدید .",
                                  style: theme.textTheme.headline5!
                                      .copyWith(color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            Container(
                              margin: EdgeInsets.only(
                                top: largeSize(context),
                              ),
                              child:
                                Text(
                                  "لطفا برای ورود به نرم افزار شماره تلفن تان وارد کنید .",
                                  style: theme.textTheme.subtitle1!
                                      .copyWith(color: Colors.grey),
                                ),
                              ),

                                                   // d8EditTextStyle("shooz",isPassword: false),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(mediumSize(context)),
                                  color: Colors.transparent,

                                ),
                                child: Form(

                                  key: textFieldKey,
                                  child: Container(

                                    margin: EdgeInsets.only(
                                        top: xxlargeSize(context)),
                                    child:

                                    TextFormField(


                                      onChanged: (value) {
                                        widget.phoneNumber = value;
                                      },
                                      controller: textFieldController,
                                      maxLength: 11,
                                      maxLines: 1,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "لطفا فیلد را تکمیل کنید";
                                        } else if (!value.startsWith("09") ||
                                            value.length < 11) {
                                          return "شماره تلفن معتبر نیست";
                                        }
                                        return null;
                                      },
                                      style: TextStyle(
                                          fontSize: fullWidth(context) > 600
                                              ? fullWidth(context) / 35
                                              : fullWidth(context) / 25,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.go,


                                      decoration: InputDecoration(

                                        contentPadding: const EdgeInsets.only(top: 30,bottom: 0,right: 12,left: 0),

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
                                        labelText: "شماره تلفن",
                                        // hintText: "شماره تلفن",
                                        labelStyle: theme.textTheme.subtitle2!.copyWith(color: Colors.black38,fontWeight: FontWeight.w600,fontSize: 14),
                                        hintStyle: theme.textTheme.subtitle1!
                                            .copyWith(
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
