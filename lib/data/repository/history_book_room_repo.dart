import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class HistoryBookRoomRepo {
  final ApiClient apiClient;

  HistoryBookRoomRepo({
    required this.apiClient,
  });

  Future<Response> getHistoryBookRoom({
    String? locale,
  }) async {
    Map<String, dynamic> parameters = {};

    if (locale != null) parameters['language'] = locale;
    String url = AppConstants.BOOK_ROOM_URL;
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

  Future<Response> getDetailHistoryBookRoom(
      {int? book_room_id, String? language}) async {
    //language ??= "";

    String url = AppConstants.BOOK_ROOM_URL + "/${book_room_id}";
    if (language != null && language.isNotEmpty) {
      url += "?language=" + language;
    }

    return await apiClient.getData(url);
  }
}
