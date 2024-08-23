import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/icon_and_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NormalTour extends StatefulWidget {
  const NormalTour({super.key});

  @override
  State<NormalTour> createState() => _NormalTourState();
}

class _NormalTourState extends State<NormalTour> {
  final TourController tourController = Get.find<TourController>();

  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tourController.getTourList(null, page).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TourController>(builder: (tourController) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius10)),
        //height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        margin: EdgeInsets.only(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height10),
        child: ListView.builder(
          itemCount: tourController.tourList.length,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true, // Set shrinkWrap to true
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getTourDetailPage(
                    tourController.tourList[index].id!, "tourPage"));
              },
              child: Container(
                width: Dimensions.screenWidth,
                height: Dimensions.height10 * 15,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius20)),
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
                              tourController.tourList[index].image!,
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
                                child:
                                    Center(child: CircularProgressIndicator())),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      //information
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Dimensions.screenWidth * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconAndTextWidget(
                                    icon: Icons.location_on,
                                    text:
                                        tourController.tourList[index].address!,
                                    textSize: Dimensions.font16,
                                    iconSize: Dimensions.font16,
                                    textColor: Colors.lightBlue,
                                    iconColor: Colors.lightBlue),
                                BigText(
                                  text: tourController.tourList[index].title!,
                                  size: Dimensions.font16,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            //color: Colors.amber,
                            width: Dimensions.screenWidth * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      text: _formatCurrency(tourController
                                          .tourList[index].price!),
                                      color: Colors.amber[700],
                                      size: Dimensions.font20,
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    print(
                                        "You just clicked on book now with Tour ID: " +
                                            index.toString());
                                    Get.toNamed(RouteHelper.getTourDetailPage(
                                        tourController.tourList[index].id!,
                                        "tourPage"));
                                  },
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 255, 160, 0)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                      ),
                                    ),
                                  ),
                                  child: Text("see_more".tr),
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
      );
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
