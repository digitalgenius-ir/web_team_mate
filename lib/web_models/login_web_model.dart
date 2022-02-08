import 'package:attendance/entities/safe_convert.dart';
import 'package:attendance/web_models/simular_web_model.dart';
import 'package:attendance/web_models/verify_phone_number_web_model.dart';

class LoginRQM {
  final int id;
  final int code;
  final int userID;
  final String notificationToken;
  final String deviceID;
  final String expireDate;

  LoginRQM({
    this.id = 0,
    this.code = 0,
    this.userID = 0,
    this.notificationToken = "",
    this.deviceID = "",
    this.expireDate = "",
  });

  factory LoginRQM.fromJson(Map<String, dynamic> json) => LoginRQM(
        id: asT<int>(json, 'id', defaultValue: 0),
        code: asT<int>(json, 'code', defaultValue: 0),
        userID: asT<int>(json, 'userID', defaultValue: 0),
        notificationToken:
            asT<String>(json, 'notificationToken', defaultValue: ''),
        deviceID: asT<String>(json, 'deviceID', defaultValue: ''),
        expireDate: asT<String>(json, 'expireDate', defaultValue: ''),
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'code': this.code,
        'userID': this.userID,
        'notificationToken': this.notificationToken,
        'deviceID': this.deviceID,
        'expireDate': this.expireDate,
      };
}

class LoginRPM {
  final bool Success;
  final LoginWebModel? data;
  final String Message;
  final List<ErrorModel>? error;

  LoginRPM({
    this.Success = false,
    this.data,
    this.Message = '',
    this.error,
  });

  factory LoginRPM.fromJson(Map<String, dynamic> json) => LoginRPM(
        Success: asT<bool>(json, 'Success', defaultValue: false),
        data: LoginWebModel.fromJson(json['Data']),
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

class LoginWebModel {
  final int LoginResult;
  final User? user;
  final String Token;

  LoginWebModel({
    this.LoginResult = 0,
    this.user,
    this.Token = '',
  });

  factory LoginWebModel.fromJson(Map<String, dynamic> json) => LoginWebModel(
        LoginResult: asT<int>(json, 'LoginResult', defaultValue: 0),
        user: User.fromJson(json["User"]),
        Token: asT<String>(json, 'Token', defaultValue: ''),
      );

  Map<String, dynamic> toJson() => {
        'LoginResult': this.LoginResult,
        'User': this.user,
        'Token': this.Token,
      };
}
