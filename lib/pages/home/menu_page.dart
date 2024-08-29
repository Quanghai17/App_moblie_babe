import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/pages/home/home_page.dart';
import 'package:flutter_babe/pages/search/search_page.dart';
import 'package:flutter_babe/pages/tour/tour_page.dart';
import 'package:flutter_babe/pages/tourist_attraction/tourist_attraction_page.dart';
import 'package:flutter_babe/pages/vr360/VR360_webview.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _controller = PersistentTabController(initialIndex: 0);
  bool _isTabSelected = false;

  void _handleTabChange(int index) {
    setState(() {
      _isTabSelected = index == 4;
      print(_isTabSelected); // Check if VR360WebView tab is selected
    });
  }

  List<Widget> pages() {
    return [
      HomePage(),
      //SignUpPage(),
      // TourPage(),
      TouristAttractionPage(),
      SearchPage(),
      VR360WebView(
        isTabSelected: _isTabSelected,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems(
      BuildContext context, LocalizationController controller) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "home".tr,
        activeColorPrimary: AppColors.colorAppBar!,
        inactiveIcon: Icon(Icons.home, color: Theme.of(context).disabledColor),
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.tour),
      //   title: "tour".tr,
      //   activeColorPrimary: AppColors.colorAppBar!,
      //   inactiveIcon: Icon(Icons.tour, color: Theme.of(context).disabledColor),
      // ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.location_on),
        title: "tourist_attraction".tr,
        activeColorPrimary: AppColors.colorAppBar!,
        inactiveIcon:
            Icon(Icons.location_on, color: Theme.of(context).disabledColor),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: "search".tr,
        activeColorPrimary: AppColors.colorAppBar!,
        inactiveIcon:
            Icon(Icons.search, color: Theme.of(context).disabledColor),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.image_rounded),
        title: "VR360",
        activeColorPrimary: AppColors.colorAppBar!,
        inactiveIcon:
            Icon(Icons.image_rounded, color: Theme.of(context).disabledColor),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        GetBuilder<LocalizationController>(builder: (controllerLocalization) {
      return PersistentTabView(
        context,
        controller: _controller,
        screens: pages(),
        items: _navBarItems(context, controllerLocalization),
        resizeToAvoidBottomInset: true,
        navBarStyle: NavBarStyle.style3,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
        onItemSelected: _handleTabChange,
      );
    }));
  }
}
