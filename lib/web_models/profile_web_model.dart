
// ignore_for_file: non_constant_identifier_names, unnecessary_this

import 'package:attendance/entities/safe_convert.dart';
import 'package:attendance/web_models/simular_web_model.dart';

class ProfileRPM {
  final bool Success;
  final User? data;
  final String Message;
  final List<ErrorModel>? error;

  ProfileRPM({
    this.Success = false,
    this.data,
    this.Message = "",
    this.error,
  });

  factory ProfileRPM.fromJson(Map<String, dynamic> json) => ProfileRPM(
    Success: asT<bool>(json, 'Success', defaultValue: false),
    data: User.fromJson(json['Data']),
    Message: asT<String>(json, 'Message',defaultValue: ''),
    error: asT<List>(json, 'Error', defaultValue: []).map((e) => ErrorModel.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'Success': this.Success,
    'Data': this.data?.toJson(),
    'Message': this.Message,
    'Error': error?.map((e) => e.toJson()),
  };
}
// // ignore_for_file: non_constant_identifier_names, unnecessary_this
//
// import 'package:attendance/entities/safe_convert.dart';
// import 'package:attendance/web_models/simular_web_model.dart';
// import 'package:attendance/web_models/verify_phone_number_web_model.dart';
//
// // class ProfileRQM {
// //   final String token;
// //
// //   ProfileRQM({
// //     this.token = "",
// //   });
// //
// //   factory ProfileRQM.fromJson(Map<String, dynamic> json) => ProfileRQM(
// //     token: asT<String>(json, 'token', defaultValue: ''),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     'token': this.token,
// //   };
// // }
//
//
// class ProfileRPM {
//   final bool Success;
//   final User? data;
//   final String Message;
//   final List<ErrorModel>? error;
//
//   ProfileRPM({
//     this.Success = false,
//     this.data,
//     this.Message = '',
//     this.error,
//   });
//
//   factory ProfileRPM.fromJson(Map<String, dynamic> json) => ProfileRPM(
//     Success: asT<bool>(json, 'Success', defaultValue: false),
//     data: User.fromJson(json['Data']),
//     Message: asT<String>(json, 'Message', defaultValue: ''),
//     error: asT<List>(json, 'Error', defaultValue: [])
//         .map((e) => ErrorModel.fromJson(e))
//         .toList(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     'Success': Success,
//     'data': data,
//     'Message': Message,
//     'Error': error?.map((e) => e.toJson()),
//   };
// }
//
