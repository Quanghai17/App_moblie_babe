import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/places_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class OtherHotelWidget extends StatefulWidget {
  const OtherHotelWidget({Key? key}) : super(key: key);

  @override
  State<OtherHotelWidget> createState() => _OtherHotelWidgetState();
}

class _OtherHotelWidgetState extends State<OtherHotelWidget> {
  late PlacesController placesController;

  @override
  void initState() {
    super.initState();
    // Tạo một đối tượng PlacesController
    placesController = Get.find<PlacesController>();
    // Gọi hàm để lấy danh sách các địa điểm
    placesController.getAllPlacesList(null, null);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlacesController>(builder: (controller) {
      if (!controller.isLoaded) {
        // Hiển thị một tiến trình tải nếu danh sách địa điểm chưa được tải
        return CircularProgressIndicator();
      } else {
        // Nếu danh sách địa điểm đã được tải, hiển thị danh sách trong ListView.builder
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.height10,
              ),
              BigText(
                text: "hotels_nearby".tr,
                color: Colors.blue[800],
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Container(
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // Hiển thị thông tin về từng địa điểm
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getPlaceDetail(
                            controller.placesList[index].id!, "placeDetail"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                        height: Dimensions.height10 * 10,
                        child: Row(
                          children: [
                            Container(
                              width: Dimensions.width10 * 10,
                              height: Dimensions.height10 * 10,
                              // decoration: BoxDecoration(
                              //   borderRadius:
                              //       BorderRadius.circular(Dimensions.radius10),
                              //   image: DecorationImage(
                              //     image: NetworkImage(AppConstants.BASE_URL +
                              //         "/storage/" +
                              //         controller.placesList[index].image!),
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              child: CachedNetworkImage(
                                imageUrl: AppConstants.BASE_URL +
                                    "storage/" +
                                    controller.placesList[index].image!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                                      child: Center(
                                          child: CircularProgressIndicator())),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Dimensions.screenWidth * 0.65,
                                  child: BigText(
                                    text: controller.placesList[index].title!,
                                    color: Colors.blue[800],
                                    size: Dimensions.font16,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Container(
                                  width: Dimensions.screenWidth * 0.65,
                                  child: SmallText(
                                    text: controller.placesList[index].address!,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
