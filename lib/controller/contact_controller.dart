import 'package:flutter_babe/data/repository/contact_repo.dart';
import 'package:flutter_babe/models/contact_model.dart';
import 'package:flutter_babe/models/response_model.dart';
import 'package:get/get.dart';

class ContactController extends GetxController implements GetxService {
  final ContactRepo contactRepo;

  ContactController({required this.contactRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> sendContact(ContactModel contactModel) async {
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    Response response = await contactRepo.sendContact(contactModel);
    // print("check status code at contact controller: " +
    //     response.statusCode.toString());
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"]);
    } else {
      print("failed");
      print("status text: " + response.statusText.toString());
      responseModel = ResponseModel(false, response.body["message"]);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
