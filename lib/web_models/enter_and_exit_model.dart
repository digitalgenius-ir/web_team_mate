// ignore_for_file: unnecessary_this, non_constant_identifier_names

import 'package:attendance/entities/safe_convert.dart';
import 'package:attendance/web_models/simular_web_model.dart';
import 'package:attendance/web_models/verify_phone_number_web_model.dart';


class EnterAndExitRQM{
  final int id;
  final int userID;
  final String date;
  final String? enter;
  final String enterAgent;
  final String enterLatitude;
  final String enterLongitude;
  final int? enterStationID;
  final String? exit;
  final String exitAgent;
  final String exitLatitude;
  final String exitLongitude;
  final int? exitStationID;
  final String exitStationTitle;

  EnterAndExitRQM({
    this.id = 0,
    this.userID = 0,
    this.date = "",
    this.enter = "",
    this.enterAgent = "",
    this.enterLatitude = "",
    this.enterLongitude = "",
    this.enterStationID = 0,
    this.exit = "",
    this.exitAgent = "",
    this.exitLatitude = "",
    this.exitLongitude = "",
    this.exitStationID = 0,
    this.exitStationTitle = "",
  });

  factory EnterAndExitRQM.fromJson(Map<String, dynamic> json) => EnterAndExitRQM(
    id: asT<int>(json, 'id', defaultValue: 0),
    userID: asT<int>(json, 'userID',defaultValue: 0),
    date: asT<String>(json, 'date',defaultValue: ''),
    enter: asT<String>(json, 'enter',defaultValue: ''),
    enterAgent: asT<String>(json, 'enterAgent',defaultValue: ''),
    enterLatitude: asT<String>(json, 'enterLatitude',defaultValue: ''),
    enterLongitude: asT<String>(json, 'enterLongitude',defaultValue: ''),
    enterStationID: asT<int>(json, 'enterStationID',defaultValue: 0),
    exit: asT<String>(json, 'exit',defaultValue: ''),
    exitAgent: asT<String>(json, 'exitAgent',defaultValue: ''),
    exitLatitude: asT<String>(json, 'exitLatitude',defaultValue: ''),
    exitLongitude: asT<String>(json, 'exitLongitude',defaultValue: ''),
    exitStationID: asT<int>(json, 'exitStationID',defaultValue: 0),
    exitStationTitle: asT<String>(json, 'exitStationTitle',defaultValue: ''),
  );

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'userID': this.userID,
    'date': this.date,
    'enter': this.enter,
    'enterAgent': this.enterAgent,
    'enterLatitude': this.enterLatitude,
    'enterLongitude': this.enterLongitude,
    'enterStationID': this.enterStationID,
    'exit': this.exit,
    'exitAgent': this.exitAgent,
    'exitLatitude': this.exitLatitude,
    'exitLongitude': this.exitLongitude,
    'exitStationID': this.exitStationID,
    'exitStationTitle': this.exitStationTitle,
  };
}


class EnterAndExitRPM {
  final bool Success;
  final String Data;
  final String Message;
  final List<ErrorModel>? error;


  EnterAndExitRPM({
    this.Success = false,
    this.Data = "",
    this.Message = '',
    this.error,
  });

  factory EnterAndExitRPM.fromJson(Map<String, dynamic> json) => EnterAndExitRPM(
    Success: asT<bool>(json, 'Success',defaultValue: false),
    Data: asT<String>(json, 'Data',defaultValue: ''),
    Message: asT<String>(json, 'Message',defaultValue: ''),
    error: asT<List>(json, 'Error', defaultValue: []).map((e) => ErrorModel.fromJson(e)).toList(),

  );

  Map<String, dynamic> toJson() => {
    'Success': this.Success,
    'Data': this.Data,
    'Message': this.Message,
    'Error': error?.map((e) => e.toJson()),

  };
}
