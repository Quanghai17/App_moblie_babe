import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/restaurant_controller.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/controller/tourist_attraction_controller.dart';
import 'package:flutter_babe/pages/home/widgets/banner_widget.dart';
import 'package:flutter_babe/pages/home/widgets/news_pageview_widget.dart';
import 'package:flutter_babe/pages/home/widgets/restaurant_pageview_widget.dart';
import 'package:flutter_babe/pages/home/widgets/tour_pageview_widget.dart';
import 'package:flutter_babe/pages/home/widgets/tourist_attraction_widget.dart';
import 'package:flutter_babe/pages/skelton/pageview_skelton.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:flutter_babe/pages/home/widgets/staggered_gird.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({Key? key}) : super(key: key);

  @override
  State<BodyHomePage> createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TourController>(builder: (tourController) {
      return GetBuilder<TouristAttractionController>(
          builder: (touristAttractionController) {
        return GetBuilder<RestaurantController>(
            builder: (restaurantController) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //banner
              BannerWidget(),
              SizedBox(height: Dimensions.height10),
              //tour
              // _buildSection(
              //     "the_tour_is_of_most_interest".tr, "book_quickly".tr),
              // SizedBox(height: Dimensions.height10),
              // !tourController.isLoading
              //     ? TourPageview(tourList: tourController.tourList)
              //     : CustomSkelton(
              //         height: Dimensions.height10 * 31,
              //         width: Dimensions.width10 * 27,
              //       ),
              // SizedBox(height: Dimensions.height30),

              //tourist attraction
              _buildSection("attractive_tourist_destination".tr, "relax".tr),
              SizedBox(height: Dimensions.height10),
              !touristAttractionController.isLoading
                  ? TouristAttractionPageview()
                  : CustomSkelton(
                      height: Dimensions.height10 * 31,
                      width: Dimensions.width10 * 27,
                    ),
              SizedBox(height: Dimensions.height30),

              //places
              _buildSection("accommodation_facility".tr, "enjoy".tr),
              SizedBox(height: Dimensions.height10),
              StaggeredScreen(),
              SizedBox(height: Dimensions.height30),

              //explore cuisine
              _buildSection("explore_cuisine".tr, "countless_etc".tr),
              SizedBox(height: Dimensions.height10),
              RestaurantPageview(),
              SizedBox(height: Dimensions.height30),

              //news
              _buildSection("news_event".tr, ""),
              NewsPageviewWiget(),
              SizedBox(height: Dimensions.height10),
              //SizedBox(height: Dimensions.height30),
            ],
          );
        });
      });
    });
  }

  Widget _buildSection(String bigText, String smallText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: Dimensions.width10),
          child: BigText(text: bigText),
        ),
        SizedBox(height: 5),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width10),
          child: SmallText(
              text: smallText,
              color: AppColors.mainBlackColor,
              size: Dimensions.font16),
        ),
      ],
    );
  }
}
