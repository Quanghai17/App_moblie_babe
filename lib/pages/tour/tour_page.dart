import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/pages/tour/widgets/highlight_tour.dart';
import 'package:flutter_babe/pages/tour/widgets/normal_tour.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/icon_and_text.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';

class TourPage extends StatefulWidget {
  const TourPage({super.key});

  @override
  State<TourPage> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  bool isConnectedToInternet = true;
  late StreamSubscription subscription;

  final TourController tourController = Get.find<TourController>();
  int page = 1;
  ScrollController scrollControllerPage = ScrollController();
  bool showbtn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollControllerPage.addListener(() {
      double showoffset = 10.0;
      if (scrollControllerPage.offset > showoffset) {
        showbtn = true;
        setState(() {});
      } else {
        showbtn = false;
        setState(() {});
      }
      if (scrollControllerPage.position.pixels ==
          scrollControllerPage.position.maxScrollExtent) {
        _loadMoreTour();
      }
    });
    //tourController.getTourList(null, page);
    subscription =
        InternetConnectionCheckerPlus().onStatusChange.listen((event) {
      switch (event) {
        case InternetConnectionStatus.connected:
          setState(() {
            isConnectedToInternet = true;
            tourController.getTourList(null, page);
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
      return GetBuilder<TourController>(builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("tour".tr),
            centerTitle: true,
            backgroundColor: AppColors.colorAppBar,
          ),
          floatingActionButton: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: showbtn ? 1.0 : 0.0,
            child: FloatingActionButton(
              heroTag: "tour_page",
              onPressed: () {
                scrollControllerPage.animateTo(0,
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
          backgroundColor: Colors.grey[200],
          body: isConnectedToInternet
              ? SingleChildScrollView(
                  controller: scrollControllerPage,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 250,
                            width: Dimensions.screenWidth * 0.9,
                            margin: EdgeInsets.only(
                                top: Dimensions.height20,
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.white,
                                    Color.fromARGB(255, 238, 238, 238)
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20)),
                            //child: Text(""),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: Dimensions.height20,
                                left: Dimensions.width20),
                            child: HighLightTour(),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //_buildTourView()
                      //normal tour
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10)),
                        //height: Dimensions.screenHeight,
                        width: Dimensions.screenWidth,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            top: Dimensions.height10),
                        child: Column(
                          children: [
                            ListView.builder(
                              itemCount: controller.tourList.length,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true, // Set shrinkWrap to true
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getTourDetailPage(
                                        controller.tourList[index].id!,
                                        "tourPage"));
                                  },
                                  child: Container(
                                    width: Dimensions.screenWidth,
                                    height: Dimensions.height10 * 15,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20)),
                                    margin: EdgeInsets.only(
                                      bottom: Dimensions.height10,
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          //image
                                          Container(
                                            //height: 100,
                                            width: 90,
                                            // decoration: BoxDecoration(
                                            //     image: DecorationImage(
                                            //       image: NetworkImage(AppConstants.BASE_URL +
                                            //           "storage/" +
                                            //           tourController.tourList[index].image!),
                                            //       fit: BoxFit.cover,
                                            //     ),
                                            //     borderRadius:
                                            //         BorderRadius.circular(Dimensions.radius10)),
                                            child: CachedNetworkImage(
                                              imageUrl: AppConstants.BASE_URL +
                                                  "storage/" +
                                                  controller
                                                      .tourList[index].image!,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    Dimensions.radius10,
                                                  ),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  Center(
                                                child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator())),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.width10,
                                          ),
                                          //information
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Dimensions.screenWidth *
                                                    0.6,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    IconAndTextWidget(
                                                        icon: Icons.location_on,
                                                        text: tourController
                                                            .tourList[index]
                                                            .address!,
                                                        textSize:
                                                            Dimensions.font16,
                                                        iconSize:
                                                            Dimensions.font16,
                                                        textColor:
                                                            Colors.lightBlue,
                                                        iconColor:
                                                            Colors.lightBlue),
                                                    BigText(
                                                      text: controller
                                                          .tourList[index]
                                                          .title!,
                                                      size: Dimensions.font16,
                                                      maxLines: 2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                //color: Colors.amber,
                                                width: Dimensions.screenWidth *
                                                    0.6,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        //origin price
                                                        // Text(
                                                        //   "1.500.000 VNĐ",
                                                        //   style: TextStyle(
                                                        //       decoration:
                                                        //           TextDecoration.lineThrough,
                                                        //       color: Colors.grey),
                                                        // ),
                                                        //sale price
                                                        BigText(
                                                          text: _formatCurrency(
                                                              controller
                                                                  .tourList[
                                                                      index]
                                                                  .price!),
                                                          color:
                                                              Colors.amber[700],
                                                          size:
                                                              Dimensions.font20,
                                                        ),
                                                      ],
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        print(
                                                            "You just clicked on book now with Tour ID: " +
                                                                index
                                                                    .toString());
                                                        Get.toNamed(RouteHelper
                                                            .getTourDetailPage(
                                                                controller
                                                                    .tourList[
                                                                        index]
                                                                    .id!,
                                                                "tourPage"));
                                                      },
                                                      style: ButtonStyle(
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .white),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        160,
                                                                        0)),
                                                        shape: MaterialStateProperty
                                                            .all<
                                                                RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .radius20),
                                                          ),
                                                        ),
                                                      ),
                                                      child:
                                                          Text("see_more".tr),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            if (!controller.isLastPage)
                              Center(child: CircularProgressIndicator())
                            else
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height10),
                                child: BigText(
                                  text: "all_of_list".tr,
                                  size: Dimensions.font16,
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
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
        );
      });
    });
  }

  String _formatCurrency(num price) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(price);
  }

  void _loadMoreTour() {
    page++;
    tourController.getTourList(null, page);
  }
}
