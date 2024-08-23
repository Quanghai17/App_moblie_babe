// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/places_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class StaggeredScreen extends StatelessWidget {
  const StaggeredScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlacesController>(builder: (placesController) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.all(Dimensions.height10),
            child: StaggeredGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(
                placesController.somePlacesList.length,
                (index) => StaggeredGridTile.count(
                  crossAxisCellCount:
                      (index == 0 || index == 5 || index == 8 || index == 13)
                          ? 2
                          : 1,
                  mainAxisCellCount:
                      (index == 1 || index == 4 || index == 9 || index == 12)
                          ? 2
                          : 1,
                  child: GestureDetector(
                    onTap: () {
                      print("you just clicked on placesID: " +
                          placesController.placesList[index].id!.toString());
                      Get.toNamed(RouteHelper.getPlaceDetail(
                          placesController.placesList[index].id!, "homePage"));
                    },
                    child: Stack(
                      children: [
                        Container(
                          child: CachedNetworkImage(
                            imageUrl: AppConstants.BASE_URL +
                                "storage/" +
                                placesController.somePlacesList[index].image!,
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
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black12, Colors.black54]),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0, // or any other position you want
                          right: 0, // or any other position you want
                          child: Container(
                            padding: EdgeInsets.all(
                                5.0), // Add padding to give space between text and edges
                            //color: Colors.black45, // Change color if needed
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  placesController.somePlacesList[index].title!,
                                  //textAlign: TextAlign., // Center align text
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                // Text(
                                //   "Phone: " +
                                //       placesController.placesList[index].phone!,
                                //   //textAlign: TextAlign., // Center align text
                                //   style: TextStyle(
                                //     color: Colors.white,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              //margin: EdgeInsets.only(right: Dimensions.width10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.radius10,
                ),
                //color: Colors.grey[200],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(RouteHelper.getPlacePage());
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.colorButton!),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                  ),
                ),
                child: Text(
                  "see_more".tr,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
