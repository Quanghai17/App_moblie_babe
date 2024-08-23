import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/pages/tour/tour_detail/tour_detail.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/icon_and_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HighLightTour extends StatefulWidget {
  const HighLightTour({super.key});

  @override
  State<HighLightTour> createState() => _HighLightTourState();
}

class _HighLightTourState extends State<HighLightTour> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localization) {
      return GetBuilder<TourController>(builder: (tourController) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius10)),
          height: 280,
          margin: EdgeInsets.only(
              left: Dimensions.width10, top: Dimensions.height10),
          child: ListView.builder(
            //physics: NeverScrollableScrollPhysics(),
            itemCount: tourController.tourList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print("you just click on tour: " + index.toString());
                  Get.toNamed(RouteHelper.getTourDetailPage(
                      tourController.tourList[index].id!, "tourPage"));
                },
                child: Container(
                  height: 280,
                  width: 230,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
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
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Positioned(
                        bottom: Dimensions.height10,
                        left: 0,
                        child: Container(
                          width: 230,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: tourController.tourList[index].title!,
                                color: Colors.white,
                                size: Dimensions.font20,
                                maxLines: 2,
                              ),
                              IconAndTextWidget(
                                text: tourController.tourList[index].address!,
                                textColor: Colors.white,
                                icon: Icons.location_on,
                                iconSize: Dimensions.iconSize16,
                                iconColor: Colors.white,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              ElevatedButton(
                                onPressed: () {
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
                      ),
                      Positioned(
                        bottom: 10,
                        right: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            //origin price
                            Text(
                              "1.500.000 VNĐ",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.white),
                            ),
                            //sale price
                            //sale price
                            BigText(
                              text: _formatCurrency(
                                  tourController.tourList[index].price!),
                              color: Colors.amber[700],
                              size: Dimensions.font20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      });
    });
  }

  String _formatCurrency(num price) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(price);
  }
}
