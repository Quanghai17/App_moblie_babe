import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_table_controller.dart';
import 'package:flutter_babe/controller/dishes_controller.dart';
import 'package:flutter_babe/controller/room_controller.dart';
import 'package:flutter_babe/models/book_table_model.dart';
import 'package:flutter_babe/models/dish_model.dart';
import 'package:flutter_babe/pages/restaurant/book_table/widget/infor_dish_selected.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:get/get.dart';

class DishSelected extends StatefulWidget {
  const DishSelected({super.key});

  @override
  State<DishSelected> createState() => _DishSelectedState();
}

class _DishSelectedState extends State<DishSelected> {
  final BookTableController bookTableController =
      Get.find<BookTableController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookTableController>(
      builder: (bookTableController) {
        return Container(
          child: bookTableController.dishesSelectedList.isNotEmpty
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  BigText(
                    text: "selected_dishes_list".tr,
                    color: AppColors.textColorBlue800,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  ListView.builder(
                    itemCount: bookTableController.dishesSelectedList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final dishID =
                          bookTableController.dishesSelectedList[index].id;

                      return dishID != null
                          ? InforDishSelected(id: dishID)
                          : SizedBox();
                    },
                  ),
                ])
              : SizedBox(),
        );
      },
    );
  }
}
