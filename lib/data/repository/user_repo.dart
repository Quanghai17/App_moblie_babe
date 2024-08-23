import 'package:flutter_babe/models/update_password_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/models/update_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  final ApiClient apiClient;
  SharedPreferences sharedPreferences;

  UserRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getUserInformation() async {
    String url = AppConstants.USER_INFORMATION_URL;
    return await apiClient.getData(url);
  }

  Future<http.Response> updateUserInformation(UpdateUserModel userModel) async {
    String? token = sharedPreferences.getString(AppConstants.TOKEN);
    var uri =
        Uri.parse(AppConstants.BASE_URL + AppConstants.USER_INFORMATION_URL);
    var request = http.MultipartRequest('POST', uri);

    //  print("check image: " + userModel.avatar.toString());

    request.fields['name'] = userModel.name ?? '';
    request.fields['email'] = userModel.email ?? '';
    if (userModel.password != null) {
      request.fields['password'] = userModel.password!;
    }

    if (userModel.avatar != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'avatar',
          userModel.avatar!.path,
        ),
      );
    }

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    var streamedResponse = await request.send();
    print(streamedResponse.statusCode);
    return await http.Response.fromStream(streamedResponse);
  }

  Future<Response> updatePassword(
      UpdatePasswordModel updatePasswordModel) async {
    String url = AppConstants.UPDATE_PASSWORD_URL;
    return await apiClient.postData(url, updatePasswordModel.toJson());
  }
}
