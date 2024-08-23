import 'package:flutter_babe/data/repository/dish_repo.dart';
import 'package:flutter_babe/models/dish_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DishesController extends GetxController implements GetxService {
  final DishRepo dishRepo;
  SharedPreferences sharedPreferences;

  DishesController({required this.dishRepo, required this.sharedPreferences});

  List<Dish> _dishesList = [];
  List<Dish> get dishesList => _dishesList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAllDishes(int owner_id) async {
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response = await dishRepo.getAllDishes(locale: language);
      if (response.statusCode == 200) {
        _isLoaded = true;
        _dishesList.clear();
        List<dynamic> dataList = response.body['results']['data'];
        //print("check data: " + dataList[0].toString());
        _dishesList = dataList
            .where((element) => element['owner_id'] == owner_id)
            .map((element) => Dish.fromJson(element))
            .toList();
      }
      update();
    } catch (e) {
      print("Error in get all dishes: $e");
    }
  }

  Future<Dish?> getDishDetail(int dishID) async {
    Dish? dish;
    String? language =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? "vi";
    try {
      Response response =
          await dishRepo.getDishDetail(dishID: dishID, language: language);
      if (response.statusCode == 200) {
        _isLoaded = true;
        Map<String, dynamic> placeData = response.body["results"];
        // Tạo một đối tượng restaurant từ dữ liệu của nhà hàng
        dish = Dish.fromJson(placeData);
        update();
      } else {
        // Xử lý trường hợp phản hồi không thành công ở đây
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      // Xử lý lỗi khác, chẳng hạn như lỗi kết nối
      print("Error in get dishes Detail: $e");
    }
    return dish;
  }

  Future<List<String>> getImageList(int restaurantID) async {
    List<String> images = [];
    try {
      // Chờ hàm getRestaurantDetail hoàn thành và trả về một đối tượng Restaurant
      Dish? dish = await getDishDetail(restaurantID);

      if (dish != null) {
        String? multiimage = dish.multiimage;
        if (multiimage != null) {
          multiimage = multiimage.substring(1, multiimage.length - 1);
          List<String> imageUrls = multiimage.split("\",\"");
          for (String imageUrl in imageUrls) {
            imageUrl = imageUrl.replaceAll('"', '');
            images.add(imageUrl);
          }
        } else {
          images.add(dish.image!);
        }
      }
    } catch (e) {
      print("Error in getImageList: $e");
    }
    return images;
  }
}
