import 'package:attendance/app/dio_main.dart';
import 'package:attendance/app/web.router.dart';
import 'package:attendance/web_models/sign_up_web_model.dart';
import 'package:attendance/web_models/verify_phone_number_web_model.dart';

Future<SignUpRPM> prepareSignUpRequest(SignUpRQM reqModel) async {
  try {
    Map<String, dynamic> inputs = reqModel.toJson();
    Map<String, dynamic> response =
        await postRequest(WebRoutes.sign_up, inputs);

    try {
      SignUpRPM result = SignUpRPM.fromJson(response);
      return result;
    } catch (e) {
      throw ("خطای ارتباط با سرور");
    }
  } catch (e) {
    print(e);
    throw (e);
  }
}
