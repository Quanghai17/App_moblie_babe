import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';

class RoomRepo {
  final ApiClient apiClient;

  RoomRepo({
    required this.apiClient,
  });

  Future<Response> getAllRoom({
    String? locale,
    int? paginate,
    int? page,
  }) async {
    // Xây dựng danh sách tham số truy vấn từ các đối số được truyền vào
    Map<String, dynamic> parameters = {};
    if (locale != null) parameters['language'] = locale;
    if (paginate != null) parameters['paginate'] = paginate.toString();
    if (page != null) parameters['page'] = page.toString();
    String url = AppConstants.ROOM_URL;
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

  Future<Response> getRoomDetail({int? roomID, String? language}) async {
    language ??= "";

    String url = AppConstants.ROOM_URL + "/${roomID}";
    if (language != null && language.isNotEmpty) {
      url += "?language=" + language;
    }

    return await apiClient.getData(url);
  }
}
