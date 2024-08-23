import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/banner_controller.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:get/get.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final BannerController bannerController = Get.find<BannerController>();
  late PageController _pageController;
  double _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    bannerController.getBannerList();
    _startAutoPlay();
    _pageController.addListener(_pageListener);
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        final currentPage = _pageController.page ?? 0;
        final nextPage = (currentPage + 1) % bannerController.bannerList.length;
        _pageController.animateToPage(
          nextPage.toInt(),
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  void _pageListener() {
    setState(() {
      _currentPage = _pageController.page ?? 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(builder: (controller) {
      return !controller.isLoading
          ? Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: Dimensions.screenHeight / 5,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: controller.bannerList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: Dimensions.screenHeight / 5,
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //       image: NetworkImage(
                        //         AppConstants.BASE_URL +
                        //             "storage/" +
                        //             controller.bannerList[index].image!,
                        //       ),
                        //       fit: BoxFit.fill),
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: AppConstants.BASE_URL +
                              "storage/" +
                              controller.bannerList[index].image!,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          // placeholder: (context, url) => Center(
                          //   child: Container(
                          //     width: 30,
                          //     height: 30,
                          //     child: Center(child: CircularProgressIndicator()),
                          //   ),
                          // ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: DotsIndicator(
                    dotsCount: controller.bannerList.length,
                    position: _currentPage,
                    decorator: DotsDecorator(
                      color: Colors.grey, // Inactive dot color
                      activeColor: Colors.blue, // Active dot color
                    ),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator());
    });
  }
}
