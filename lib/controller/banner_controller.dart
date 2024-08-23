import 'package:flutter_babe/data/repository/banner_repo.dart';
import 'package:flutter_babe/models/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends GetxController implements GetxService {
  BannerRepo bannerRepo;

  BannerController({required this.bannerRepo});

  List<BannerModel> _bannerList = [];
  List<BannerModel> get bannerList => _bannerList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getBannerList() async {
    _isLoading = true;

    try {
      Response response = await bannerRepo.getAllBanner();
      //print("check status at banner controller: " +
      //response.statusCode.toString());
      if (response.statusCode == 200) {
        //print("check status at banner controller: " +
        //response.statusCode.toString());
        _bannerList.clear();
        List<dynamic> dataList = response.body['results'];
        //print(dataList.toString());
        dataList.forEach((element) {
          BannerModel bannerModel = BannerModel.fromJson(element);
          _bannerList.add(bannerModel);
        });
      }
      _isLoading = false;
      update();
    } catch (e) {
      print("error at banner controller: ${e}");
    }
  }
}
