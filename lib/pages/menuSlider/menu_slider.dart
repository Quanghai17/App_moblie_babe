import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/auth_controller.dart';
import 'package:flutter_babe/controller/user_controller.dart';
import 'package:flutter_babe/models/user_model.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_snackbar.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class MenuSlider extends StatefulWidget {
  const MenuSlider({super.key});

  @override
  State<MenuSlider> createState() => _MenuSliderState();
}

class _MenuSliderState extends State<MenuSlider> {
  var auth = Get.find<AuthController>().userLoggedIn();
  late UserController userController;
  UserModel? userModel;

  bool isConnectedToInternet = true;
  late StreamSubscription subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (auth) {
      userController = Get.find<UserController>();
      userController.getUserInfo();
    }

    subscription =
        InternetConnectionCheckerPlus().onStatusChange.listen((event) {
      switch (event) {
        case InternetConnectionStatus.connected:
          setState(() {
            isConnectedToInternet = true;
          });
          break;
        case InternetConnectionStatus.disconnected:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
        default:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color? active = AppColors.colorAppBar;
    Color? deactive = AppColors.mainBlackColor;
    return Drawer(
      child: isConnectedToInternet
          ? auth
              ? ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    GetBuilder<UserController>(builder: (controller) {
                      return UserAccountsDrawerHeader(
                        accountName: BigText(
                          text: controller.userModel?.name ?? "loading",
                          color: Colors.white,
                        ),
                        accountEmail: SmallText(
                          text: controller.userModel?.email ?? "loading",
                          color: Colors.white,
                          size: Dimensions.font16,
                        ),
                        currentAccountPicture: CircleAvatar(
                          child: ClipOval(
                            child: Container(
                              height: 90,
                              width: 90,
                              child: controller.userModel?.avatar != null
                                  ? CachedNetworkImage(
                                      imageUrl: AppConstants.BASE_URL +
                                          "storage/" +
                                          controller.userModel!.avatar!,
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
                                    )
                                  : Image.asset("assets/images/user.jpg"),
                            ),
                          ),
                        ),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/ho_ba_be_tren_cao.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                    ListTile(
                      leading: Icon(
                        Icons.home,
                        color: active,
                      ),
                      title: SmallText(
                        text: 'home'.tr,
                        size: Dimensions.font16,
                        color: deactive,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: active,
                      ),
                      title: SmallText(
                        text: 'profile'.tr,
                        size: Dimensions.font16,
                        color: deactive,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Get.toNamed(RouteHelper.getProfile());
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.newspaper,
                        color: active,
                      ),
                      title: SmallText(
                        text: "news".tr,
                        size: Dimensions.font16,
                        color: deactive,
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getNewsPage());
                      },
                    ),
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.tour_outlined,
                    //     color: active,
                    //   ),
                    //   title: SmallText(
                    //     text: "tour".tr,
                    //     size: Dimensions.font16,
                    //     color: deactive,
                    //   ),
                    //   onTap: () {
                    //     Get.toNamed(RouteHelper.getTourPage());
                    //   },
                    // ),
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: active,
                      ),
                      title: SmallText(
                        text: "tourist_attraction".tr,
                        size: Dimensions.font16,
                        color: deactive,
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getTouristAttractionPage());
                      },
                    ),
                    ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FontAwesomeIcons.hotel,
                            color: Colors.blue,
                            size: Dimensions.iconSize24,
                          ),
                        ],
                      ),
                      title: SmallText(
                        text: "accommodation_facility".tr,
                        size: Dimensions.font16,
                        color: deactive,
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getPlacePage());
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.restaurant,
                        color: active,
                      ),
                      title: SmallText(
                        text: "restaurant".tr,
                        size: Dimensions.font16,
                        color: deactive,
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getRestaurantPage());
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.archive_rounded,
                        color: active,
                      ),
                      title: SmallText(
                        text: "booking_history".tr,
                        size: Dimensions.font16,
                        color: deactive,
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getHistoryBook());
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.language,
                        color: active,
                      ),
                      title: SmallText(
                        text: "languages".tr,
                        size: Dimensions.font16,
                        color: deactive,
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getLanguageRoute(true));
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: active,
                      ),
                      title: SmallText(
                        text: "about_us".tr,
                        size: Dimensions.font16,
                        color: deactive,
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getAboutUsPage());
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.contact_support,
                        color: active,
                      ),
                      title: SmallText(
                        text: "contact".tr,
                        size: Dimensions.font16,
                        color: deactive,
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getContactPage());
                      },
                    ),
                    //logout
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: active,
                      ),
                      title: SmallText(
                        text: "logout".tr,
                        size: Dimensions.font16,
                        color: deactive,
                      ),
                      onTap: () {
                        Get.find<AuthController>().clearShareData();
                        Navigator.pop(context);
                        CustomSnackBar("logout".tr,
                            isError: false, title: "logout_successfully".tr);
                      },
                    ),
                  ],
                )
              : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logobabe.png",
                        height: Dimensions.height20 * 5,
                        width: Dimensions.width20 * 5,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      BigText(text: "please_login".tr),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            RouteHelper.getSignInPage(),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          width: double.maxFinite,
                          height: Dimensions.screenHeight / 15,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                          ),
                          child: Center(
                            child: BigText(
                              text: "login".tr,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
          : Container(
              height: Dimensions.screenHeight,
              width: Dimensions.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off,
                    color: Theme.of(context).disabledColor,
                    size: Dimensions.iconSize26 * 1.5,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  BigText(text: "no_internet".tr),
                ],
              ),
            ),
    );
  }
}
