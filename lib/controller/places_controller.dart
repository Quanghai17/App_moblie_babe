// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_babe/data/repository/places_repo.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_babe/models/places_model.dart';

class PlacesController extends GetxController implements GetxService {
  final PlacesRepo placesRepo;
  SharedPreferences sharedPreferences;

  List<Places> _placesList = [];
  List<Places> get placesList => _placesList;
  List<Places> _somePlacesList = [];
  List<Places> get somePlacesList => _somePlacesList;

  PlacesController({
    required this.placesRepo,
    required this.sharedPreferences,
  });

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _hasNextPage = false;
  bool get hasNextPage => _hasNextPage;

  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  @override
  void onInit() {
    super.onInit();
    getAllPlacesList(null, 1); // Load initial data
  }

  // Method to fetch all places list
  Future<void> getAllPlacesList(int? paginate, int? page) async {
    if (paginate == null) {
      paginate = 8;
    }
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await placesRepo.getAllPlaceInfor(
          locale: language, paginate: paginate, page: page);
      if (response.statusCode == 200) {
        List<dynamic> dataList = response.body["results"];
        if (dataList.isEmpty) {
          _isLastPage = true;
          update();
        } else {
          if (page == 1) {
            _placesList.clear(); // Clear list if it's the first page
            _isLastPage = false;
          }
          dataList.forEach((placesData) {
            Places place = Places.fromJson(placesData);
            _placesList.add(place);
          });

          if (dataList.length < paginate) {
            _isLastPage = true;
          } else {
            _hasNextPage = true;
          }
          _isLoaded = true;
          //_hasNextPage = response.body["results"] != null;
          //_isLastPage = false;
          update();
        }
      } else {}
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getAllPlacesList: $e");
    }
  }

  Future<void> getSomePlaces() async {
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await placesRepo.getAllPlaceInfor(locale: language);
      if (response.statusCode == 200) {
        List<dynamic> dataList = response.body["results"];
        _somePlacesList.clear();
        dataList.forEach((placesData) {
          Places place = Places.fromJson(placesData);
          _somePlacesList.add(place);
        });
        _isLoaded = true;
        _hasNextPage = response.body["results"] != null;
        _isLastPage = false;
        update();
      } else {}
    } catch (e) {
      // Handle exceptions or errors
      print("Error in getAllPlacesList: $e");
    }
  }

  // Function to reset loaded status
  void resetLoadStatus() {
    _isLoaded = false;
    update();
  }

  Future<Places?> getPlaceDetail(int placeID) async {
    Places? places;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response =
          await placesRepo.getPlaceDetail(placeID: placeID, language: language);
      if (response.statusCode == 200) {
        _isLoaded = true;
        Map<String, dynamic> placeData = response.body["results"];

        places = Places.fromJson(placeData);
        update();
      } else {
        print("Error at places controller: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in get Restaurant Detail: $e");
    }
    return places;
  }

  Future<List<String>> getImageList(int restaurantID) async {
    List<String> images = [];
    try {
      // Chờ hàm getRestaurantDetail hoàn thành và trả về một đối tượng Restaurant
      Places? place = await getPlaceDetail(restaurantID);

      if (place != null) {
        String? multiimage = place.multiimage;
        if (multiimage != null) {
          multiimage = multiimage.substring(1, multiimage.length - 1);
          List<String> imageUrls = multiimage.split("\",\"");
          for (String imageUrl in imageUrls) {
            imageUrl = imageUrl.replaceAll('"', '');
            images.add(imageUrl);
          }
        } else {
          images.add(place.image!);
        }
      }
    } catch (e) {
      print("Error in getImageList: $e");
    }
    return images;
  }
}
