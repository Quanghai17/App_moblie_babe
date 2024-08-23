import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late SharedPreferences sharedPreference;

  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  // Future<void> _loadResource() async {

  // }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPreference = Get.find();
    var language = sharedPreference.getString(AppConstants.LANGUAGE_CODE);
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..forward();

    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    if (language == "vi" || language == "en") {
      Timer(
        Duration(seconds: 5),
        () => Get.offNamed(RouteHelper.getMenuPage()),
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () => Get.toNamed(RouteHelper.getLanguageRoute(false)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/images/logobabe.png",
                width: Dimensions.splashImg,
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          Center(
            // child: Image.asset(
            //   "assets/image/.png",
            //   width: Dimensions.splashImg,
            // ),
            child: Text("Ba_Be_Tourism".tr,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: Dimensions.font26,
                  fontFamily: 'Times New Roman',
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
