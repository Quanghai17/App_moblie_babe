import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/models/signup_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpModel signUpModel) async {
    return await apiClient.postData(
        AppConstants.REGISTER_URL, signUpModel.toJson());
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  //   bool userLoggedIn() {
  //   return sharedPreferences.getString(AppConstants.TOKEN) != null;
  // }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? "none";
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(
        AppConstants.LOGIN_URL, {"email": email, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    print("save token");
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.EMAIL);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }

  // Future<void> saveUserNumberAndPassword(String number, String password) async {
  //   try {
  //     await sharedPreferences.setString(AppConstants.PHONE, number);
  //     await sharedPreferences.setString(AppConstants.PASSWORD, number);
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
