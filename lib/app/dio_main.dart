import 'dart:io';
import 'package:dio/dio.dart';
import 'package:attendance/enums/variables.dart';
import 'package:attendance/services/locator.dart';
import 'dart:convert' show json, utf8;

import 'package:attendance/services/preferences_service.dart';

final AppPreferences appPreferences = locator<AppPreferences>();

Future<T> postRequest<T>(
  String url,
  Map<String, dynamic> data,
) async {
  var headers = appPreferences.getHeaders();

  BaseOptions options = BaseOptions(
      baseUrl: url_general,
      contentType: ContentType.json.value,
      headers: headers,
      connectTimeout: 20000,
      receiveTimeout: 20000,
      maxRedirects: 5);

  Dio dio = Dio(options);
  print("postRequest: ${dio.options.baseUrl}$url");

  try {
    var response = await dio.post(url, data: data);

    if (response.data is String) {
      String data = response.data;

      var item = await json.decode(data);

      return item as T;
    }

    return response.data;
  } on DioError catch (dioError) {
    print("dioError: $dioError");
    var body = utf8.decode(dioError.response?.data);

    throw (body);
  } catch (e) {
    print("postRequest: catch: $e");
    throw (e);
  }
}

Future<T> postListRequest<T>(
  String url,
  Map<String, dynamic> data,
) async {
  var headers = appPreferences.getHeaders();
  BaseOptions options = new BaseOptions(
      baseUrl: url_general,
      contentType: ContentType.json.value,
      headers: headers,
      connectTimeout: 20000,
      receiveTimeout: 20000,
      maxRedirects: 5);

  // var online = await checkNetConnection();
  //
  // if (!online) {
  //   throw (NetworkResponseType.noInternet);
  // }

  Dio dio = Dio(options);
  print("postListRequest: ${dio.options.baseUrl}$url");

  try {
    var response = await dio.post(url, data: data);
    print("postListRequest: response: $response");

    if (response.data is String) {
      String data = response.data;

      List list = await json.decode(data);
      return list as T;
    }
    return response.data;
  } on DioError catch (dioError) {
    print("dioError postListRequest: $dioError");
    String body = utf8.decode(dioError.response!.statusMessage!.codeUnits);

    throw (body);
  } catch (e) {
    print("postListRequest: catch: $e");
    throw (e);
  }
}

Future<T> getRequest<T>(
  String url,
  Map<String, dynamic> data,
) async {
  try {
    var headers = appPreferences.getHeaders();
    BaseOptions options = BaseOptions(
        baseUrl: url_general,
        contentType: ContentType.json.value,
        headers: headers,
        connectTimeout: 20000,
        receiveTimeout: 20000,
        maxRedirects: 5);

    Dio dio = Dio(options);
    print("getRequest: ${dio.options.baseUrl}$url");
    Response response = await dio.get(url, queryParameters: data);

    if (response.data is String) {
      String data = response.data;

      Map<String, dynamic> list = await json.decode(data);
      return list as T;
    }
    return response.data;
  } on DioError catch (dioError) {
    print("dioError url:$url getRequest: $dioError");
    String body =
        utf8.decode(dioError.response?.statusMessage?.codeUnits ?? []);
    throw (body);
  } catch (e) {
    print("getRequest: catch: $e");
    throw (e);
    // throw("sadasd");
  }
}


// Future<Map<String, dynamic>> uploadRequest(File file) async {
//   String fileName = file.path.split('/').last;
//
//   FormData data = FormData.fromMap({"file": [await MultipartFile.fromFile(file.path, filename: fileName)]});
//
//   final AppPreferences appPreferences = locator<AppPreferences>();
//
//   var headers = appPreferences.getHeaders();
//
//   BaseOptions options = new BaseOptions(
//       baseUrl: url_general,
//       contentType: ContentType.json.value,
//       connectTimeout: 20000,
//       receiveTimeout: 20000,
//       headers: headers,
//       maxRedirects: 3);
// //***********************************************
//   Dio dio = Dio(options);
//   print("uploadRequest: $fileName");
//   var response = await dio.post(
//     url_uploadFile,
//     data: data,
//     onReceiveProgress: (count, total) {
//       print("Received $fileName received: $count of $total");
//     },
//     onSendProgress: (int sent, int total) {
//       print("Send  $fileName sent:$sent of $total");
//     },
//   );
//   print("uploadRequest: $fileName response: $response");
//   if (response.data is String) {
//     String data = response.data;
//
//     var item = await json.decode(data);
//     return item;
//   }
//   return response.data;
// }