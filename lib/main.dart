// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:attendance/app/app.router.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/theme/app_theme.dart';
import 'package:attendance/widgets/customSnackBar.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  WidgetsFlutterBinding.ensureInitialized();


  // var window = await window_size.getWindowInfo();
  // if (window.screen != null) {
  //
  //
  //   final screenFrame = window.screen!.visibleFrame;
  //   final width = 450.0;
  //   final height = 750.0;
  //   final left = ((screenFrame.width - width) / 2).roundToDouble();
  //   final top = ((screenFrame.height - height) / 3).roundToDouble();
  //   final frame = Rect.fromLTWH(left, top, width, height);
  //   window_size.setWindowFrame(frame);
  //   window_size.setWindowMinSize(Size(width  -50,  height - 50));
  //   window_size.setWindowMaxSize(Size(width,  height));
  //   window_size.setWindowTitle('Attendance (${Platform.operatingSystem})');
  // }


  await setupLocator();
  setupSnackBarUi();

  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));

    return MaterialApp(
      // navigatorObservers: [
      //   FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      // ],
      debugShowCheckedModeBanner: false,
      title: 'attendance',
      theme: AppTheme.darkTheme,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      builder: EasyLoading.init(),
    );
  }
}
