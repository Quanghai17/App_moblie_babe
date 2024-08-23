import 'package:flutter_babe/models/book_table_model.dart';
import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class BookTableRepo {
  final ApiClient apiClient;

  BookTableRepo({
    required this.apiClient,
  });

  Future<Response> bookTableInRepo(BookTableModel bookTableModel) async {
    //print("check" + bookTableModel.toJson().toString());
    return await apiClient.postData(
        AppConstants.BOOK_TABLE_URL, bookTableModel.toJson());
  }
}
