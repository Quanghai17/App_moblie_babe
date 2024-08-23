import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class HistoryBookTableRepo {
  final ApiClient apiClient;

  HistoryBookTableRepo({
    required this.apiClient,
  });

  Future<Response> getHistoryBookTable({
    String? locale,
  }) async {
    Map<String, dynamic> parameters = {};

    if (locale != null) parameters['language'] = locale;
    String url = AppConstants.BOOK_TABLE_URL;
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

  Future<Response> getDetailHistoryBookTableInRepo(
      {int? book_table_id, String? language}) async {
    language ??= "";

    String url = AppConstants.BOOK_TABLE_URL + "/${book_table_id}";
    if (language != null && language.isNotEmpty) {
      url += "?language=" + language;
    }

    return await apiClient.getData(url);
  }
}
