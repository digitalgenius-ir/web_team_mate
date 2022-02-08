import 'package:attendance/transition/slide_transtion.dart';
import 'package:attendance/widgets/progress_button_animation/progress_button_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:attendance/enums/snackbar_type.dart';
import 'package:attendance/enums/timer_status.dart';
import 'package:attendance/pages/authentication/login_page.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/theme/colors.dart';
import 'package:attendance/theme/dimens.dart';
import 'package:attendance/utilities/animations.dart';
import 'package:attendance/utilities/close_keybored.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

import 'authentication_notifier.dart';

class VerificationPage extends StatefulWidget {
  final String phoneNumber;
  final int id;
  final String code;
  final int userID;
  final String notificationToken;
  final String deviceID;
  final String expireDate;

  const VerificationPage({
    Key? key,
    required this.phoneNumber,
    required this.userID,
    required this.notificationToken,
    required this.code,
    required this.id,
    required this.expireDate,
    required this.deviceID,
  }) : super(key: key);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String code = "";
  final textFieldKey = GlobalKey<FormState>();
  late TextEditingController pinCodeTextFieldController;

  @override
  // ignore: must_call_super
  void initState() {
    pinCodeTextFieldController = TextEditingController();
  }

  final SnackbarService _snackbarService = locator<SnackbarService>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<AuthenticationVM>.reactive(
      viewModelBuilder: () => AuthenticationVM(),
      disposeViewModel: true,
      onModelReady: (model) => model.controlButtonTimer(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async => false,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            // resizeToAvoidBottomPadding: true,
            backgroundColor: AppColors.background,
            bottomNavigationBar: AnimatedButton(

                child:SlideFadeTranstion(
              animationDuration: const Duration(milliseconds: 500),
              delayStart: const Duration(milliseconds: 200),
              offset: 5,
              curve: Curves.fastLinearToSlowEaseIn,
              child: Center(child: Text("تایید کد",
                style:  TextStyle(
                    fontSize: fullWidth(context) > 600
                        ? fullWidth(context) / 34
                        : fullWidth(context) / 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )),
            ),isProgress:  model.isBusy, onTap: () {
              if (pinCodeTextFieldController.value.text.isEmpty) {
                _snackbarService.showCustomSnackBar(
                    message: 'لطفا فیلد را با دقت پر کنید',
                    variant: SnackbarType.error,
                    duration: const Duration(milliseconds: 3000));
              } else if (pinCodeTextFieldController.value.text.length < 4 &&
                  pinCodeTextFieldController.value.text.isNotEmpty) {
                _snackbarService.showCustomSnackBar(
                    message: 'کد معتبر نیست',
                    variant: SnackbarType.error,
                    duration: const Duration(milliseconds: 3000));
              } else if (pinCodeTextFieldController.value.text != widget.code) {
                _snackbarService.showCustomSnackBar(
                    message: 'کد اشتباه است',
                    variant: SnackbarType.error,
                    duration: const Duration(milliseconds: 3000));
              } else {
                closeKeybored(context);
                model.login(
                    context,
                    pinCodeTextFieldController.text,
                    widget.deviceID,
                    widget.expireDate,
                    widget.id,
                    widget.notificationToken,
                    widget.userID);
              }
            }),
            body: Container(
              height: fullHeight(context),
              margin: EdgeInsets.only(
                  right: xlargeSize(context),
                  left: xlargeSize(context),
                  top: fullHeight(context) / 12),
              child: ListView(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      height: fullHeight(context) / 4,
                      child: FadeAnimation(
                          1,
                          Image.asset(
                            "assets/verify_code.png",
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: xlargeSize(context),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "کد شما : ",
                          style: theme.textTheme.headline6!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          model.verifyRPM?.data?.Code.toString() ?? widget.code,
                          style: theme.textTheme.headline4!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: xxlargeSize(context)),
                      child: Text(
                        "کد ارسال شد !",
                        style: theme.textTheme.headline4!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: smallSize(context),
                    ),
                    child: FadeAnimation(
                      1,
                      Text(
                        "لطفا کدی که به شماره تلفن " +
                            (widget.phoneNumber.isNotEmpty
                                ? widget.phoneNumber
                                : "") +
                            " ارسال شد را وارد کنید .",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.subtitle1!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: FadeAnimation(
                      1,
                      Container(
                          margin: EdgeInsets.only(
                              top: fullHeight(context) / 12,
                              left: standardSize(context),
                              right: standardSize(context)),
                          child: PinCodeTextField(
                            cursorColor: AppColors.accentColor,
                            controller: pinCodeTextFieldController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            textStyle: theme.textTheme.subtitle1!.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                            length: 4,
                            // animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              //todo responsive
                              borderRadius: BorderRadius.circular(16),
                              fieldHeight: 40,
                              fieldWidth: 40,
                              selectedColor: AppColors.accentColor,
                              inactiveFillColor: Colors.white,
                              disabledColor: Colors.white,
                              inactiveColor: Colors.black54,
                              selectedFillColor: Colors.white,
                              activeColor: AppColors.accentColor,
                              activeFillColor: Colors.white,
                            ),

                            animationDuration:
                                const Duration(milliseconds: 300),
                            backgroundColor: AppColors.background,
                            autovalidateMode: AutovalidateMode.always,
                            enableActiveFill: true,

                            onCompleted: (value) {
                              setState(() {
                                code = value;
                              });
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              return true;
                            },
                            appContext: context,
                            onChanged: (String value) {},
                          )),
                    ),
                  ),
                  FadeAnimation(
                    1,
                    Container(
                      margin: EdgeInsets.only(
                        top: standardSize(context),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: xxlargeSize(context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Opacity(
                              opacity: model.timerCode != null &&
                                      model.timerCode!.isActive ? 0.4
                                  : 1,
                              child: GestureDetector(
                                onTap: model.timerCode != null &&
                                        model.timerCode!.isActive
                                    ? null
                                    : () {
                                        model.verifyPhoneNumber(
                                            context, widget.phoneNumber, true);

                                        if (model.timerStatue ==
                                            TimerStatus.finished) {
                                          model.controlButtonTimer();
                                          // model.initialise();

                                        }
                                      },
                                child: Text(
                                  "ارسال مجدد کد",
                                  style: theme.textTheme.caption!.copyWith(
                                    color: Colors.black,
                                    fontSize: mediumSize(context) / 1.2,
                                  ),
                                ),
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                model.timerDurationAsString,
                                style: theme.textTheme.caption!.copyWith(
                                    color: Colors.black,
                                    fontSize: mediumSize(context) / 1.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1,
                    Container(
                      alignment: Alignment.center,
                      width: fullWidth(context),
                      child: Ink(
                        child: InkWell(
                          splashColor: Colors.grey.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(xSmallSize(context)),
                          onTap: model.isSendingCode || model.isBusy
                              ? () {}
                              : () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              // LoginPage(phoneNumber: widget.phoneNumber,),
                                              LoginPage(
                                                phoneNumber: widget.phoneNumber,
                                              )));
                                },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: xSmallSize(context),
                                vertical: xxSmallSize(context)),
                            child: Text("تعویض شماره تلفن",
                                style: theme.textTheme.subtitle1!.copyWith(
                                    color: model.isSendingCode
                                        ? Colors.grey.shade300
                                        : Colors.black)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: xxlargeSize(context) * 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
