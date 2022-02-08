import 'dart:async';
import 'package:attendance/web_models/simular_web_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:attendance/enums/snackbar_type.dart';
import 'package:attendance/enums/timer_status.dart';
import 'package:attendance/pages/authentication/login_page.dart';
import 'package:attendance/pages/authentication/verification_page.dart';
import 'package:attendance/pages/home_page/home_page.dart';
import 'package:attendance/repository/login_repo.dart';
import 'package:attendance/repository/sign_up_repo.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/services/preferences_service.dart';
import 'package:attendance/utilities/check_internet.dart';
import 'package:attendance/web_models/login_web_model.dart';
import 'package:attendance/web_models/sign_up_web_model.dart';
import 'package:attendance/web_models/verify_phone_number_web_model.dart';
import 'package:attendance/repository/verify_phone_number_repo.dart';
import 'package:attendance/widgets/sign_up_dialog.dart';

class AuthenticationVM extends FutureViewModel {
  ///locator///
  final AppPreferences pref = locator<AppPreferences>();

  final SnackbarService _snackBarService = locator<SnackbarService>();


  VerifyPhoneNumberRPM? verifyRPM;

  SignUpRPM? signUpRPM;

  LoginRPM? loginRPM;

  bool isSendingCode = false;

  String sendCode = 'SendCode';

  Timer? timerCode;

  Timer? timer;

  int _gender = 0;

  int get gender => _gender;

  TimerStatus timerStatue = TimerStatus.set;

  final Duration _timerDuration = const Duration(minutes: 2, seconds: 0);

  int _restTimerDurationInSeconds = 3 * 60;

  String timerDurationAsString = '2:00';

  String _phone = "";

  String get phone => _phone;

  getPhoneNumber(String phoneNumber) {
    _phone = phoneNumber;
    notifyListeners();
  }

  getGenderType(int gender) {
    _gender = gender;
    notifyListeners();
  }

  /// Timer Code ///

  void _startTimer({int? seconds}) {
    const oneSecondPeriod = Duration(seconds: 1);

    if ((timerCode != null) && (timerCode?.isActive ?? false)) {
      timerCode?.cancel();
    }

    timerCode = Timer.periodic(
      oneSecondPeriod,
      (timer) {
        if (timerStatue == TimerStatus.started) _restTimerDurationInSeconds--;
        timerDurationAsString = _durationAsString(
            duration: Duration(seconds: _restTimerDurationInSeconds));
        notifyListeners();

        if (_restTimerDurationInSeconds == 0) {
          timerStatue = TimerStatus.finished;
          timer.cancel();
          notifyListeners();
        }
      },
    );
  }

  String _durationAsString({required Duration duration}) {
    String twoDigitMinutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    return '$twoDigitMinutes : $twoDigitSeconds';
  }

  Future? controlButtonTimer() {
    switch (timerStatue) {
      case TimerStatus.set:
        _restTimerDurationInSeconds = _timerDuration.inSeconds;
        _startTimer(seconds: _restTimerDurationInSeconds);
        timerStatue = TimerStatus.started;
        timerDurationAsString = _durationAsString(
            duration: Duration(seconds: _restTimerDurationInSeconds));
        notifyListeners();
        break;
      case TimerStatus.finished:
        _restTimerDurationInSeconds = _timerDuration.inSeconds;
        _startTimer(seconds: _restTimerDurationInSeconds);
        timerStatue = TimerStatus.started;
        notifyListeners();
        break;
      case TimerStatus.started:
        // TODO: Handle this case.
        break;
    }
  }

  ///  VerifyPhoneNumber   ////////////////////

