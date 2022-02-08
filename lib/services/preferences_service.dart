import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:attendance/enums/variables.dart';
import 'package:attendance/web_models/login_web_model.dart';
import 'package:attendance/web_models/simular_web_model.dart';

class AppPreferences {
  static AppPreferences? _instance;
  static SharedPreferences? _preferences;

  static Future<AppPreferences> getInstance() async {
    if (_instance == null) {
      _instance = AppPreferences();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance!;
  }

//*********************

  static const String TokenKey = "Token";
  static const String UserKey = "User";
  static const String HomeData = "HomeData";
  static const String IsFirstTimeLaunchKey = "IsFirstTimeLaunch";
  static const String FirebaseKey = "FirebaseKey";
  static const String PhoneNumber = "PhoneNumber";
  static const String recentTagsKey = "recentTags";
  static const String popularTagsKey = "popularTags";

  Future clearPref() async {
    var a = _preferences!.remove(TokenKey);
    var b = _preferences!.remove(UserKey);
    var c = _preferences!.remove(phoneNumber);
    var d = _preferences!.remove(recentTagsKey);

    var futures = <Future>[a, b, c, d];

    await Future.wait(futures);
  }

  List<String> get recentTags {
    var listJson = _preferences!.getStringList(recentTagsKey);

    if (listJson == null) {
      return [];
    }
    return listJson;
  }

  set recentTags(List<String> items) {
    _saveToDisk<List<String>>(recentTagsKey, items);
  }

  Future removeFormRecentExploreSearch(String value) async {
    List<String> items = recentTags;
    items.removeWhere((element) => value == element);

    // List<String> out =
    // items.map((entityJson) => json.encode(entityJson)).toList();

    _saveToDisk(recentTagsKey, items);
    // _saveToDisk(recentTagsKey, out);
  }

  List<String> get popularTags => _getFromDisk(popularTagsKey);

  set popularTags(List<String> value) => _saveToDisk(popularTagsKey, value);

  bool get isFirstTimeLaunch => _getFromDisk(IsFirstTimeLaunchKey) ?? true;

  set isFirstTimeLaunch(bool value) => _saveToDisk(IsFirstTimeLaunchKey, value);

  String get token => _getFromDisk(TokenKey) ?? "";

  set token(String phone) => _saveToDisk(TokenKey, phone);

  String get firebaseKey => _getFromDisk(FirebaseKey) ?? "";

  set firebaseKey(String key) => _saveToDisk(FirebaseKey, key);

  String get phoneNumber => _getFromDisk(PhoneNumber) ?? "";

  set phoneNumber(String key) => _saveToDisk(PhoneNumber, key);

  Map<String, String> getHeaders() {
    String tokenValue;
    if (_preferences!.getString(TokenKey) != null) {
      tokenValue = _preferences!.getString(TokenKey)!;
    } else {
      tokenValue = "";
    }

    Map<String, String> headers = {
      'apiLevel': "1",
      'appVersion': app_Version,
      'token': tokenValue,
    };

    return headers;
  }
  //
  User get user {
    var userJson = _getFromDisk(UserKey);
    if (userJson == null) {
      return User();
    }
    return User.fromJson(json.decode(userJson));
  }

  set user(User userToSave) {
    _saveToDisk<String>(UserKey, json.encode(userToSave.toJson()));
  }
  //
  // HomeWebModelRPM? getHomeData() {
  //   var homeJson = _getFromDisk(HomeData);
  //   if (homeJson == null) {
  //     return null;
  //   }
  //   return HomeWebModelRPM.fromJson(json.decode(homeJson));
  // }

  setHomeData(Map<String, dynamic> response) {
    _saveToDisk<String>(HomeData, json.encode(response));
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    print(
        '(TRACE) AppPreferencesService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }
}
