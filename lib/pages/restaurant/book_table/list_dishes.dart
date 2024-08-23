import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/book_table_controller.dart';
import 'package:flutter_babe/controller/dishes_controller.dart';
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

class ListDishes extends StatefulWidget {
  int ownerID;
  String pageID;
  ListDishes({super.key, required this.ownerID, required this.pageID});

  @override
  State<ListDishes> createState() => _ListDishesState();
}

class _ListDishesState extends State<ListDishes> {
  final DishesController dishesController = Get.find<DishesController>();

  final BookTableController bookTableController =
      Get.find<BookTableController>();

  late List<bool> _checked;
  late List<TextEditingController> _quantityControllers;

  @override
  void initState() {
    super.initState();
    dishesController.getAllDishes(widget.ownerID);
    _checked = List<bool>.filled(dishesController.dishesList.length, false);
    _quantityControllers = List.generate(dishesController.dishesList.length,
        (index) => TextEditingController(text: "1"));
  }

  @override
  void dispose() {
    // Clean up controllers
    _quantityControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DishesController>(builder: (controller) {
      if (!controller.isLoaded) {
        return CustomLoader();
      } else {
        return controller.dishesList.length > 0
            ? Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "dishes_list".tr,
                      color: AppColors.textColorBlue800,
                    ),
                    ListView.builder(
                      itemCount: controller.dishesList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getDishDetail(
                                controller.dishesList[index].id!,
                                "bookTablePage"));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: Dimensions.height10),
                            width: Dimensions.screenWidth,
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
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: Dimensions.height20 * 5,
                                  width: Dimensions.width20 * 5,
                                  // decoration: BoxDecoration(
                                  //   borderRadius:
                                  //       BorderRadius.circular(Dimensions.radius10),
                                  //   image: DecorationImage(
                                  //     image: NetworkImage(
                                  //       AppConstants.BASE_URL +
                                  //           "storage/" +
                                  //           controller.dishesList[index].image!,
                                  //     ),
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                  child: CachedNetworkImage(
                                    imageUrl: AppConstants.BASE_URL +
                                        "storage/" +
                                        controller.dishesList[index].image!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
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
                                              child:
                                                  CircularProgressIndicator())),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                // SizedBox(
                                //   width: Dimensions.width10,
                                // ),
                                Container(
                                  //color: AppColors.colorAppBar,
                                  width: Dimensions.screenWidth * 0.5,

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text:
                                            controller.dishesList[index].title!,
                                        maxLines: 2,
                                        color: AppColors.textColorBlue800,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10 / 2,
                                      ),
                                      BigText(
                                        text: 'price'.tr +
                                            _formatCurrency(dishesController
                                                .dishesList[index].price!),
                                        color: Colors.lightBlue,
                                        maxLines: 2,
                                        size: Dimensions.font16,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      Container(
                                        //padding: EdgeInsets.only(),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  int sum = int.parse(
                                                          _quantityControllers[
                                                                  index]
                                                              .text) -
                                                      1;
                                                  if (sum >= 1) {
                                                    _quantityControllers[index]
                                                        .text = sum.toString();
                                                    bookTableController
                                                        .updateQuantityDishes(
                                                            dishesController
                                                                .dishesList[
                                                                    index]
                                                                .id!,
                                                            dishesController
                                                                .dishesList[
                                                                    index]
                                                                .title!,
                                                            dishesController
                                                                .dishesList[
                                                                    index]
                                                                .price!
                                                                .toString(),
                                                            sum.toString());
                                                  } else {
                                                    _dialogBuilder(context);
                                                  }
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Icon(
                                                  Icons.remove,
                                                  size: Dimensions.iconSize24,
                                                  color: Colors.lightBlue,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            Container(
                                              width: Dimensions.width30,
                                              child: Center(
                                                child: BigText(
                                                  text: _quantityControllers[
                                                          index]
                                                      .text,
                                                  color:
                                                      AppColors.textColorBlack,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  int sum = int.parse(
                                                          _quantityControllers[
                                                                  index]
                                                              .text) +
                                                      1;

                                                  _quantityControllers[index]
                                                      .text = sum.toString();
                                                  bookTableController
                                                      .updateQuantityDishes(
                                                          dishesController
                                                              .dishesList[index]
                                                              .id!,
                                                          dishesController
                                                              .dishesList[index]
                                                              .title!,
                                                          dishesController
                                                              .dishesList[index]
                                                              .price!
                                                              .toString(),
                                                          sum.toString());
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Icon(
                                                  Icons.add,
                                                  size: Dimensions.iconSize24,
                                                  color: Colors.lightBlue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Spacer(),
                                Container(
                                  //color: Colors.red,
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
                                          bookTableController
                                              .addDishToSelection(
                                                  dishesController
                                                      .dishesList[index].id!,
                                                  controller
                                                      .dishesList[index].title
                                                      .toString(),
                                                  controller
                                                      .dishesList[index].price
                                                      .toString(),
                                                  _quantityControllers[index]
                                                      .text);
                                          CustomSnackBar(
                                              "${controller.dishesList[index].title}" +
                                                  "added_dish".tr,
                                              isError: false,
                                              title: "book_room".tr);
                                        } else {
                                          bookTableController
                                              .removeDishesFromSelection(
                                            dishesController
                                                .dishesList[index].id!,
                                          );
                                          CustomSnackBar(
                                              "${controller.dishesList[index].title}" +
                                                  "deleted_dish".tr,
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
                  text: "there_is_no_dish".tr,
                  color: Colors.deepOrange,
                  size: Dimensions.font16,
                ),
              );
      }
    });
  }

  String _formatCurrency(num price) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(price);
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('number_invalid'.tr),
          content: Text(
            'please_fill_number_again'.tr,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
