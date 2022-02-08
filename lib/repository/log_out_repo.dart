import 'package:attendance/app/dio_main.dart';
import 'package:attendance/app/web.router.dart';
import 'package:attendance/web_models/log_out_web_model.dart';
import 'package:attendance/web_models/login_web_model.dart';


Future<LogOutRPM> prepareLogOutRequest() async {
  try {
    Map<String, dynamic> inputs = {'' : ''};
    Map<String, dynamic> response =
        await postRequest(WebRoutes.log_out, inputs);

    try {
      LogOutRPM result = LogOutRPM.fromJson(response);
      return result;
    } catch (e) {
      throw ("خطای ارتباط با سرور");
    }
  } catch (e) {
    print(e);
    throw (e);
  }
}