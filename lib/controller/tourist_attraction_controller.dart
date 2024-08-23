import 'package:flutter_babe/data/repository/tourist_attraction_repo.dart';
import 'package:flutter_babe/models/tourist_attraction_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TouristAttractionController extends GetxController
    implements GetxService {
  final TouristAttractionRepo touristAttractionRepo;
  SharedPreferences sharedPreferences;

  TouristAttractionController({
    required this.touristAttractionRepo,
    required this.sharedPreferences,
  });

  int _currentPage = 1;
  int get currentPage => _currentPage;

  late int _totalPage = 1;
  int get totalPage => _totalPage;

  bool _hasNextPage = false;
  bool get hasNextPage => _hasNextPage;

  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  List<TouristAttraction> _touristAttractionList = [];
  List<TouristAttraction> get touristAttractionList => _touristAttractionList;

  List<TouristAttraction> _outstandingTouristAttractionList = [];
  List<TouristAttraction> get outstandingTouristAttractionList =>
      _outstandingTouristAttractionList;

  List<TouristAttraction> _touristAttractionOther = [];
  List<TouristAttraction> get touristAttractionOther => _touristAttractionOther;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getTouristAttractionList(int? paginate, int? page) async {
    if (paginate == null) {
      paginate = 8;
    }
    _isLoading = true;
    try {
      String? language =
          sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
      Response response = await touristAttractionRepo.getTouristAttractionInfor(
          locale: language, paginate: paginate, page: page);

      if (response.statusCode == 200) {
        _isLoaded = true;
        List<dynamic> dataList = response.body["results"];
        if (dataList.isEmpty) {
          _hasNextPage = false;
          _isLastPage = true;
        } else {
          if (page == 1) {
            _touristAttractionList.clear();
            _outstandingTouristAttractionList.clear();
            _isLastPage = false;
          }
          dataList.forEach((tourData) {
            TouristAttraction touristAttraction =
                TouristAttraction.fromJson(tourData);
            _touristAttractionList.add(touristAttraction);
            if (touristAttraction.featured == 1) {
              _outstandingTouristAttractionList.add(touristAttraction);
            }
          });
          if (dataList.length < paginate) {
            _isLastPage = true;
          } else {
            _hasNextPage = true;
          }
          _isLoading = false;
        }
        update();
      } else {
        // Handle non-200 response codes
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getTouristAttractionList: $e");
    }
    _isLoading = false;
    update();
  }

  // Future<void> getLengthOfList() async {
  //   try {
  //     String? language =
  //         sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
  //     Response response = await touristAttractionRepo.getTouristAttractionInfor(
  //         locale: language, paginate: 1, page: 1);
  //     if (response.statusCode == 200) {
  //       _totalPage = response.body["totalPages"];
  //     }
  //   } catch (e) {
  //     print("Error in getLengthOfList: $e");
  //   }
  //   update();
  // }

  Future<TouristAttraction?> getTourDetail(int tourID) async {
    _isLoading = true;
    TouristAttraction? tour;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await touristAttractionRepo
          .getTouristAttractionDetail(tourID: tourID, language: language);

      if (response.statusCode == 200) {
        Map<String, dynamic> tourDetail = response.body["results"];
        tour = TouristAttraction.fromJson(tourDetail);
      } else {
        print(
            "Error at get tour detail at tour controller: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions or errors
      print("Error in get Tour detail: $e");
    }
    _isLoading = false;
    update();
    return tour;
  }

  Future<void> getTourAttractListPGN(int? paginate, int? page) async {
    try {
      String? language =
          sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'vi';
      Response response = await touristAttractionRepo.getTouristAttractionInfor(
          locale: language, paginate: paginate, page: page);
      if (response.statusCode == 200) {
        _isLoaded = true;
        //_touristAttractionOther.clear();
        List<dynamic> dataList = response.body["results"];
        if (dataList.isEmpty) {
          _hasNextPage = false;
          _isLastPage = true;
        } else {
          if (page == 1) {
            touristAttractionOther.clear();
          }
          dataList.forEach((tourData) {
            TouristAttraction touristAttraction =
                TouristAttraction.fromJson(tourData);
            _touristAttractionOther.add(touristAttraction);
          });
          _hasNextPage = true;
          _isLastPage = false;
          _isLoading = false;
          print("check paginate at tourAttract: " + paginate.toString());
          update();
        }
      } else {
        // Xử lý khi không nhận được mã trạng thái 200
      }
    } catch (e) {
      // Xử lý ngoại lệ hoặc lỗi
      print("Error in getTourAttractListPGN: $e");
    }
  }

  Future<List<String>> getImageList(int touristAttractionID) async {
    List<String> images = [];
    try {
      TouristAttraction? touristAttraction =
          await getTourDetail(touristAttractionID);

      // if (touristAttraction != null) {
      //   String? multiimage = touristAttraction.multiimage;
      //   if (multiimage != null) {
      //     multiimage = multiimage.substring(1, multiimage.length - 1);
      //     List<String> imageUrls = multiimage.split("\",\"");
      //     for (String imageUrl in imageUrls) {
      //       imageUrl = imageUrl.replaceAll('"', '');
      //       images.add(imageUrl);
      //     }
      //   } else {
      //     images.add(touristAttraction.image!);
      //   }
      // }

      if (touristAttraction != null) {
        if (touristAttraction.multiimage != null) {
          String? multiImage = touristAttraction.multiimage;
          print("Length multi image: " + multiImage!.length.toString());
          if (multiImage == null || multiImage.length <= 2) {
            images.add(touristAttraction.image!);
            //print("Fallback to single image: " + images.toString());
          }
          if (multiImage != null && multiImage.length > 2) {
            multiImage = multiImage.substring(1, multiImage.length - 1);
            List<String> imageUrls = multiImage.split("\",\"");
            imageUrls =
                imageUrls.map((url) => url.replaceAll('"', '')).toList();
            images.addAll(imageUrls);

            //print("Processed multiimage: " + images.toString());
          }
        } else {
          images.add(touristAttraction.image!);
        }
      }
    } catch (e) {
      print("Error in getImageList: $e");
    }
    return images;
  }
}
