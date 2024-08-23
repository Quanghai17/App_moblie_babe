import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResultRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  // Constructor
  SearchResultRepo({required this.apiClient, required this.sharedPreferences});

  // Method to fetch all rooms with optional query parameters
  Future<Response> search({
    String? locale,
    int? paginate,
    int? page,
    String? type,
    String? keyword,
  }) async {
    // Build a map of query parameters from the provided arguments
    Map<String, dynamic> parameters = {};
    if (locale != null) parameters['language'] = locale;
    if (paginate != null) parameters['paginate'] = paginate.toString();
    if (page != null) parameters['page'] = page.toString();
    if (type != null) parameters['type'] = type;
    if (keyword != null) parameters['keyword'] = keyword;

    String url = AppConstants.SEARCH_URL;
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
