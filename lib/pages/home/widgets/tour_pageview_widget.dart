import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/models/tour_modal.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class TourPageview extends StatefulWidget {
  final List<Tour> tourList;

  const TourPageview({
    Key? key,
    required this.tourList,
  }) : super(key: key);

  @override
  State<TourPageview> createState() => _TourPageviewState();
}

class _TourPageviewState extends State<TourPageview> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return Container(
        height: Dimensions.height10 * 31,
        margin: EdgeInsets.only(left: Dimensions.width10),
        child: ListView.builder(
          itemCount: widget.tourList.length >= 8
              ? 9
              : widget.tourList.length +
                  1, // Thêm một phần tử cho nút "See more"
          scrollDirection: Axis.horizontal,
          shrinkWrap: false,
          itemBuilder: (context, index) {
            if (index == 8 || index == widget.tourList.length) {
              // Phần tử cuối cùng là nút "See more"
              return GestureDetector(
                onTap: () {},
                child: Container(
                  height: Dimensions.height10 *
                      30, // chiều cao tương tự như các mục khác
                  width: Dimensions.width10 *
                      26, // chiều rộng tương tự như các mục khác
                  margin: EdgeInsets.only(right: Dimensions.width10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius10,
                    ),
                    color: Colors.grey[200],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.getTourPage());
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.colorButton!),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                      ),
                    ),
                    child: Text(
                      "see_more".tr,
                    ),
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getTourDetailPage(
                      widget.tourList[index].id!, "homePage"));
                },
                child: Container(
                  height: Dimensions.height10 * 30, // theo thiet ke se la 312
                  width: Dimensions.width10 * 26, //243
                  margin: EdgeInsets.only(right: Dimensions.width10),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: AppConstants.BASE_URL +
                            "storage/" +
                            widget.tourList[index].imageMoblie!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius10,
                            ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
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
                      Positioned(
                        bottom: Dimensions.height45,
                        left: 0,
                        child: Container(
                          width: Dimensions.screenWidth * 0.6,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: widget.tourList[index].title ?? "",
                                color: Colors.white,
                                size: Dimensions.font26,
                                maxLines: 1,
                              ),
                              SmallText(
                                text: widget.tourList[index].desc ?? "",
                                size: Dimensions.font16,
                                color: Colors.white,
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
    });
  }
}
