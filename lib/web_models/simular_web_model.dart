// ignore_for_file: unnecessary_this, non_constant_identifier_names

import 'package:attendance/entities/safe_convert.dart';

class User {
  String Firstname;
  String Lastname;
  int Status;
  String Email;
  String Bio;
  String PhoneNumber;
  String AvatarPath;
  int IntroductoryCode;
  // bool IsActive;
  int Gender;
  int ID;
  String UpdateDate;
  bool IsWorking;
  String WorkingTime;
  String startTime;
  String endTime;

  User(
      {this.Firstname = '',
        this.Lastname = '',
        this.Status = 0,
        this.Email = "",
        this.Bio = "",
        this.PhoneNumber = "",
        this.AvatarPath = '',
        this.IntroductoryCode = 0,
        // this.IsActive = false,
        this.Gender = 0,
        this.ID = 0,
        this.UpdateDate = '',
        this.IsWorking = false,
        this.WorkingTime = "",
        this.startTime = "",
        this.endTime = "",
      });

  factory User.fromJson(Map<String, dynamic> json) => User(
    ID: asT<int>(json, 'ID', defaultValue: 0),
    Gender: asT<int>(json, 'Gender', defaultValue: 0),
    IntroductoryCode: asT<int>(json, 'IntroductoryCode', defaultValue: 0),
    Status: asT<int>(json, 'Status', defaultValue: 0),
    Firstname: asT<String>(json, 'Firstname', defaultValue: ''),
    Lastname: asT<String>(json, 'Lastname', defaultValue: ''),
    PhoneNumber: asT<String>(json, 'PhoneNumber', defaultValue: ''),
    Email: asT<String>(json, 'Email', defaultValue: ''),
    Bio: asT<String>(json, 'Bio', defaultValue: ''),
    AvatarPath: asT<String>(json, 'AvatarPath', defaultValue: ''),
    UpdateDate: asT<String>(json, 'UpdateDate', defaultValue: ''),
    // IsActive: asT<bool>(json, 'IsActive', defaultValue: false),
    IsWorking: asT<bool>(json, 'IsWorking',defaultValue: false),
    WorkingTime: asT<String>(json, 'WorkingTime',defaultValue: ''),
    startTime: asT<String>(json, 'StartTime',defaultValue: ''),
    endTime: asT<String>(json, 'EndTime',defaultValue: ''),
  );

  Map<String, dynamic> toJson() => {
    'ID': this.ID,
    'Gender': this.Gender,
    'IntroductoryCode': this.IntroductoryCode,
    'Status': this.Status,
    'Firstname': this.Firstname,
    'Lastname': this.Lastname,
    'PhoneNumber': this.PhoneNumber,
    'Email': this.Email,
    'Bio': this.Bio,
    'AvatarPath': this.AvatarPath,
    'UpdateDate': this.UpdateDate,
    // 'IsActive': this.IsActive,
    'IsWorking': this.IsWorking,
    'WorkingTime': this.WorkingTime,
    'StartTime': this.startTime,
    'EndTime': this.endTime,
  };
}

class ErrorModel {
  final int Code;
  final String Message;

  ErrorModel({
    this.Code = 0,
    this.Message = "",
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    Code: asT<int>(json, 'Code', defaultValue: 0),
    Message: asT<String>(json, 'Message',defaultValue: ''),
  );

  Map<String, dynamic> toJson() => {
    'Code': this.Code,
    'Message': this.Message,
  };
}