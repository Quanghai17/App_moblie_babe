import 'package:flutter_babe/data/repository/auth_repo.dart';
import 'package:flutter_babe/models/response_model.dart';
import 'package:flutter_babe/models/signup_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> signUp(SignUpModel signUpModel) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpModel);
    //print(response.statusCode.toString());

    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("success");
      print("token: " + response.body["newUserToken"]);
      //authRepo.saveUserToken(response.body["newUserToken"]);
      responseModel = ResponseModel(true, response.body["newUserToken"]);
      print("status model:" + responseModel.isSuccess.toString());
    } else {
      print("failed");
      print("status text: " + response.statusText.toString());
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();

    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      print("saved token: " + response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, "Email hoặc mật khẩu không đúng!");
      print("loi:" + response.statusCode.toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearShareData() {
    return authRepo.clearSharedData();
  }
}
