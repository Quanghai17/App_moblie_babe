import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_babe/controller/about_us_controller.dart';
import 'package:flutter_babe/controller/auth_controller.dart';
import 'package:flutter_babe/controller/banner_controller.dart';
import 'package:flutter_babe/controller/book_room_controller.dart';
import 'package:flutter_babe/controller/book_table_controller.dart';
import 'package:flutter_babe/controller/contact_controller.dart';
import 'package:flutter_babe/controller/dishes_controller.dart';
import 'package:flutter_babe/controller/history_book_room_controller.dart';
import 'package:flutter_babe/controller/history_table_controller.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/places_controller.dart';
import 'package:flutter_babe/controller/post_controller.dart';
import 'package:flutter_babe/controller/restaurant_controller.dart';
import 'package:flutter_babe/controller/room_controller.dart';
import 'package:flutter_babe/controller/search_controller.dart';
import 'package:flutter_babe/controller/setting_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/controller/user_controller.dart';
import 'package:flutter_babe/data/api/api_client.dart';
import 'package:flutter_babe/data/repository/about_us_repo.dart';
import 'package:flutter_babe/data/repository/auth_repo.dart';
import 'package:flutter_babe/data/repository/banner_repo.dart';
import 'package:flutter_babe/data/repository/book_room_repo.dart';
import 'package:flutter_babe/data/repository/book_table_repo.dart';
import 'package:flutter_babe/data/repository/contact_repo.dart';
import 'package:flutter_babe/data/repository/dish_repo.dart';
import 'package:flutter_babe/data/repository/history_book_room_repo.dart';
import 'package:flutter_babe/data/repository/history_table_repo.dart';
import 'package:flutter_babe/data/repository/places_repo.dart';
import 'package:flutter_babe/data/repository/post_repo.dart';
import 'package:flutter_babe/data/repository/restaurant_repo.dart';
import 'package:flutter_babe/data/repository/room_repo.dart';
import 'package:flutter_babe/data/repository/search_repo.dart';
import 'package:flutter_babe/data/repository/setting_repo.dart';
import 'package:flutter_babe/data/repository/tour_repo.dart';
import 'package:flutter_babe/data/repository/tourist_attraction_repo.dart';
import 'package:flutter_babe/data/repository/user_repo.dart';
import 'package:flutter_babe/models/languages.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  //SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //apiClient
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //Repository
  Get.lazyPut(
      () => SettingRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => TourRepo(apiClient: Get.find()));
  Get.lazyPut(() => TouristAttractionRepo(apiClient: Get.find()));
  Get.lazyPut(() => PostRepo(apiClient: Get.find()));
  Get.lazyPut(() => PlacesRepo(apiClient: Get.find()));
  Get.lazyPut(() => RestaurantRepo(apiClient: Get.find()));
  Get.lazyPut(() => RoomRepo(apiClient: Get.find()));
  Get.lazyPut(() => DishRepo(apiClient: Get.find()));
  Get.lazyPut(() => AboutUsRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => UserRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ContactRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      SearchResultRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => BookRoomRepo(apiClient: Get.find()));
  Get.lazyPut(() => BookTableRepo(apiClient: Get.find()));
  Get.lazyPut(() => HistoryBookTableRepo(apiClient: Get.find()));
  Get.lazyPut(() => HistoryBookRoomRepo(apiClient: Get.find()));
  Get.lazyPut(() => BannerRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => SettingController(
      settingRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      TourController(tourRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => TouristAttractionController(
      touristAttractionRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      PostController(postRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      PlacesController(placesRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => RestaurantController(
      restaurantRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      RoomsController(roomRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      DishesController(dishRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AboutUsController(
      aboutUsRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => ContactController(contactRepo: Get.find()));
  Get.lazyPut(() => SearchResultController(
      searchResutlRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => BookRoomController(bookRoomRepo: Get.find()));
  Get.lazyPut(() => BookTableController(bookTableRepo: Get.find()));
  Get.lazyPut(() => HistoryBookTableController(
      historyBookTableRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => HistoryBookRoomController(
      historyBookRoomRepo: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => BannerController(bannerRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/languages/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();

    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }

  return _languages;
}
