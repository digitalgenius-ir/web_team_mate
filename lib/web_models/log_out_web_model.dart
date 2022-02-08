import 'package:attendance/entities/safe_convert.dart';
import 'package:attendance/web_models/login_web_model.dart';
import 'package:attendance/web_models/simular_web_model.dart';
import 'package:attendance/web_models/verify_phone_number_web_model.dart';

class LogOutRPM {
  final bool Success;
  final bool data;
  final String Message;
  final List<ErrorModel>? error;

  LogOutRPM({
    this.Success = false,
    this.data = false,
    this.Message = '',
    this.error,
  });

  factory LogOutRPM.fromJson(Map<String, dynamic> json) => LogOutRPM(
        Success: asT<bool>(json, 'Success', defaultValue: false),
        data: asT<bool>(json, 'Data', defaultValue: false),
        Message: asT<String>(json, 'Message', defaultValue: ''),
        error: asT<List>(json, 'Error', defaultValue: [])
            .map((e) => ErrorModel.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'Success': this.Success,
        'data': this.data,
        'Message': this.Message,
        'Error': error?.map((e) => e.toJson()),
      };
}
