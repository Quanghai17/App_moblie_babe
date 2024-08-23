import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/places_controller.dart';
import 'package:flutter_babe/controller/post_controller.dart';
import 'package:flutter_babe/controller/restaurant_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/messages.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(seconds: 3));
  //await dep.init();
  Map<String, Map<String, String>> _languages = await dep.init();
  runApp(MyApp(languages: _languages));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;

  MyApp({super.key, required this.languages});
  //MyApp({required this.languages});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PostController>().getAllPostList(null, 1);
    Get.find<PostController>().getFeaturePostList();
    Get.find<RestaurantController>().getAllRestaurantList(null, 1);
    Get.find<PlacesController>().getSomePlaces();
    Get.find<TourController>().getTourList(null, 1);
    Get.find<TouristAttractionController>().getTouristAttractionList(null, 1);
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetBuilder<TourController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ba Be Travel',
          theme: ThemeData(
            primaryColor: AppColors.mainColor,
            fontFamily: "Lato",
          ),
          //home: Page(),
          locale: localizationController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode,
              AppConstants.languages[0].countryCode),
          initialRoute: RouteHelper.getSplashPage(),
          //initialRoute: RouteHelper.getMenuPage(),
          getPages: RouteHelper.routes,
          defaultTransition: Transition.topLevel,
        );
      });
    });
  }
}
