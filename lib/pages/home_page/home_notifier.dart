// ignore_for_file: use_rethrow_when_possible, avoid_print, unused_field, unnecessary_null_comparison

import 'dart:io';
import 'package:attendance/pages/authentication/login_page.dart';
import 'package:attendance/repository/log_out_repo.dart';
import 'package:attendance/web_models/log_out_web_model.dart';
import 'package:attendance/widgets/show_automatic_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:attendance/enums/snackbar_type.dart';
import 'package:attendance/repository/enter_and_exit_repo.dart';
import 'package:attendance/repository/profile_repo.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/services/preferences_service.dart';
import 'package:attendance/utilities/check_internet.dart';
import 'package:attendance/web_models/enter_and_exit_model.dart';
import 'package:attendance/web_models/profile_web_model.dart';
import 'package:attendance/web_models/simular_web_model.dart';
import 'package:attendance/widgets/success_dialog.dart';

class HomeVM extends FutureViewModel<ProfileRPM?> {
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final AppPreferences preferences = locator<AppPreferences>();
  EnterAndExitRPM? attendanceRPM;
  ProfileRPM? profileRPM;
  LogOutRPM? logOutRPM;


  final String isBusyAttendance = 'isBusyAttendance';

  String _openDate = '';

  String isBusySheet = "isBusySheet";

  String get openDate => _openDate;

  String _currentTime = DateTime.now().toString();

  String get currentTime => _currentTime;

  bool _isClick = false;

  bool get isClick => _isClick;

  String _openTime = '--:--';

  String get openTime => _openTime;

  String _exitTime = '--:--';

  String get exitTime => _exitTime;

  ///////////////time///////////////////////

  setOpenTime(String selTime) {
    _openTime = selTime;
  }

  setExitTime(String exTime) {
    _exitTime = exTime;
  }

  setIsClicked() {
    _isClick = !_isClick;
    notifyListeners();
  }

  getCurrentDate(String current) {
    _currentTime = current;
  }

  ///////////////time///////////////////////

  /////////////date//////////////////
  setOpenDate(String opTime) {
    _openDate = opTime;
  }
  DateTime setDateTimeFromString(String time) {
    DateTime date = DateFormat('yyyy/MM/dd Thh:mm:ss').parse(time);
    // 2021-12-28T14:50:46.233Z
    return date;
  }
  ///  get user profile   ////////////////////

  Future<ProfileRPM?> getProfileDataFromServer() async {
      try {
        // await checkNetConnection();
        setBusy(true);
        profileRPM =
        await runBusyFuture(prepareProfileRequest(), throwException: true)
            .catchError((error) {
          setError(error);
          setBusyForObject(isBusyAttendance, false);
          print(error);
          notifyListeners();
        });
        return profileRPM;
      } catch (e) {
        setBusyForObject(isBusyAttendance, false);
        print(e);
        throw (e);
      }



  }

  ///  onError   ////////////////////

  @override
  void onFutureError(dynamic error, Object? key) {
    print(error);
  }

  @override
  void onError(error) {
    super.onError(error);
  }

  ///  attendance data   ////////////////////

  Future<EnterAndExitRPM?> attendanceData(
      BuildContext context,
      String date,

      ) async {
    try {
      setBusyForObject(isBusySheet,true);

      await checkNetConnection();
      EnterAndExitRQM req =
      //     ?
      EnterAndExitRQM(
              id: 0,
              userID: profileRPM?.data?.ID ?? 0,
              date: date,
              // "${setDateTimeFromString(DateTime.now().toString())}",
              enter:profileRPM?.data?.IsWorking == false?
              // "${setDateTimeFromString(DateTime.now().toString())}"
              date
                  :
                  null

          ,
              exit: profileRPM?.data?.IsWorking == false?
          null :
              date
              // "${setDateTimeFromString(DateTime.now().toString())}"

          ,
              enterAgent: Platform.isAndroid
                  ? 'Android'
                  : Platform.isIOS
                      ? 'Ios'
                      : 'نامعلوم',
              exitAgent: Platform.isAndroid
                  ? 'Android'
                  : Platform.isIOS
                  ? 'Ios'
                  : 'نامعلوم',
              enterLatitude: profileRPM?.data?.IsWorking == false? '36.290894' : "",
              exitLatitude:profileRPM?.data?.IsWorking == false? '' : "36.290894",
              enterLongitude: profileRPM?.data?.IsWorking == false?'59.593339' :'',
              exitLongitude: profileRPM?.data?.IsWorking == false? '':'59.593339',
              enterStationID:profileRPM?.data?.IsWorking == false? 1 : null,
              exitStationID:profileRPM?.data?.IsWorking == false? null : 1,
              exitStationTitle: '');
      notifyListeners();
      initialise();
      setBusyForObject(isBusySheet,false);
        attendanceRPM = await runBusyFuture(prepareEnterAndExitRequest(req),
              throwException: true)
          .catchError((error) {
        setError(error);
        setBusyForObject(isBusySheet,true);
        Navigator.of(context).pop();
        print(error);
        notifyListeners();
      });
        if (attendanceRPM != null) {
          if (attendanceRPM?.Success == true) {
            setIsClicked();
            setOpenDate(Jalali.now().formatFullDate());
            if (profileRPM?.data?.IsWorking == false) {
              setOpenTime(TimeOfDay.now().format(context));
              Navigator.of(context).pop();
              _snackbarService.showCustomSnackBar(
                  message: "زمان ورود شما با موفقیت ثبت شد",
                  variant: SnackbarType.success,
                  duration: const Duration(milliseconds: 3000));
              initialise();
              notifyListeners();
            } else if((profileRPM?.data?.IsWorking == true)) {
              setExitTime(TimeOfDay.now().format(context));
              Navigator.of(context).pop();
              _snackbarService.showCustomSnackBar(
                  message: "زمان خروج شما با موفقیت ثبت شد",
                  variant: SnackbarType.success,
                  duration: const Duration(milliseconds: 3000));
              initialise();
              notifyListeners();

            }
          }
        }

      else {
        setError("error in result");
        // print("error");
      }
      return attendanceRPM;
    } catch (e) {
      setBusyForObject(isBusySheet,false);
      if (e is String) {
        _snackbarService.showCustomSnackBar(
            // message: 'لطفا فیلد ها را با دقت کامل کنید',
            message: e,
            variant: SnackbarType.error,
            duration: const Duration(milliseconds: 3000));
      } else {
        _snackbarService.showCustomSnackBar(
            // message: 'لطفا با فیلد ها را با دقت کامل کنید',
            message:
                "در هر شیفت کاری فقط یک بار اجازۀ ثبت ورود و خروج را دارید",
                // "$e",
            variant: SnackbarType.message,
            duration: const Duration(milliseconds: 3000));
      }
      print(e);
      throw (e);
    }
  }

  Future<LogOutRPM?> logOut(
      BuildContext context) async {
    try {
      // await checkNetConnection();
      setBusy(true);
      logOutRPM = await prepareLogOutRequest();
      if (logOutRPM != null) {
        if (logOutRPM?.Success == true) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      } else {
        setError("error in result");
        print("error");
      }
      return logOutRPM;
    } catch (e) {
      setBusy(false);
      _snackbarService.showCustomSnackBar(
        // message: 'لطفا فیلد ها را با دقت کامل کنید',
          message: '$e',
          variant: SnackbarType.error,
          duration: const Duration(milliseconds: 3000));
      print(e);
      throw (e);
    }
  }

  @override
  Future<ProfileRPM?> futureToRun() => getProfileDataFromServer();
}
