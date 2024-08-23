import 'package:flutter_babe/data/repository/about_us_repo.dart';
import 'package:flutter_babe/models/about_us_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_babe/models/response_model.dart';

class AboutUsController extends GetxController implements GetxService {
  final AboutUsRepo aboutUsRepo;
  late SharedPreferences sharedPreferences; // Declare as late

  AboutUsController({
    required this.aboutUsRepo,
    required this.sharedPreferences,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AboutUs? _aboutUsModel;
  AboutUs? get aboutUsModel => _aboutUsModel;

  Future<ResponseModel> getAboutUs() async {
    late ResponseModel responseModel;
    _isLoading = true; // Set isLoading to true before making the API call
    update(); // Notify listeners
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
    Response response = await aboutUsRepo.getAboutUs(locale: language);
    if (response.statusCode == 200) {
      _aboutUsModel = AboutUs.fromJson(response.body["results"]);
      //print(_aboutUsModel!.title!);
      responseModel = ResponseModel(true, "Success");
    } else {
      responseModel =
          ResponseModel(false, response.statusText ?? "Unknown error");
    }
    _isLoading = false; // Set isLoading to false after receiving the response
    update(); // Notify listeners
    return responseModel;
  }
}
