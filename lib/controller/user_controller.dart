import 'dart:io';
import 'package:flutter_babe/data/repository/user_repo.dart';
import 'package:flutter_babe/models/response_model.dart';
import 'package:flutter_babe/models/update_password_model.dart';
import 'package:flutter_babe/models/update_user_model.dart';
import 'package:flutter_babe/models/user_model.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? _userModel = null;
  UserModel? get userModel => _userModel;

  File? _pickedImage;
  File? get pickedImage => _pickedImage;

  Future<ResponseModel> getUserInfo() async {
    late ResponseModel responseModel;
    try {
      Response response = await userRepo.getUserInformation();

      print("code: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        _isLoading = true;
        _userModel = UserModel.fromJson(response.body["results"]);
        responseModel = ResponseModel(true, "Successfully");
      } else {
        print("false at usercontroller");
        responseModel = ResponseModel(false, response.statusText!);
      }
      _isLoading = false;
      update();
    } catch (e) {
      print("error at user controller: ${e}");
      responseModel = ResponseModel(false, e.toString());
      CustomSnackBar("please_login_again".tr,
          isError: false, title: "login".tr);
      Get.offNamed(RouteHelper.getSignInPage());
    }
    return responseModel;
  }

  Future<ResponseModel> updateUserInfo(
      String name, String email, String? password) async {
    _isLoading = true;
    update();
    UpdateUserModel updatedUser = UpdateUserModel(
      name: name,
      email: email,
      avatar: _pickedImage,
      password: password,
    );

    var response = await userRepo.updateUserInformation(updatedUser);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      // Update local user model with new data
      _userModel = UserModel(
        id: _userModel?.id,
        name: name,
        email: email,
        avatar: _pickedImage != null
            ? _pickedImage?.path.split('/').last
            : _userModel?.avatar,
        createdAt: _userModel?.createdAt,
        updatedAt: DateTime.now().toString(),
      );
      responseModel = ResponseModel(true, response.body[0].toString());
    } else {
      responseModel = ResponseModel(false, response.body[0]);
      print("loi:" + response.statusCode.toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _pickedImage = File(pickedFile.path);
    }
    update();
  }

  Future<ResponseModel> updatePassword(
      String password, String new_password, String confirm_password) async {
    _isLoading = true;
    late ResponseModel responseModel;
    late UpdatePasswordModel updatePasswordModel;
    update();
    if (new_password != confirm_password) {
      _isLoading = false;
      return responseModel = ResponseModel(false, "password_does_not_match".tr);
    } else {
      updatePasswordModel = UpdatePasswordModel(
        password: password,
        new_password: new_password,
        confirm_password: confirm_password,
      );
    }

    var response = await userRepo.updatePassword(updatePasswordModel);
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, response.body["message"].toString());
    } else {
      responseModel = ResponseModel(false, response.body["message"]);
      print("loi:" + response.statusCode.toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
