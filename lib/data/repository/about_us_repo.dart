import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class AboutUsRepo {
  final ApiClient apiClient;

  AboutUsRepo({
    required this.apiClient,
  });

  Future<Response> getAboutUs({
    String? locale,
  }) async {
    Map<String, dynamic> parameters = {};

    if (locale != null) parameters['language'] = locale;
    String url = AppConstants.ABOUT_US_URL;
    bool isFirstParam = true;

    parameters.forEach((key, value) {
      if (isFirstParam) {
        url += '?';
        isFirstParam = false;
      } else {
        url += '&';
      }

      url += '$key=$value';
    });
    return await apiClient.getData(url);
  }
}
