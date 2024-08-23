import 'package:flutter_babe/models/book_room_model.dart';
import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class BookRoomRepo {
  final ApiClient apiClient;

  BookRoomRepo({
    required this.apiClient,
  });

  Future<Response> bookRoomInRepo(BookRoomModel bookRoomModel) async {
    //print("check" + bookRoomModel.toJson().toString());
    return await apiClient.postData(
        AppConstants.BOOK_ROOM_URL, bookRoomModel.toJson());
  }
}
