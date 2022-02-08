

import 'package:attendance/entities/safe_convert.dart';

// class ProfileRPM {
//   final bool Success;
//   final Data Data;
//   final String Message;
//   final List<ErrorItem> Error;
//
//   ProfileRPM({
//     this.Success = false,
//     this.Data,
//     this.Message = "",
//     this.Error,
//   });
//
//   factory ProfileRPM.fromJson(Map<String, dynamic> json) => ProfileRPM(
//     Success: asT<bool>(json, 'Success'),
//     Data: Data.fromJson(asT<Map>(json, 'Data')),
//     Message: asT<String>(json, 'Message'),
//     Error: asT<List>(json, 'Error')?.map((e) => ErrorItem.fromJson(e))?.toList(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     'Success': this.Success,
//     'Data': this.Data?.toJson(),
//     'Message': this.Message,
//     'Error': this.Error?.map((e) => e.toJson()),
//   };
// }
//
// class Data {
//   final String Firstname;
//   final String Lastname;
//   final int Status;
//   final String Email;
//   final String Bio;
//   final String PhoneNumber;
//   final String AvatarPath;
//   final int IntroductoryCode;
//   final int Gender;
//   final bool IsWorking;
//   final String WorkingTime;
//   final int ID;
//   final String UpdateDate;
//
//   Data({
//     this.Firstname = "",
//     this.Lastname = "",
//     this.Status = 0,
//     this.Email = "",
//     this.Bio = "",
//     this.PhoneNumber = "",
//     this.AvatarPath = "",
//     this.IntroductoryCode = 0,
//     this.Gender = 0,
//     this.IsWorking = false,
//     this.WorkingTime = "",
//     this.ID = 0,
//     this.UpdateDate = "",
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     Firstname: asT<String>(json, 'Firstname',defaultValue: ''),
//     Lastname: asT<String>(json, 'Lastname',defaultValue: ''),
//     Status: asT<int>(json, 'Status',defaultValue: 0),
//     Email: asT<String>(json, 'Email',defaultValue: ''),
//     Bio: asT<String>(json, 'Bio',defaultValue: ''),
//     PhoneNumber: asT<String>(json, 'PhoneNumber',defaultValue: ''),
//     AvatarPath: asT<String>(json, 'AvatarPath',defaultValue: ''),
//     IntroductoryCode: asT<int>(json, 'IntroductoryCode',defaultValue: 0),
//     Gender: asT<int>(json, 'Gender',defaultValue: 0),
//     IsWorking: asT<bool>(json, 'IsWorking',defaultValue: false),
//     WorkingTime: asT<String>(json, 'WorkingTime',defaultValue: ''),
//     ID: asT<int>(json, 'ID',defaultValue: 0),
//     UpdateDate: asT<String>(json, 'UpdateDate',defaultValue: ''),
//   );
//
//   Map<String, dynamic> toJson() => {
//     'Firstname': this.Firstname,
//     'Lastname': this.Lastname,
//     'Status': this.Status,
//     'Email': this.Email,
//     'Bio': this.Bio,
//     'PhoneNumber': this.PhoneNumber,
//     'AvatarPath': this.AvatarPath,
//     'IntroductoryCode': this.IntroductoryCode,
//     'Gender': this.Gender,
//     'IsWorking': this.IsWorking,
//     'WorkingTime': this.WorkingTime,
//     'ID': this.ID,
//     'UpdateDate': this.UpdateDate,
//   };
// }