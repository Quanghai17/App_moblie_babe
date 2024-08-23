import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/places_controller.dart';
import 'package:flutter_babe/models/places_model.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class PlacePage extends StatefulWidget {
  const PlacePage({Key? key}) : super(key: key);

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  final PlacesController placesController = Get.find<PlacesController>();
  int page = 1;
  ScrollController scrollController = ScrollController();
  bool showbtn = false;

  @override
  void initState() {
    super.initState();
    // scrollController.addListener(() {
    //   double showoffset = 10.0;
    //   if (scrollController.offset > showoffset) {
    //     showbtn = true;
    //     setState(() {});
    //   } else {
    //     showbtn = false;
    //     setState(() {});
    //   }
    // });
    scrollController.addListener(() {
      double showoffset = 10.0;
      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {});
      } else {
        showbtn = false;
        setState(() {});
      }
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMorePlaces();
      }
    });
    placesController.getAllPlacesList(null, page);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlacesController>(builder: (controller) {
      if (!controller.isLoaded) {
        return CustomLoader();
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text("accommodation_facility".tr),
            centerTitle: true,
          ),
          floatingActionButton: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: showbtn ? 1.0 : 0.0,
            child: FloatingActionButton(
              heroTag: "places_page",
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
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius10),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width20,
                vertical: Dimensions.height10,
              ),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: placesController.placesList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _buildPlaceItem(index);
                    },
                  ),
                  if (!placesController.isLastPage)
                    Center(child: CircularProgressIndicator())
                  else
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      child: BigText(
                        text: "all_of_list".tr,
                        size: Dimensions.font16,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  Widget _buildPlaceItem(int index) {
    Places place = placesController.placesList[index];
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getPlaceDetail(place.id!, "placePage"));
      },
      child: Container(
        width: Dimensions.screenWidth,
        height: Dimensions.height10 * 18,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
        ),
        margin: EdgeInsets.only(
          bottom: Dimensions.height10,
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              // Image
              Container(
                width: Dimensions.width10 * 9,
                child: CachedNetworkImage(
                  imageUrl: AppConstants.BASE_URL + "storage/" + place.image!,
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
                  placeholder: (context, url) => Container(
                      width: 30,
                      height: 30,
                      child: Center(child: CircularProgressIndicator())),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(width: Dimensions.width10),
              // Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BigText(
                      text: place.title!,
                      size: Dimensions.font16,
                      maxLines: 2,
                      color: AppColors.textColorBlue800,
                    ),
                    SizedBox(height: Dimensions.height10 / 2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.colorAppBar,
                          size: Dimensions.iconSize16,
                        ),
                        SizedBox(width: Dimensions.width10),
                        Expanded(
                          child: SmallText(
                            text: place.address!,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10 / 2),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: AppColors.colorAppBar,
                          size: Dimensions.iconSize16,
                        ),
                        SizedBox(width: Dimensions.width10),
                        Expanded(
                          child: SmallText(
                            text: place.phone != null
                                ? place.phone!
                                : "updating".tr,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height10 / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        ElevatedButton(
                          onPressed: () {
                            Get.toNamed(RouteHelper.getPlaceDetail(
                              place.id!,
                              "placePage",
                            ));
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.colorButton!),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                              ),
                            ),
                          ),
                          child: Text(
                            "view_detail".tr,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadMorePlaces() {
    page++;
    placesController.getAllPlacesList(null, page);
  }
}
