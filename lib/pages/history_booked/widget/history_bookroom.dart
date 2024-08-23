import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/history_book_room_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class HistoryBookRoomWidget extends StatefulWidget {
  const HistoryBookRoomWidget({super.key});

  @override
  State<HistoryBookRoomWidget> createState() => _HistoryBookRoomWidgetState();
}

class _HistoryBookRoomWidgetState extends State<HistoryBookRoomWidget> {
  final HistoryBookRoomController historyBookRoomController =
      Get.find<HistoryBookRoomController>();

  ScrollController scrollController = ScrollController();
  bool showbtn = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      double showoffset = 10.0;
      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {});
      } else {
        showbtn = false;
        setState(() {});
      }
    });
    historyBookRoomController.getDataHistoryBookRoom();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryBookRoomController>(builder: (controller) {
      if (controller.isLoading) {
        return CustomLoader();
      } else {
        if (controller.historyBookRoomList.isEmpty) {
          return Center(
            child: BigText(
              text: "no_orders_yet".tr,
              color: Theme.of(context).disabledColor,
              size: Dimensions.font20,
            ),
          );
        } else {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              child: ListView.builder(
                itemCount: controller.historyBookRoomList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        //color: Colors.amber,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        border:
                            Border.all(color: Theme.of(context).disabledColor)),
                    margin: EdgeInsets.only(
                        left: Dimensions.width10,
                        right: Dimensions.width10,
                        bottom: Dimensions.height10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SmallText(
                                  color: AppColors.textColorBlack,
                                  size: Dimensions.font16,
                                  text: "order_code".tr +
                                      controller.historyBookRoomList[index].id!
                                          .toString()),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              SmallText(
                                color: AppColors.textColorBlack,
                                size: Dimensions.font16,
                                text: "fullname".tr +
                                    ": " +
                                    controller.historyBookRoomList[index].name!,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              SmallText(
                                  color: AppColors.textColorBlack,
                                  size: Dimensions.font16,
                                  text: "check_in".tr +
                                      ": " +
                                      controller
                                          .historyBookRoomList[index].checkin!),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              SmallText(
                                  color: AppColors.textColorBlack,
                                  size: Dimensions.font16,
                                  text: "check_out".tr +
                                      ": " +
                                      controller.historyBookRoomList[index]
                                          .checkout!),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              Row(
                                children: [
                                  SmallText(
                                    text: "accommodation_facility".tr + ": ",
                                    size: Dimensions.font16,
                                  ),
                                  SmallText(
                                    text: controller.historyBookRoomList[index]
                                                .namePlace !=
                                            null
                                        ? controller.historyBookRoomList[index]
                                            .namePlace!
                                        : "updating".tr,
                                    size: Dimensions.font16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            child: ElevatedButton(
                              child: SmallText(
                                text: "view_detail".tr,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Get.toNamed(
                                    RouteHelper.getDetailHistoryBookRoom(
                                        controller
                                            .historyBookRoomList[index].id!,
                                        "history_bookRoom"));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.colorButton,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      }
    });
  }
}
