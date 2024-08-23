import 'package:flutter_babe/models/banner_model.dart';
import 'package:flutter_babe/models/book_room_model.dart';
import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class BannerRepo {
  final ApiClient apiClient;

  BannerRepo({
    required this.apiClient,
  });

  Future<Response> getAllBanner() async {
    return await apiClient.getData(AppConstants.BANNER_URL);
  }
}
