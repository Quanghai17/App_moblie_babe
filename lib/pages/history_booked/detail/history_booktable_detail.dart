import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/history_table_controller.dart';
import 'package:flutter_babe/models/history_book_table_model.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryBookTableDetail extends StatefulWidget {
  int bookTableId;
  String pageID;
  HistoryBookTableDetail(
      {super.key, required this.bookTableId, required this.pageID});

  @override
  State<HistoryBookTableDetail> createState() => _HistoryBookTableDetailState();
}

class _HistoryBookTableDetailState extends State<HistoryBookTableDetail> {
  final HistoryBookTableController historyBookTableController =
      Get.find<HistoryBookTableController>();

  HistoryBookTableModel? historyBookTableModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    historyBookTableController
        .getDetailHistoryBookTable(widget.bookTableId)
        .then((value) {
      setState(() {
        historyBookTableModel = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryBookTableController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text("booking_table_detail".tr),
          centerTitle: true,
          backgroundColor: AppColors.colorAppBar,
        ),
        body: historyBookTableModel != null
            ? SingleChildScrollView(
                child: Container(
                  //height: Dimensions.screenHeight,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "booking_information".tr),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "fullname".tr +
                                  ": " +
                                  historyBookTableModel!.name!,
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "phone".tr +
                                  ": " +
                                  historyBookTableModel!.phone!.toString(),
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "number_of_table".tr +
                                  historyBookTableModel!.numberTable!
                                      .toString(),
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "number_of_people".tr +
                                  historyBookTableModel!.people!.toString(),
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Row(
                              children: [
                                SmallText(
                                  text: "restaurant".tr + ": ",
                                  size: Dimensions.font16,
                                ),
                                SmallText(
                                  text: historyBookTableModel!.nameRestaurant !=
                                          null
                                      ? controller
                                          .historyBookTable!.nameRestaurant!
                                      : "updating".tr,
                                  size: Dimensions.font16,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "check_in".tr +
                                  ": " +
                                  historyBookTableModel!.date!,
                              size: Dimensions.font16,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            SmallText(
                              text: "time".tr +
                                  ": " +
                                  historyBookTableModel!.time!,
                              size: Dimensions.font16,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      BigText(text: "list_of_booked_dishes".tr),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      ListView.builder(
                        itemCount: controller.dishesListInBookedList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Get.toNamed(RouteHelper.getDishDetail(
                              //     controller.dishesListInBookedList[index].id!,
                              //     "historyBookTable"));
                            },
                            child: Container(
                              //color: AppColors.colorAppBar,
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.height10),
                              //height: Dimensions.height20 * 5,
                              width: Dimensions.screenWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   height: Dimensions.height20 * 5,
                                  //   width: Dimensions.width20 * 5,
                                  //   child: CachedNetworkImage(
                                  //     imageUrl: AppConstants.BASE_URL +
                                  //         "storage/" +
                                  //         controller
                                  //             .dishesListInBookedList[index]
                                  //             .image!,
                                  //     imageBuilder: (context, imageProvider) =>
                                  //         Container(
                                  //       decoration: BoxDecoration(
                                  //         borderRadius: BorderRadius.circular(
                                  //           Dimensions.radius10,
                                  //         ),
                                  //         image: DecorationImage(
                                  //           image: imageProvider,
                                  //           fit: BoxFit.cover,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     placeholder: (context, url) => Center(
                                  //       child: Container(
                                  //           width: 30,
                                  //           height: 30,
                                  //           child: Center(
                                  //               child:
                                  //                   CircularProgressIndicator())),
                                  //     ),
                                  //     errorWidget: (context, url, error) =>
                                  //         const Icon(Icons.error),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: Dimensions.width10,
                                  ),
                                  Container(
                                    width: Dimensions.screenWidth * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                          text: controller
                                              .dishesListInBookedList[index]
                                              .dish!,
                                          color: AppColors.colorAppBar,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10 / 2,
                                        ),
                                        SmallText(
                                          text: "price".tr +
                                              _formatCurrency(controller
                                                  .dishesListInBookedList[index]
                                                  .price!),
                                          size: Dimensions.font16,
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10 / 2,
                                        ),
                                        SmallText(
                                          text: "quantity".tr +
                                              controller
                                                  .dishesListInBookedList[index]
                                                  .quantity!
                                                  .toString(),
                                          size: Dimensions.font16,
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
                    ],
                  ),
                ),
              )
            : CustomLoader(),
      );
    });
  }

  String _formatCurrency(num price) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(price);
  }
}
