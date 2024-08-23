import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/auth_controller.dart';
import 'package:flutter_babe/controller/book_table_controller.dart';
import 'package:flutter_babe/controller/dishes_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_snackbar.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DishesWidget extends StatefulWidget {
  final int owner_id;
  final int restaurantID;
  DishesWidget({Key? key, required this.owner_id, required this.restaurantID})
      : super(key: key);

  @override
  State<DishesWidget> createState() => _DishesWidgetState();
}

class _DishesWidgetState extends State<DishesWidget> {
  late DishesController dishesController;
  final BookTableController bookTableController =
      Get.find<BookTableController>();

  @override
  void initState() {
    super.initState();
    dishesController = Get.find<DishesController>();
    dishesController.getAllDishes(widget.owner_id);
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = Get.find<AuthController>().userLoggedIn();
    return GetBuilder<DishesController>(builder: (controller) {
      if (!controller.isLoaded) {
        return CircularProgressIndicator();
      } else {
        return !controller.dishesList.isEmpty
            ? Container(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controller.dishesList.length,
                  itemBuilder: (context, index) {
                    // Hiển thị thông tin về từng phòng
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getDishDetail(
                            controller.dishesList[index].id!,
                            "restaurantDetail"));
                      },
                      child: Container(
                        //padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: controller.dishesList[index].title!,
                              color: Colors.lightBlue,
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            // Image.network(
                            //   AppConstants.BASE_URL +
                            //       "/storage/" +
                            //       controller.dishesList[index].image!,
                            //   height: Dimensions.height100 * 3,
                            //   fit: BoxFit.cover,
                            // ),
                            Container(
                              height: Dimensions.height100 * 3,
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
                                          child: CircularProgressIndicator())),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Theme.of(context)
                                              .disabledColor))),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: "price".tr +
                                        _formatCurrency(controller
                                            .dishesList[index].price!),
                                    color: Colors.lightBlue,
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  SmallText(
                                    text: controller.dishesList[index].desc!,
                                    color: Colors.blue[800],
                                    size: Dimensions.font16,
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            GestureDetector(
                              onTap: () {
                                // bookTableController.addDishToSelection(
                                //     controller.dishesList[index].id.toString());

                                // Get.toNamed(RouteHelper.getBookTablePage(
                                //     widget.restaurantID, "restaurantDetail"));
                                if (isLogin) {
                                  Get.toNamed(RouteHelper.getBookTablePage(
                                      widget.restaurantID, "restaurantDetail"));
                                } else {
                                  CustomSnackBar("please_login".tr,
                                      isError: false, title: "login".tr);
                                  ;
                                  Get.toNamed(RouteHelper.getSignInPage(),
                                      arguments: RouteHelper.getBookTablePage(
                                          widget.restaurantID,
                                          "restaurantDetail"));
                                }
                              },
                              child: Container(
                                height: Dimensions.height10 * 5,
                                width: Dimensions.screenWidth,
                                decoration: BoxDecoration(
                                    color: AppColors.colorButton,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius10)),
                                child: Center(
                                    child: BigText(
                                  text: "book_now".tr,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : SizedBox();
      }
    });
  }

  String _formatCurrency(num price) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(price);
  }
}
