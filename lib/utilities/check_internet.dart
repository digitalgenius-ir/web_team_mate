import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> checkNetConnection() async {
  if (kIsWeb) {
  } else {
    var result = await InternetConnectionChecker().hasConnection;

    if (result) {
      return result;
    } else {
      throw ("لطفا اتصال اینترنت خود را بررسی کنید");
    }
  }

  return true;
}
