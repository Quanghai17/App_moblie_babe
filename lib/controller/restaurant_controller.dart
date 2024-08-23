import 'package:flutter_babe/data/repository/restaurant_repo.dart';
import 'package:flutter_babe/models/restaurant_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantController extends GetxController implements GetxService {
  final RestaurantRepo restaurantRepo;
  final SharedPreferences sharedPreferences;

  RestaurantController({
    required this.restaurantRepo,
    required this.sharedPreferences,
  });

  List<Restaurant> _restaurantList = [];
  List<Restaurant> get restaurantList => _restaurantList;

  bool _hasNextPage = false;
  bool get hasNextPage => _hasNextPage;

  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  @override
  void onInit() {
    super.onInit();
    getAllRestaurantList(null, 1); // Load initial data
  }

  Future<void> getAllRestaurantList(int? paginate, int? page) async {
    if (paginate == null) {
      paginate = 8;
    }
    String language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await restaurantRepo.getAllRestaurantInfor(
        locale: language,
        paginate: paginate,
        page: page,
      );

      if (response.statusCode == 200) {
        List<dynamic> dataList = response.body["results"];
        //print("Data length received: ${dataList.length} on page $page");
        if (dataList.isEmpty) {
          _isLastPage = true;
          update();
        } else {
          if (page == 1) {
            _restaurantList.clear();
            update();
          }
          dataList.forEach((restaurantData) {
            Restaurant restaurant = Restaurant.fromJson(restaurantData);
            _restaurantList.add(restaurant);
          });
          update();
          if (dataList.length < paginate) {
            _isLastPage = true;
          } else {
            _hasNextPage = true;
          }
        }
        _isLoaded = true;
        update();
      } else {}
      //update();
    } catch (e) {
      print("Error in get Restaurant List: $e");
      _isLoaded = false;
      // update();
    }
  }

  Future<Restaurant?> getRestaurantDetail(int restaurantID) async {
    Restaurant? restaurant;
    String language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await restaurantRepo.getRestaurantDetail(
        restaurantID: restaurantID,
        language: language,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> restaurantData = response.body["results"];
        restaurant = Restaurant.fromJson(restaurantData);
      } else {
        // Handle non-200 responses if necessary
        print("Error at restaurant: ${response.statusCode}");
      }
      update(); // Ensure state is updated after processing response
    } catch (e) {
      print("Error in get Restaurant Detail: $e");
      update(); // Ensure state is updated even in case of error
    }
    return restaurant;
  }

  Future<List<String>> getImageList(int restaurantID) async {
    List<String> images = [];
    try {
      Restaurant? restaurant = await getRestaurantDetail(restaurantID);

      if (restaurant != null) {
        if (restaurant.multiimage != null) {
          String? multiImage = restaurant.multiimage;
          print("Length multi image: " + multiImage!.length.toString());
          if (multiImage == null || multiImage.length <= 2) {
            images.add(restaurant.image!);
            print("Fallback to single image: " + images.toString());
          }
          if (multiImage != null && multiImage.length > 2) {
            multiImage = multiImage.substring(1, multiImage.length - 1);
            List<String> imageUrls = multiImage.split("\",\"");
            imageUrls =
                imageUrls.map((url) => url.replaceAll('"', '')).toList();
            images.addAll(imageUrls);

            print("Processed multiimage: " + images.toString());
          }
        } else {
          images.add(restaurant.image!);
        }
      }
    } catch (e) {
      print("Error in getImageList: $e");
    }
    return images;
  }
}
