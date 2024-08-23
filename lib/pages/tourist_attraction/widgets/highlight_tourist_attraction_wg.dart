import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class HighLightTouristAttraction extends StatefulWidget {
  const HighLightTouristAttraction({super.key});

  @override
  State<HighLightTouristAttraction> createState() =>
      _HighLightTouristAttractionState();
}

class _HighLightTouristAttractionState
    extends State<HighLightTouristAttraction> {
  PageController pageController = PageController(viewportFraction: 0.95);
  var _currentPageValue = 0.0;

  final TouristAttractionController touristAttractionController =
      Get.find<TouristAttractionController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        //print("curr value" + _currentPageValue.toString());
      });
    });

    //touristAttractionController.getTouristAttractionList(8, 1);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TouristAttractionController>(builder: (controller) {
      return Container(
        height: Dimensions.height200,
        child: Stack(
          children: [
            Container(
              //padding: EdgeInsets.all(10),
              height: Dimensions.height200,
              width: Dimensions.screenWidth,
              margin: EdgeInsets.only(
                  top: Dimensions.height20, left: Dimensions.width20),
              child: PageView.builder(
                itemCount: 5,
                controller: pageController,
                scrollDirection: Axis.horizontal,
                padEnds: false,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Get.toNamed(RouteHelper.getTouristAttractionDetailPage());
                    },
                    child: Container(
                      height: 200,
                      width: Dimensions.screenWidth,
                      margin: EdgeInsets.only(right: 10),
                      // decoration: BoxDecoration(
                      //   borderRadius:
                      //       BorderRadius.circular(Dimensions.radius10),
                      //   image: DecorationImage(
                      //     image: AssetImage('assets/images/ho_ba_be.jpg'),
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: AppConstants.BASE_URL +
                                "storage/" +
                                controller
                                    .outstandingTouristAttractionList[index]
                                    .image!,
                            imageBuilder: (context, imageProvider) => Container(
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
                                      child: CircularProgressIndicator())),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          Positioned(
                            bottom: Dimensions.height30,
                            left: 0,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: controller
                                        .outstandingTouristAttractionList[index]
                                        .title!,
                                    color: Colors.white,
                                    size: Dimensions.font20,
                                  ),
                                  Row(children: [
                                    Icon(
                                      Icons.location_on,
                                      size: Dimensions.iconSize16,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: Dimensions.height10 / 2,
                                    ),
                                    Container(
                                      width: Dimensions.screenWidth * 0.75,
                                      child: SmallText(
                                        text: controller
                                            .outstandingTouristAttractionList[
                                                index]
                                            .address!,
                                        size: Dimensions.font16,
                                        color: Colors.white,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ]),
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
    });
  }
}
