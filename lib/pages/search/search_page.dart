import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/search_controller.dart';
import 'package:flutter_babe/models/places_model.dart';
import 'package:flutter_babe/models/post_model.dart';
import 'package:flutter_babe/models/tour_modal.dart';
import 'package:flutter_babe/pages/home/widgets/banner_widget.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/app_text_filed.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';

enum RadioOptions { tours, news, places }

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var textController = TextEditingController();
  final SearchResultController searchResultController =
      Get.find<SearchResultController>();
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  RadioOptions _selectedOption = RadioOptions.tours;
  int page = 1;
  bool isConnectedToInternet = true;
  late StreamSubscription subscription;

  @override
  void initState() {
    scrollController.addListener(() {
      double showoffset = 10.0;
      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {});
      } else {
        showbtn = false;
        setState(() {});
      }
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMoreResults();
      }
    });
    super.initState();
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
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return Scaffold(
        appBar: AppBar(
          title: Text("search".tr),
          centerTitle: true,
          backgroundColor: AppColors.colorAppBar,
        ),
        floatingActionButton: AnimatedOpacity(
          duration: const Duration(milliseconds: 1000),
          opacity: showbtn ? 1.0 : 0.0,
          child: FloatingActionButton(
            heroTag: 'search_page', // Add a unique heroTag
            onPressed: () {
              scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn);
            },
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.arrow_upward,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: isConnectedToInternet
            ? SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BannerWidget(),
                    Container(
                      //height: Dimensions.screenHeight,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20),
                            topRight: Radius.circular(Dimensions.radius20),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppTextField(
                            textController: textController,
                            labelText: "search".tr,
                            icon: Icons.search,
                            onChanged: (value) async {
                              //print();
                              print(value);
                              String selectedOptionValue =
                                  _selectedOption.toString().split('.')[1];

                              if (!value.isEmpty) {
                                await searchResultController.getResultSearch(
                                    selectedOptionValue.toString(),
                                    value.trim(),
                                    8,
                                    1);
                              }
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin:
                                      EdgeInsets.only(left: Dimensions.width20),
                                  child: BigText(text: "search_results_by".tr)),
                              Container(
                                //color: Colors.amber,
                                margin: EdgeInsets.only(
                                    left: Dimensions.width20,
                                    right: Dimensions.width20),
                                width: Dimensions.screenWidth,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<RadioOptions>(
                                        title: Text('tour'.tr),
                                        value: RadioOptions.tours,
                                        groupValue: _selectedOption,
                                        onChanged: (RadioOptions? value) {
                                          setState(() {
                                            _selectedOption = value!;
                                            page = 1;
                                          });
                                          String selectedOptionValue =
                                              _selectedOption
                                                  .toString()
                                                  .split('.')[1];

                                          if (!textController.text.isEmpty) {
                                            searchResultController
                                                .getResultSearch(
                                                    selectedOptionValue
                                                        .toString(),
                                                    textController.text.trim(),
                                                    8,
                                                    page);
                                          }
                                          setState(() {});
                                        },
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<RadioOptions>(
                                        title: Text('news'.tr),
                                        value: RadioOptions.news,
                                        groupValue: _selectedOption,
                                        onChanged: (RadioOptions? value) {
                                          setState(() {
                                            _selectedOption = value!;
                                            page = 1;
                                          });
                                          String selectedOptionValue =
                                              _selectedOption
                                                  .toString()
                                                  .split('.')[1];

                                          if (!textController.text.isEmpty) {
                                            searchResultController
                                                .getResultSearch(
                                                    selectedOptionValue
                                                        .toString(),
                                                    textController.text.trim(),
                                                    8,
                                                    page);
                                          }
                                          setState(() {});
                                        },
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<RadioOptions>(
                                        title:
                                            Text('accommodation_facility'.tr),
                                        value: RadioOptions.places,
                                        groupValue: _selectedOption,
                                        onChanged: (RadioOptions? value) {
                                          setState(() {
                                            _selectedOption = value!;
                                            page = 1;
                                          });
                                          String selectedOptionValue =
                                              _selectedOption
                                                  .toString()
                                                  .split('.')[1];

                                          if (!textController.text.isEmpty) {
                                            searchResultController
                                                .getResultSearch(
                                                    selectedOptionValue
                                                        .toString(),
                                                    textController.text.trim(),
                                                    8,
                                                    page);
                                          }
                                          setState(() {});
                                        },
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: GetBuilder<SearchResultController>(
                        builder: (controller) {
                          if (!controller.isLoaded) {
                            return Container(
                                margin:
                                    EdgeInsets.only(top: Dimensions.height20),
                                child: Center(
                                  child: SmallText(
                                    text: "there_is_no_result".tr,
                                    size: Dimensions.font16,
                                  ),
                                ));
                          }
                          if (_selectedOption == RadioOptions.tours) {
                            return showResults(controller.tours);
                          } else if (_selectedOption == RadioOptions.news) {
                            return showResults(controller.posts);
                          } else {
                            return showResults(controller.places);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    )
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
    });
  }

  void _loadMoreResults() {
    String selectedOptionValue = _selectedOption.toString().split('.')[1];
    page++;
    searchResultController.getResultSearch(
        selectedOptionValue.toString(), textController.text.trim(), 8, page);
    //setState(() {});
  }
}

Widget showResults(List<dynamic> results) {
  bool loading = Get.find<SearchResultController>().isLoading;
  return SingleChildScrollView(
    child: Container(
      child: Column(
        children: [
          ListView.builder(
            itemCount: results.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildItem(results[index]);
            },
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          if (loading)
            Center(child: CircularProgressIndicator())
          else
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: Dimensions.height10),
              child: BigText(
                text: "all_of_list".tr,
                size: Dimensions.font16,
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildItem(dynamic item) {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);

  String title = "";
  String description = "";
  String image = "";

  if (item is Tour) {
    title = item.title!;
    description = item.metaDescription ?? "";
    image = item.image!;
  } else if (item is Post) {
    title = item.title!;
    description = item.metaDescription ?? "";
    image = item.image!;
  } else if (item is Places) {
    title = item.title!;
    description = item.metaDescription ?? "";
    image = item.image!;
  }

  return GestureDetector(
    onTap: () {
      if (item is Tour) {
        Get.toNamed(RouteHelper.getTourDetailPage(item.id!, "searchPage"));
      } else if (item is Post) {
        Get.toNamed(RouteHelper.getNewsDetailPage(item.id!, "searchPage"));
      } else if (item is Places) {
        Get.toNamed(RouteHelper.getPlaceDetail(item.id!, "searchPage"));
      }
    },
    child: Container(
      height: Dimensions.height10 * 12,
      width: Dimensions.screenWidth,
      margin: EdgeInsets.only(
          left: Dimensions.width20,
          right: Dimensions.width20,
          bottom: Dimensions.height10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: Dimensions.height10 * 12,
            width: Dimensions.screenWidth * 0.3,
            child: CachedNetworkImage(
              imageUrl: AppConstants.BASE_URL + "storage/" + image!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radius10,
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (context, url) => Center(
                child: Container(
                    width: 30,
                    height: 30,
                    child: Center(child: CircularProgressIndicator())),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Container(
            width: Dimensions.screenWidth * 0.55,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius10),
                    bottomRight: Radius.circular(Dimensions.radius10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: Dimensions.width10 * 23,
                  margin: EdgeInsets.only(top: Dimensions.height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amber[600],
                        ),
                        child: Center(
                          child: BigText(
                            text: "New",
                            color: Colors.white,
                            size: Dimensions.font16,
                          ),
                        ),
                      ),
                      SmallText(
                        text: formattedDate,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Dimensions.width10 * 23,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: title,
                        size: Dimensions.font16,
                        color: Colors.blue[600],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SmallText(
                        text: description,
                        maxLines: 2,
                        size: Dimensions.font16,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
