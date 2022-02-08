import 'package:attendance/app/dio_main.dart';
import 'package:attendance/app/web.router.dart';
import 'package:attendance/web_models/verify_phone_number_web_model.dart';

Future<VerifyPhoneNumberRPM> prepareVerifyRequest(
    VerifyPhoneNumberRQM reqModel) async {
  try {
    Map<String, dynamic> inputs = reqModel.toJson();
    Map<String, dynamic> response =
    await postRequest(WebRoutes.validate_phone_number, inputs);

    try {
      VerifyPhoneNumberRPM result = VerifyPhoneNumberRPM.fromJson(response);
      print(result.data?.Code ?? 0);
      return result;
    } catch (e) {
      throw ("خطای ارتباط با سرور");
    }
  } catch (e) {
    print(e);
    throw (e);
  }
}
