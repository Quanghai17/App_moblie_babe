// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class TouristAttractionRepo {
  final ApiClient apiClient;

  TouristAttractionRepo({
    required this.apiClient,
  });

  Future<Response> getTouristAttractionInfor({
    String? locale,
    int? paginate,
    int? page,
  }) async {
    Map<String, dynamic> parameters = {};
    if (locale != null) parameters['language'] = locale;
    if (paginate != null) parameters['paginate'] = paginate.toString();
    if (page != null) parameters['page'] = page.toString();

    // Xây dựng URL từ danh sách tham số truy vấn
    String url = AppConstants.TOURIST_ATTRACTION_URL;

    // Kiểm tra xem URL đã có tham số truy vấn nào chưa
    bool isFirstParam = true;

    parameters.forEach((key, value) {
      // Nếu là tham số đầu tiên, thêm dấu ? vào URL, ngược lại thêm dấu &
      if (isFirstParam) {
        url += '?';
        isFirstParam = false;
      } else {
        url += '&';
      }

      // Thêm tham số vào URL
      url += '$key=$value';
    });

    // Lấy dữ liệu từ API bằng cách gọi hàm từ ApiClient
    return await apiClient.getData(url);
  }

  Future<Response> getTouristAttractionDetail(
      {int? tourID, String? language}) async {
    String url = AppConstants.TOURIST_ATTRACTION_URL + "/${tourID}";
    if (language != null && language.isNotEmpty) {
      url += "?language=" + language;
    }
    return await apiClient.getData(url);
  }
}
