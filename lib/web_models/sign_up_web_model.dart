import 'package:attendance/entities/safe_convert.dart';
import 'package:attendance/web_models/simular_web_model.dart';
import 'package:attendance/web_models/verify_phone_number_web_model.dart';

class SignUpRQM {
  final String phoneNumber;
  final String password;
  final String firstName;
  final String lastName;
  final int gender;
  final String birthdate;
  final String address;
  final String bio;

  SignUpRQM({
    this.phoneNumber = "",
    this.password = "",
    this.firstName = "",
    this.lastName = "",
    this.gender = 0,
    this.birthdate = "",
    this.address = "",
    this.bio = "",
  });

  factory SignUpRQM.fromJson(Map<String, dynamic> json) => SignUpRQM(
    phoneNumber: asT<String>(json, 'phoneNumber', defaultValue: ''),
    password: asT<String>(json, 'password', defaultValue: ''),
    firstName: asT<String>(json, 'firstName', defaultValue: ''),
    lastName: asT<String>(json, 'lastName', defaultValue: ''),
    gender: asT<int>(json, 'gender', defaultValue: 0),
    birthdate: asT<String>(json, 'birthdate', defaultValue: ''),
    address: asT<String>(json, 'address', defaultValue: ''),
    bio: asT<String>(json, 'bio', defaultValue: ''),
  );

  Map<String, dynamic> toJson() => {
    'phoneNumber': phoneNumber,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    'gender': gender,
    'birthdate': birthdate,
    'address': address,
    'bio': bio,
  };
}


class SignUpRPM {
  final bool Success;
  final int Data;
  final String? Message;
  final List<ErrorModel>? error;

  SignUpRPM({
    this.Success = false,
    this.Data = 0,
    this.Message,
    this.error,
  });

  factory SignUpRPM.fromJson(Map<String, dynamic> json) => SignUpRPM(
    Success: asT<bool>(json, 'Success', defaultValue: false),
    Data: asT<int>(json, 'Data', defaultValue: 0),
    Message: asT<dynamic>(json, 'Message', defaultValue: ''),
    error: asT<List>(json, 'Error', defaultValue: []).map((e) => ErrorModel.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'Success': Success,
    'Data': Data,
    'Message': Message,
    'Error': error?.map((e) => e.toJson()),
  };
}

