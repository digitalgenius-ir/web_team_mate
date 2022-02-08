import 'package:attendance/app/dio_main.dart';
import 'package:attendance/app/web.router.dart';
import 'package:attendance/web_models/login_web_model.dart';


Future<LoginRPM> prepareLogInRequest(LoginRQM reqModel) async {
  try {
    Map<String, dynamic> inputs = reqModel.toJson();
    Map<String, dynamic> response =
        await postRequest(WebRoutes.log_in, inputs);

    try {
      LoginRPM result = LoginRPM.fromJson(response);
      return result;
    } catch (e) {
      throw ("خطای ارتباط با سرور");
    }
  } catch (e) {
    print(e);
    throw (e);
  }
}