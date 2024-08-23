import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class OtherTourWidget extends StatefulWidget {
  const OtherTourWidget({super.key});

  @override
  State<OtherTourWidget> createState() => _OtherTourWidgetState();
}

class _OtherTourWidgetState extends State<OtherTourWidget> {
  final TouristAttractionController touristAttractionController =
      Get.find<TouristAttractionController>();
  int page = 1;
  @override
  void initState() {
    super.initState();
    touristAttractionController.getTourAttractListPGN(2, page).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TouristAttractionController>(builder: (controller) {
      if (!controller.isLoaded) {
        return CircularProgressIndicator();
      } else if (controller.touristAttractionOther.isEmpty) {
        return Center(child: Text("No tours available"));
      } else {
        return Container(
          margin: EdgeInsets.only(top: Dimensions.height20),
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Dimensions.screenWidth,
                child: Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10),
                  child: Column(children: [
                    GridView.builder(
                      physics:
                          NeverScrollableScrollPhysics(), // Disable GridView's scrolling
                      shrinkWrap:
                          true, // Wrap the GridView inside SingleChildScrollView
                      itemCount: controller.touristAttractionOther.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: Dimensions.height10 * 25,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                RouteHelper.getTouristAttractionDetailPage(
                                    controller.touristAttractionList[index].id!,
                                    "TourAttractionPage"));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 211, 201, 201),
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
                                        controller.touristAttractionOther[index]
                                            .image!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
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
                                            .touristAttractionOther[index]
                                            .title!,
                                        color: Colors.blue[800],
                                        size: Dimensions.font16,
                                      ),
                                      SizedBox(height: Dimensions.height10 / 2),
                                      Container(
                                        width: Dimensions.screenWidth * 0.45,
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
                                                  Dimensions.screenWidth * 0.35,
                                              child: SmallText(
                                                text: controller
                                                    .touristAttractionOther[
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
                                            .touristAttractionOther[index]
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
                    !touristAttractionController.isLastPage
                        ? ElevatedButton(
                            onPressed: () {
                              //_loadMoreOtherTour();
                              setState(() {
                                _loadMoreOtherTour();
                              });
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.colorButton!),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                ),
                              ),
                            ),
                            child: Text(
                              "see_more".tr,
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ]),
                ),
              ),
              // NumberPagination(
              //   onPageChanged: (int pageNumber) async {
              //     setState(() {
              //       selectedPageNumber = pageNumber;
              //     });
              //     touristAttractionController.getTourAttractListPGN(
              //         2, pageNumber);
              //   },
              //   threshold: 3,
              //   pageTotal: totalPage, // Đảm bảo rằng totalPageInView không null
              //   pageInit: touristAttractionController
              //       .currentPage, // picked number when init page
              //   colorPrimary: AppColors.colorAppBar!,
              //   colorSub: Colors.white,
              // ),
            ],
          ),
        );
      }
    });
  }

  void _loadMoreOtherTour() {
    setState(() {
      page++;
    });
    touristAttractionController.getTourAttractListPGN(2, page).then((value) {
      setState(() {});
    });
  }
}
