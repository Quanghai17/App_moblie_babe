import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class NotificationsRepo {
  final ApiClient apiClient;

  NotificationsRepo({
    required this.apiClient,
  });

  // Hàm lấy danh sách thông báo
  Future<Response> getAllNotifications({
    String? locale,
    int? page,
    int? limit,
  }) async {
    Map<String, dynamic> parameters = {};
    if (locale != null) parameters['language'] = locale;
    if (page != null) parameters['page'] = page.toString();
    if (limit != null) parameters['limit'] = limit.toString();

    String url = AppConstants.NOTIFICATIONS_URL;
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
