import 'package:attendance/app/dio_main.dart';
import 'package:attendance/app/web.router.dart';
import 'package:attendance/web_models/profile_web_model.dart';

Future<ProfileRPM> prepareProfileRequest(// ProfileRQM reqModel
    ) async {
  try {
    Map<String, dynamic> inputs = {"userId" : "0"};
    Map<String, dynamic> response =
        await getRequest<Map<String, dynamic>>(WebRoutes.profile, inputs);

    try {
      ProfileRPM result = ProfileRPM.fromJson(response);
      return result;
    } catch (e) {
      throw ("خطای ارتباط با سرور");
    }
  } catch (e) {
    print(e);
    rethrow;
  }
}
