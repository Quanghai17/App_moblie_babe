import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/history_table_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';

class HistoryBookTableWidget extends StatefulWidget {
  const HistoryBookTableWidget({super.key});

  @override
  State<HistoryBookTableWidget> createState() => _HistoryBookTableWidgetState();
}

class _HistoryBookTableWidgetState extends State<HistoryBookTableWidget> {
  final HistoryBookTableController historyBookTableController =
      Get.find<HistoryBookTableController>();

  @override
  void initState() {
    super.initState();
    historyBookTableController.getDataHistoryTable();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryBookTableController>(builder: (controller) {
      if (controller.isLoading) {
        return CustomLoader();
      } else {
        if (controller.historyBookTableList.isEmpty) {
          return Center(
            child: BigText(
              text: "no_orders_yet".tr,
              color: Theme.of(context).disabledColor,
              size: Dimensions.font20,
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Container(
              child: ListView.builder(
                itemCount: controller.historyBookTableList.length,
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
                                text: "order_code".tr +
                                    controller.historyBookTableList[index].id!
                                        .toString(),
                                color: AppColors.textColorBlack,
                                size: Dimensions.font16,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              SmallText(
                                text: "fullname".tr +
                                    ": " +
                                    controller
                                        .historyBookTableList[index].name!,
                                color: AppColors.textColorBlack,
                                size: Dimensions.font16,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              SmallText(
                                text: "check_in".tr +
                                    ": " +
                                    controller
                                        .historyBookTableList[index].date!,
                                color: AppColors.textColorBlack,
                                size: Dimensions.font16,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              SmallText(
                                text: "time".tr +
                                    ": " +
                                    controller
                                        .historyBookTableList[index].time!,
                                color: AppColors.textColorBlack,
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
                                    text: controller.historyBookTableList[index]
                                                .nameRestaurant !=
                                            null
                                        ? controller.historyBookTableList[index]
                                            .nameRestaurant!
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
                                    RouteHelper.getDetailHistoryBookTable(
                                        controller
                                            .historyBookTableList[index].id!,
                                        "historyBookTablePage"));
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
