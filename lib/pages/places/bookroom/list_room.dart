import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_room_controller.dart';
import 'package:flutter_babe/controller/room_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/custom_snackbar.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

const List<int> list = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

class ListRooms extends StatefulWidget {
  int ownerID;
  String pageID;
  ListRooms({super.key, required this.ownerID, required this.pageID});

  @override
  State<ListRooms> createState() => _ListRoomsState();
}

class _ListRoomsState extends State<ListRooms> {
  final RoomsController roomsController = Get.find<RoomsController>();
  final BookRoomController bookRoomController = Get.find<BookRoomController>();
  List<int> dropdownValues = [];
  late List<bool> _checked;

  @override
  void initState() {
    super.initState();
    roomsController.getAllRoom(widget.ownerID);
    _checked = List<bool>.filled(roomsController.roomList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomsController>(builder: (controller) {
      if (!controller.isLoaded) {
        return CustomLoader();
      } else {
        if (dropdownValues.length != controller.roomList.length) {
          dropdownValues =
              List<int>.filled(controller.roomList.length, list.first);
        }
        return controller.roomList.length > 0
            ? Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "room_list".tr,
                      color: AppColors.textColorBlue800,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.roomList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getRoomDetail(
                                controller.roomList[index].id!,
                                "bookRoomPage"));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: Dimensions.height10),
                            width: Dimensions.screenWidth,
                            height: Dimensions.height20 * 9,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[100]!),
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 211, 201, 201),
                                  offset: const Offset(
                                    1.5,
                                    1.5,
                                  ),
                                  blurRadius: 2.0,
                                  spreadRadius: 1.0,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // decoration: BoxDecoration(
                                  //     borderRadius:
                                  //         BorderRadius.circular(Dimensions.radius10),
                                  //     image: DecorationImage(
                                  //         image: NetworkImage(
                                  //           AppConstants.BASE_URL +
                                  //               "storage/" +
                                  //               controller.roomList[index].image!,
                                  //         ),
                                  //         fit: BoxFit.cover)),
                                  height: Dimensions.height20 * 9,
                                  width: Dimensions.width20 * 6,
                                  child: CachedNetworkImage(
                                    imageUrl: AppConstants.BASE_URL +
                                        "storage/" +
                                        controller.roomList[index].image!,
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
                                              child:
                                                  CircularProgressIndicator())),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                Container(
                                  width: Dimensions.screenWidth * 0.45,
                                  height: Dimensions.height20 * 8.5,
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text: controller.roomList[index].title!,
                                        maxLines: 2,
                                        color: AppColors.textColorBlue800,
                                        size: Dimensions.font16,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10 / 2,
                                      ),
                                      BigText(
                                        text: 'Reference price'.tr,
                                        color: Colors.lightBlue,
                                        maxLines: 2,
                                        size: Dimensions.font16,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10 / 2,
                                      ),
                                      SmallText(
                                        text: "number_of_bed".tr +
                                            controller
                                                .roomList[index].numberOfBeds!
                                                .toString(),
                                        color: AppColors.textColorBlue800,
                                        size: Dimensions.font16,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10 / 2,
                                      ),
                                      SmallText(
                                        text: "select_number".tr,
                                        size: Dimensions.font16,
                                        color: AppColors.textColorBlue800,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10 / 2,
                                      ),
                                      Container(
                                        height: Dimensions.height10 * 3.5,
                                        width: Dimensions.screenWidth * .25,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.colorButton!),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius10)),
                                        child: Center(
                                          child: DropdownButton<int>(
                                            value: dropdownValues[index],
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 15,
                                            ),
                                            elevation: 16,
                                            style: TextStyle(
                                                color: AppColors.colorButton!),
                                            underline: SizedBox(),
                                            onChanged: (int? value) {
                                              print("check number of room: " +
                                                  value.toString());
                                              setState(() {
                                                dropdownValues[index] = value!;
                                                bookRoomController
                                                    .updateQuantityRoom(
                                                  controller
                                                      .roomList[index].id!,
                                                  controller
                                                      .roomList[index].title
                                                      .toString(),
                                                  controller
                                                      .roomList[index].price
                                                      .toString(),
                                                  dropdownValues[index]
                                                      .toString(),
                                                );
                                              });
                                            },
                                            items: list
                                                .map<DropdownMenuItem<int>>(
                                                    (int value) {
                                              return DropdownMenuItem<int>(
                                                value: value,
                                                child: Text(
                                                  value.toString() + "room".tr,
                                                  style: TextStyle(
                                                      fontSize:
                                                          Dimensions.font16),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: Dimensions.height10 * 5,
                                  width: Dimensions.width10 * 5,
                                  child: Checkbox(
                                    value: _checked[index],
                                    activeColor: AppColors.colorAppBar,
                                    checkColor: Colors.white,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _checked[index] = value!;
                                        if (value == true) {
                                          bookRoomController.addRoomToSelection(
                                              controller.roomList[index].id!,
                                              controller.roomList[index].title
                                                  .toString(),
                                              controller.roomList[index].price
                                                  .toString(),
                                              dropdownValues[index].toString());
                                          CustomSnackBar(
                                              "${controller.roomList[index].title}" +
                                                  "added_room".tr,
                                              isError: false,
                                              title: "book_room".tr);
                                        } else {
                                          bookRoomController
                                              .removeRoomFromSelection(
                                                  controller
                                                      .roomList[index].id!);
                                          CustomSnackBar(
                                              "${controller.roomList[index].title}" +
                                                  "deleted_room".tr,
                                              isError: true,
                                              title: "book_room".tr);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            : Container(
                width: Dimensions.screenWidth,
                child: SmallText(
                  text: "there_is_no_room".tr,
                  size: Dimensions.font16,
                  color: Colors.deepOrange,
                ),
              );
      }
    });
  }

  String _formatCurrency(num price) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(price);
  }
}
