
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:attendance/app/app.router.dart';
import 'package:attendance/services/locator.dart';
import 'package:attendance/services/preferences_service.dart';


class SplashVM extends FutureViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AppPreferences preferences = locator<AppPreferences>();


  Future sendDataToServer() async {

    await Future.delayed(const Duration(seconds: 5));
    print(preferences.isFirstTimeLaunch);
    print(preferences.token);
    return controlNavigation();

    // _navigationService.pushNamedAndRemoveUntil(Routes.loginPage);
  }


  void controlNavigation() async {
    if (preferences.isFirstTimeLaunch) {
      await _navigationService.pushNamedAndRemoveUntil(Routes.loginPage);
    }
    else if(preferences.isFirstTimeLaunch == false && preferences.token != "")
    {
      await _navigationService.pushNamedAndRemoveUntil(Routes.homePage);
    }
    else {
      preferences.token = "";
      await _navigationService.pushNamedAndRemoveUntil(Routes.loginPage);
    }
  }

  @override
  Future futureToRun() async{
    sendDataToServer();
  }
}
