// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SettingRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getSettingInfor(String languageCode) async {
    //print("setting url " + AppConstants.SETTING_URL + languageCode);
    return await apiClient.getData(
      AppConstants.SETTING_URL + languageCode,
    );
  }
}
