import 'package:attendance/entities/safe_convert.dart';
import 'package:attendance/web_models/simular_web_model.dart';

class VerifyPhoneNumberRQM {
  final String phoneNumber;

  VerifyPhoneNumberRQM({
    this.phoneNumber = "",
  });

  factory VerifyPhoneNumberRQM.fromJson(Map<String, dynamic> json) =>
      VerifyPhoneNumberRQM(
        phoneNumber: asT<String>(json, 'phoneNumber', defaultValue: ''),
      );

  Map<String, dynamic> toJson() => {
        'phoneNumber': this.phoneNumber,
      };
}


class VerifyPhoneNumberRPM {
  final bool Success;
  final VerifyPhoneNumberWebModel? data;
  final String Message;
  final List<ErrorModel>? error;

  VerifyPhoneNumberRPM({
    this.Success = false,
    this.data,
    this.Message = "",
    this.error,
  });

  factory VerifyPhoneNumberRPM.fromJson(Map<String, dynamic> json) => VerifyPhoneNumberRPM(
    Success: asT<bool>(json, 'Success', defaultValue: false),
    data: VerifyPhoneNumberWebModel.fromJson((json['Data'] ?? {'':''})),
    Message: asT<String>(json, 'Message',defaultValue: ''),
    error: asT<List>(json, 'Error', defaultValue: []).map((e) => ErrorModel.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'Success':this. Success,
    'data': this.data?.toJson(),
    'Message': this.Message,
    'error': this.error?.map((e) => e.toJson()),
  };
}

class VerifyPhoneNumberWebModel {
  final int Code;
  final int UserID;
  final String NotificationToken;
  final String DeviceID;
  final String ExpireDate;
  final int ID;

  VerifyPhoneNumberWebModel({
    this.Code = 0,
    this.UserID = 0,
    this.NotificationToken = "",
    this.DeviceID = "",
    this.ExpireDate = "",
    this.ID = 0,
  });

  factory VerifyPhoneNumberWebModel.fromJson(Map<String, dynamic> json) => VerifyPhoneNumberWebModel(
    Code: asT<int>(json, 'Code',defaultValue: 0),
    UserID: asT<int>(json, 'UserID',defaultValue: 0),
    NotificationToken: asT<String>(json, 'NotificationToken',defaultValue: ''),
    DeviceID: asT<String>(json, 'DeviceID',defaultValue: ''),
    ExpireDate: asT<String>(json, 'ExpireDate',defaultValue: ''),
    ID: asT<int>(json, 'ID',defaultValue: 0),
  );

  Map<String, dynamic> toJson() => {
    'Code': this.Code,
    'UserID': this.UserID,
    'NotificationToken': this.NotificationToken,
    'DeviceID': this.DeviceID,
    'ExpireDate': this.ExpireDate,
    'ID': this.ID,
  };
}