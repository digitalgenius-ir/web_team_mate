import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:attendance/enums/snackbar_type.dart';
import 'package:attendance/pages/authentication/login_page.dart';
import 'package:attendance/repository/log_out_repo.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/services/preferences_service.dart';
import 'package:attendance/utilities/check_internet.dart';
import 'package:attendance/web_models/log_out_web_model.dart';

class ProfileVM extends FutureViewModel {

  final AppPreferences pref = locator<AppPreferences>();
  final SnackbarService snackbarService = locator<SnackbarService>();
  File? val;
  File? imageFile;

  LogOutRPM? logOutRPM;

  Future<File?> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    // val = await ImageCropper.cropImage(
    //   cropStyle: CropStyle.circle,
    //   sourcePath: pickedImage?.path ?? '',
    //   aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    //   compressQuality: 70,
    //   maxHeight: 700,
    //   maxWidth: 700,
    //   compressFormat: ImageCompressFormat.jpg,
    //   androidUiSettings: const AndroidUiSettings(
    //     toolbarColor: Colors.white,
    //     toolbarTitle: "برش تصویر",
    //   ),
    // );

    try{    if (val != null) {
      imageFile = val;
      setInitialised(true);
    }}catch(e){
      throw(e);
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
      snackbarService.showCustomSnackBar(
        // message: 'لطفا فیلد ها را با دقت کامل کنید',
          message: '$e',
          variant: SnackbarType.error,
          duration: Duration(milliseconds: 3000));
      print(e);
      throw (e);
    }
  }

  @override
  void onFutureError(dynamic error, Object? key) {
    // _snackBarService.showCustomSnackBar(
    //     // message: 'لطفا فیلد ها را با دقت کامل کنید',
    //     message: '$error',
    //     variant: SnackbarType.error,
    //     duration: Duration(milliseconds: 3000));
    print(error);
  }

  @override
  void onError(error) {
    super.onError(error);
    // _snackBarService.showCustomSnackBar(
    //     message: error,
    //     variant: SnackbarType.error,
    //     duration: Duration(milliseconds: 2500));
  }

  @override
  Future futureToRun() async {}

}
