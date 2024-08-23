// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class RestaurantRepo {
  final ApiClient apiClient;

  RestaurantRepo({
    required this.apiClient,
  });

  Future<Response> getAllRestaurantInfor({
    String? locale,
    int? paginate,
    int? page,
  }) async {
    // Xây dựng danh sách tham số truy vấn từ các đối số được truyền vào
    Map<String, dynamic> parameters = {};
    if (locale != null) parameters['language'] = locale;
    if (paginate != null) parameters['paginate'] = paginate.toString();
    if (page != null) parameters['page'] = page.toString();
    String url = AppConstants.RESTAURANT_URL;
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

  Future<Response> getRestaurantDetail(
      {int? restaurantID, String? language}) async {
    language ??= "";

    String url = AppConstants.RESTAURANT_URL + "/${restaurantID}";
    if (language != null && language.isNotEmpty) {
      url += "?language=" + language;
    }

    return await apiClient.getData(url);
  }
}
