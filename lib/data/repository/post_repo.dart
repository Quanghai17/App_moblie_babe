import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';

class PostRepo {
  final ApiClient apiClient;

  PostRepo({
    required this.apiClient,
  });

  Future<Response> getAllPostInfor({
    String? filter,
    String? locale,
    int? paginate,
    int? page,
  }) async {
    // Xây dựng danh sách tham số truy vấn từ các đối số được truyền vào
    Map<String, dynamic> parameters = {};

    if (filter != null) parameters['filter'] = filter;
    if (locale != null) parameters['language'] = locale;
    if (paginate != null) parameters['paginate'] = paginate.toString();
    if (page != null) parameters['page'] = page.toString();
    String url = AppConstants.POST_URL;
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

  Future<Response> getPostDetail({int? postID, String? language}) async {
    language ??= "";

    String url = AppConstants.POST_URL + "/${postID}";
    if (language != null && language.isNotEmpty) {
      url += "?language=" + language;
    }

    return await apiClient.getData(url);
  }
}
