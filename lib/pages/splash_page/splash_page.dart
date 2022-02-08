import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:stacked/stacked.dart';
import 'package:attendance/app/app.router.dart';
import 'package:attendance/enums/variables.dart';
import 'package:attendance/pages/splash_page/splash_notifier.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/services/preferences_service.dart';
import 'package:attendance/theme/dimens.dart';
import 'package:attendance/widgets/image_widget.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  AppPreferences pref = locator<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<SplashVM>.reactive(
      viewModelBuilder: () => SplashVM(),
      disposeViewModel: true,
      builder: (context, model, child) => Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        leading: const SizedBox(),
        backgroundColor: theme.backgroundColor,
      ),
      body: Container(
        margin: EdgeInsets.only(
            bottom: largeSize(context)
        ),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0.0,-0.15),
              child: Container(
                width: fullWidth(context)/2,
                child: Image.asset(
                  'assets/dg_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0,0.1),
              child: Container(
                width: fullWidth(context)/2.2,
                child: Image.asset(
                  'assets/digital_genius.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text("نسخه " + app_Version,
                  style: theme.textTheme.subtitle1!.copyWith(
                    color: Colors.grey,)),
            ),
          ],
        ),
      ),
    ));
  }
}