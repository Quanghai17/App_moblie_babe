import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/pages/tourist_attraction/widgets/highlight_tourist_attraction_wg.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class TouristAttractionPage extends StatefulWidget {
  const TouristAttractionPage({super.key});

  @override
  State<TouristAttractionPage> createState() => _TouristAttractionPageState();
}

class _TouristAttractionPageState extends State<TouristAttractionPage> {
  PageController pageController = PageController(viewportFraction: 0.95);
  var _currentPageValue = 0.0;
  int page = 1;
  ScrollController scrollControllerPage = ScrollController();
  bool showbtn = false;
  bool isConnectedToInternet = true;
  late StreamSubscription subscription;

  final TouristAttractionController touristAttractionController =
      Get.find<TouristAttractionController>();

  @override
  void initState() {
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
        _loadTouristAttraction();
      }
    });

    subscription =
        InternetConnectionCheckerPlus().onStatusChange.listen((event) {
      switch (event) {
        case InternetConnectionStatus.connected:
          setState(() {
            isConnectedToInternet = true;
            pageController.addListener(() {
              setState(() {
                _currentPageValue = pageController.page!;
                //print("curr value" + _currentPageValue.toString());
              });
            });

            touristAttractionController
                .getTouristAttractionList(8, page)
                .then((value) {
              setState(() {});
            });
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
    pageController.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TouristAttractionController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text("tourist_attraction".tr),
          centerTitle: true,
          backgroundColor: AppColors.colorAppBar,
        ),
        floatingActionButton: AnimatedOpacity(
          duration: const Duration(milliseconds: 1000),
          opacity: showbtn ? 1.0 : 0.0,
          child: FloatingActionButton(
            heroTag: "Outstanding tourist destination",
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
                  children: [
                    Container(
                      //height: 250,
                      color: Colors.white,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //PictureWidget(pageController, _currentPageValue),
                            HighLightTouristAttraction(),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            Container(
                                margin:
                                    EdgeInsets.only(left: Dimensions.width20),
                                child: BigText(
                                  text: "outstanding_tourist_destination".tr,
                                  color: Colors.blue[800],
                                )),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                          ]),
                    ),
                    Container(
                      // height: Dimensions.screenHeight,
                      margin: EdgeInsets.all(Dimensions.height20),
                      width: Dimensions.screenWidth,

                      child: Column(
                        children: [
                          GridView.builder(
                            physics:
                                NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                            shrinkWrap:
                                true, // Wrap the GridView inside SingleChildScrollView
                            itemCount: controller.touristAttractionList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: Dimensions.height10 * 25,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper
                                      .getTouristAttractionDetailPage(
                                          controller
                                              .touristAttractionList[index].id!,
                                          "TourAttractionPage"));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 211, 201, 201),
                                        offset: const Offset(
                                          1.5,
                                          1.5,
                                        ),
                                        blurRadius: 2.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: Dimensions.height10 * 15,
                                        padding: EdgeInsets.all(5),
                                        // decoration: BoxDecoration(
                                        //   //borderRadius: BorderRadius.circular(20),
                                        //   color: Colors.blue,
                                        //   image: DecorationImage(
                                        //     image: NetworkImage(
                                        //       AppConstants.BASE_URL +
                                        //           "storage/" +
                                        //           controller.touristAttractionList[index]
                                        //               .image!,
                                        //     ),
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        // ),
                                        child: CachedNetworkImage(
                                          imageUrl: AppConstants.BASE_URL +
                                              "storage/" +
                                              controller
                                                  .touristAttractionList[index]
                                                  .image!,
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
                                          placeholder: (context, url) => Center(
                                            child: Container(
                                                width: 30,
                                                height: 30,
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator())),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.height10 / 2),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: Dimensions.width10,
                                            right: Dimensions.width10),
                                        width: Dimensions.screenWidth * 0.45,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BigText(
                                              text: controller
                                                  .touristAttractionList[index]
                                                  .title!,
                                              color: Colors.blue[800],
                                              size: Dimensions.font16,
                                            ),
                                            SizedBox(
                                                height:
                                                    Dimensions.height10 / 2),
                                            Container(
                                              width:
                                                  Dimensions.screenWidth * 0.45,
                                              child: Row(children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.grey,
                                                  size: Dimensions.font16 - 2,
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width10 / 5,
                                                ),
                                                Container(
                                                    width:
                                                        Dimensions.screenWidth *
                                                            0.35,
                                                    child: SmallText(
                                                      text: controller
                                                          .touristAttractionList[
                                                              index]
                                                          .address!,
                                                      maxLines: 1,
                                                    )),
                                              ]),
                                            ),
                                            SizedBox(
                                              height: Dimensions.height10 / 2,
                                            ),
                                            SmallText(
                                              text: controller
                                                  .touristAttractionList[index]
                                                  .metaDescription!,
                                              maxLines: 2,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          if (!touristAttractionController.isLastPage)
                            Center(child: CircularProgressIndicator())
                          else
                            Container(
                              alignment: Alignment.center,
                              //margin: EdgeInsets.only(bottom: Dimensions.height10),
                              child: BigText(
                                text: "all_of_list".tr,
                                size: Dimensions.font16,
                              ),
                            ),
                        ],
                      ),
                    ),
                    // NumberPagination(
                    //   onPageChanged: (int pageNumber) {
                    //     setState(() {
                    //       // Gọi phương thức để chuyển đến trang mới
                    //       selectedPageNumber = pageNumber;
                    //       controller.getTouristAttractionList(8, pageNumber);
                    //     });
                    //   },
                    //   threshold: 2,
                    //   pageTotal: totalPage,
                    //   pageInit:
                    //       controller.currentPage, // picked number when init page
                    //   colorPrimary: AppColors.colorAppBar!,
                    //   colorSub: Colors.white,
                    // ),
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
  }

  void _loadTouristAttraction() {
    if (!touristAttractionController.isLastPage) {
      page++;
      touristAttractionController.getTouristAttractionList(8, page);
    }
  }
}