  Future<VerifyPhoneNumberRPM?> verifyPhoneNumber(
      BuildContext context, String phoneNumber, bool isResendCode) async {
    try {
      // await checkNetConnection();

      getPhoneNumber(phoneNumber);
      VerifyPhoneNumberRQM req = VerifyPhoneNumberRQM(
        phoneNumber: phoneNumber,
      );
      setBusyForObject(sendCode, true);
      verifyRPM =
          await runBusyFuture(prepareVerifyRequest(req), throwException: true)
              .catchError((error) {
        setError(error);
        setBusyForObject(sendCode, false);
        showSignUpDialog(context, 'کاربری با این شماره تلفن یافت نشد',
            phoneNumber: phoneNumber);
        print(error);
        notifyListeners();
      });
      if (verifyRPM != null) {
        if (verifyRPM?.Success == true) {
          if (isResendCode == false) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => VerificationPage(
                          phoneNumber: phoneNumber,
                          userID: verifyRPM?.data?.UserID ?? 0,
                          code: verifyRPM?.data?.Code.toString() ?? '',
                          notificationToken:
                              verifyRPM?.data?.NotificationToken ?? '',
                          deviceID: verifyRPM?.data?.DeviceID ?? '',
                          expireDate: verifyRPM?.data?.ExpireDate ?? '',
                          id: verifyRPM?.data?.ID ?? 0,
                        )));
          } else {
            _snackBarService.showCustomSnackBar(
                // message: 'لطفا فیلد ها را با دقت کامل کنید',
                message: 'کد ارسال شد',
                variant: SnackbarType.success,
                duration: const Duration(milliseconds: 3000));
          }
        }
      } else {
        setError("error in result");
        print("error");
      }
      return verifyRPM;
    } catch (e) {
      if (e is String) {
        _snackBarService.showCustomSnackBar(
            // message: 'لطفا با فیلد ها را با دقت کامل کنید',
            message: e,
            variant: SnackbarType.error,
            duration: const Duration(milliseconds: 2500));
      }
      setBusyForObject(sendCode, false);
      print(e);
      throw (e);
    }
  }

  ///  Log In   ////////////////////

  Future<LoginRPM?> login(
    BuildContext context,
    String code,
    String deviceID,
    String expireDate,
    int id,
    String notificationToken,
    int userID,
  ) async {
    try {

      // await checkNetConnection();

      LoginRQM req = LoginRQM(
        code: int.parse(code),
        deviceID: deviceID,
        expireDate: expireDate,
        id: id,
        notificationToken: notificationToken,
        userID: userID,
      );
      setBusy(true);
      loginRPM =
          await runBusyFuture(prepareLogInRequest(req), throwException: true)
              .catchError((error) {
        setError(error);
        setBusy(false);
        _snackBarService.showCustomSnackBar(
            message: 'کد صحیح نمیباشد',
            variant: SnackbarType.error,
            duration: const Duration(milliseconds: 3000));
        print(error);
        notifyListeners();
      });
      if (loginRPM != null) {
        pref.isFirstTimeLaunch = false;
        if (loginRPM?.Success == true) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomePage()));
          pref.token = loginRPM?.data?.Token ?? '';
          pref.user=loginRPM?.data?.user ?? User();
        }
      } else {
        setError("error in result");
        isSendingCode = false;
        print("error");
      }
      return loginRPM;
    } catch (e) {
      setBusy(false);
      _snackBarService.showCustomSnackBar(
          // message: 'لطفا فیلد ها را با دقت کامل کنید',
          message: '$e',
          variant: SnackbarType.error,
          duration: const Duration(milliseconds: 3000));
      print(e);
      throw (e);
    }
  }

  ///  Sign Up   ////////////////////

  Future<SignUpRPM?> signUpData(
      BuildContext context,
      String phoneNumber,
      String firstName,
      String lastName,
      String password,
      String birthDate,
      String address,
      String bio,
      // {required int index}
      ) async {
    try {
      await checkNetConnection();
      SignUpRQM req = SignUpRQM(
          firstName: firstName,
          lastName: lastName,
          password: password,
          phoneNumber: phoneNumber,
          address: address,
          bio: bio,
          birthdate: birthDate,
          gender: gender);
      setBusy(true);
      signUpRPM =
          await runBusyFuture(prepareSignUpRequest(req), throwException: true)
              .catchError((error) {
        setError(error);
        setBusy(false);
        debugPrint('$error');
        notifyListeners();
      });
      if (signUpRPM != null) {
        if (signUpRPM?.Success == true) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPage(phoneNumber: phoneNumber)));
        }
      } else {
        setError("error in result");
        // print("error");
      }
      pref;
      return signUpRPM;
    } catch (e) {
      setBusy(false);
      _snackBarService.showCustomSnackBar(
          // message: 'لطفا با فیلد ها را با دقت کامل کنید',
          message:
              'رمز عبور باید حداقل از یک عدد ، یک حرف انگلیسی بزرگ ، یک حرف انگلیسی کوچک ، و یکی از اشکال ویژه (@-#) باشد',
          variant: SnackbarType.error,
          duration: const Duration(milliseconds: 4000));
      throw (e);

      //  if(e == 422){
      // }else{
      //   // _snackBarService.showCustomSnackBar(
      //   //   // message: 'لطفا فیلد ها را با دقت کامل کنید',
      //   //     message: e.toString(),
      //   //     variant: SnackbarType.error,
      //   //     duration: Duration(milliseconds: 3000));
      // }
      // print(e);
      // throw (e);
    }
  }

  ///  onError   ////////////////////

  @override
  void onFutureError(dynamic error, Object? key) {
    print(error);
  }

  /// SnackBar Message ///

  @override
  void onError(error) {
    super.onError(error);
  }

  @override
  Future futureToRun() async {}
}
