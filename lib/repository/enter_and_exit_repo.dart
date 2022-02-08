import 'package:attendance/app/dio_main.dart';
import 'package:attendance/app/web.router.dart';
import 'package:attendance/web_models/enter_and_exit_model.dart';
import 'package:attendance/web_models/login_web_model.dart';


Future<EnterAndExitRPM> prepareEnterAndExitRequest(EnterAndExitRQM reqModel) async {
  try {
    Map<String, dynamic> inputs = reqModel.toJson();
    Map<String, dynamic> response =
        await postRequest(WebRoutes.enter_and_exit, inputs);

    try {
      EnterAndExitRPM result = EnterAndExitRPM.fromJson(response);
      return result;
    } catch (e) {
      throw ("خطای ارتباط با سرور");
    }
  } catch (e) {
    print(e);
    throw (e);
  }
}