Widget PictureWidget(PageController pageController, var _currentPageValue) {
  return Container(
    height: 200,
    child: Stack(
      children: [
        Container(
          //padding: EdgeInsets.all(10),
          height: 200,
          width: Dimensions.screenWidth,
          margin: EdgeInsets.only(
              top: Dimensions.height20, left: Dimensions.width20),
          child: PageView.builder(
            itemCount: 5,
            controller: pageController,
            scrollDirection: Axis.horizontal,
            padEnds: false,
            itemBuilder: (context, index) {
              return _buildPageItem(index);
            },
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DotsIndicator(
                dotsCount: 5,
                position: _currentPageValue,
                decorator: const DotsDecorator(
                  color: Colors.white, // Inactive color
                  activeColor: Colors.amber,
                  size: Size.square(6.0),
                  activeSize: Size(15.0, 6.0),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPageItem(int index) {
  return GestureDetector(
    onTap: () {
      // Get.toNamed(RouteHelper.getTouristAttractionDetailPage());
    },
    child: Container(
      height: 200,
      width: Dimensions.screenWidth,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        image: DecorationImage(
          image: AssetImage('assets/images/ho_ba_be.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: Dimensions.height20,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 20, top: 2, right: 20, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber[600],
                    ),
                    child: Center(
                        child: BigText(
                      text: "New",
                      color: Colors.white,
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BigText(
                    text: "Hồ Ba Bể",
                    color: Colors.white,
                    size: Dimensions.font20,
                  ),
                  SmallText(
                    text: "Lorem",
                    size: Dimensions.font16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    print("You clicked on icon message");
                  },
                  child: Icon(
                    Icons.message_outlined,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width10,
                ),
                InkWell(
                    onTap: () {
                      print("you clicked on icon share");
                    },
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
