import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/dishes_controller.dart';
import 'package:flutter_babe/models/dish_model.dart';
import 'package:flutter_babe/pages/restaurant/dishes_detail/gallery_dish.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class DishDetailPage extends StatefulWidget {
  int dishID;
  String pageID;
  DishDetailPage({super.key, required this.dishID, required this.pageID});

  @override
  State<DishDetailPage> createState() => _DishDetailPageState();
}

class _DishDetailPageState extends State<DishDetailPage> {
  final DishesController dishesController = Get.find<DishesController>();
  Dish? dish;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dishesController.getDishDetail(widget.dishID).then((value) {
      setState(() {
        dish = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dish_detail".tr),
        centerTitle: true,
        backgroundColor: AppColors.colorAppBar,
      ),
      body: dish != null
          ? SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: dish!.title!,
                      color: Colors.lightBlue,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    GalleryDishImage(dishID: dish!.id!, pageID: " Room Detail"),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    HtmlWidget(dish!.desc!),
                  ],
                ),
              ),
            )
          : CustomLoader(),
    );
  }
}
