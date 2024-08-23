import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? '';
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      //print(_mainHeaders.toString());
      print("uri: " + uri.toString());
      Response response = await get(uri, headers: headers ?? _mainHeaders);
      return response;
    } catch (e) {
      print("false: " + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    try {
      print("uri: " + uri.toString());
      // print("check header: " + _mainHeaders.toString());
      Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    } catch (e) {
      print("false: " + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
