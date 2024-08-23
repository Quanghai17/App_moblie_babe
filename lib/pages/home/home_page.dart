import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/places_controller.dart';
import 'package:flutter_babe/controller/post_controller.dart';
import 'package:flutter_babe/controller/restaurant_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/pages/home/body_home_page.dart';
import 'package:flutter_babe/pages/menuSlider/menu_slider.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _loadResource() async {
    await Get.find<PostController>().getAllPostList(null, 1);
    await Get.find<PostController>().getFeaturePostList();
    await Get.find<RestaurantController>().getAllRestaurantList(null, 1);
    await Get.find<PlacesController>().getSomePlaces();
    await Get.find<TourController>().getTourList(null, 1);
    await Get.find<TouristAttractionController>()
        .getTouristAttractionList(null, 1);
  }

  bool isConnectedToInternet = true;
  late StreamSubscription subscription;

  ScrollController scrollController = ScrollController();
  bool showbtn = false;

  @override
  void initState() {
    scrollController.addListener(() {
      double showoffset = 10.0;

      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {});
      } else {
        showbtn = false;
        setState(() {});
      }
    });
    super.initState();
    subscription =
        InternetConnectionCheckerPlus().onStatusChange.listen((event) {
      switch (event) {
        case InternetConnectionStatus.connected:
          setState(() {
            isConnectedToInternet = true;
            _loadResource();
          });
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
        default:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizationController) {
        return Scaffold(
          appBar: AppBar(
            title: Text("home".tr),
            centerTitle: true,
            actions: [
              InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.getNotificationPage());
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.notifications),
                ),
              ),
            ],
          ),
          drawer: MenuSlider(),
          floatingActionButton: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: showbtn ? 1.0 : 0.0,
            child: FloatingActionButton(
              heroTag: "home_page",
              onPressed: () {
                scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              },
              backgroundColor: AppColors.colorAppBar,
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _loadResource,
            child: isConnectedToInternet
                ? SingleChildScrollView(
                    controller: scrollController,
                    child: BodyHomePage(),
                  )
                //kéo xuống mất thanh app bar thì sử dụng phần comment bên dưới và bỏ phần SingleChildScrollView từ dòng 127 -> 129
                // ? CustomScrollView(
                //     controller: scrollController,
                //     slivers: <Widget>[
                //       SliverAppBar(
                //         actions: [
                //           InkWell(
                //             onTap: () {
                //               Get.toNamed(RouteHelper.getNotificationPage());
                //             },
                //             child: Padding(
                //               padding: EdgeInsets.all(8.0),
                //               child: Icon(Icons.notifications),
                //             ),
                //           ),
                //         ],
                //         backgroundColor: AppColors.colorAppBar,
                //         floating: true,
                //         snap: true,
                //         title: Text("home".tr),
                //         centerTitle: true,
                //       ),
                //       SliverToBoxAdapter(
                //         child: BodyHomePage(),
                //       ),
                //     ],
                //   )
                : Container(
                    height: Dimensions.screenHeight,
                    width: Dimensions.screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off,
                          color: Theme.of(context).disabledColor,
                          size: Dimensions.iconSize26 * 1.5,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        BigText(text: "no_internet".tr),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
