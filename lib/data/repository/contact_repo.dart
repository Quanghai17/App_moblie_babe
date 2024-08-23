import 'package:flutter_babe/models/contact_model.dart';
import 'package:get/get.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/utils/app_constants.dart';

class ContactRepo {
  final ApiClient apiClient;

  ContactRepo({
    required this.apiClient,
  });

  Future<Response> sendContact(ContactModel contactModel) async {
    return await apiClient.postData(
        AppConstants.CONTACT_URL, contactModel.toJson());
  }
}
