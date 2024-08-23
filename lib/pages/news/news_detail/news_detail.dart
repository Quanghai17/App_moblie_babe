// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/post_controller.dart';
import 'package:flutter_babe/models/post_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/pages/news/widgets/showNews_widget.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';

class NewsDetail extends StatefulWidget {
  int postID;
  String pageID;
  NewsDetail({
    Key? key,
    required this.postID,
    required this.pageID,
  }) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  bool isFavorite = false;
  late DateTime createdPost;
  late String formattedDateVi;
  late String formattedDateUs;

  final PostController postController = Get.find<PostController>();
  Post? post;

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

    postController.getPostDetail(widget.postID).then((value) {
      setState(() {
        post = value;
        createdPost = DateTime.parse(post!.createdAt!);
        formattedDateVi = DateFormat('dd-MM-yyyy').format(createdPost);
        formattedDateUs = DateFormat('yyyy-MM-dd').format(createdPost);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int language_index = Get.find<LocalizationController>().selectedIndex;

    return GetBuilder<LocalizationController>(
      builder: (localizationController) {
        return Scaffold(
          appBar: AppBar(
            title: Text("news_detail".tr),
            centerTitle: true,
            backgroundColor: AppColors.colorAppBar,
          ),
          floatingActionButton: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: showbtn ? 1.0 : 0.0,
            child: FloatingActionButton(
              heroTag: 'news_detail${widget.postID}', // Add a unique heroTag
              onPressed: () {
                scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              },
              backgroundColor: AppColors.colorAppBar,
              child: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: post != null
              ? SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: Dimensions.height200,
                            width: Dimensions.screenWidth,
                            child: CachedNetworkImage(
                              imageUrl: AppConstants.BASE_URL +
                                  "storage/" +
                                  post!.image!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft:
                                        Radius.circular(Dimensions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius20),
                                  ),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                            bottom: Dimensions.height20,
                            right: Dimensions.width20,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print("you clicked on icon share");
                                    },
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      print("you clicked on icon favorite");
                                      setState(() {
                                        isFavorite = !isFavorite;
                                      });
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: isFavorite
                                          ? AppColors.textColorBlue800
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: Dimensions.screenWidth,
                        margin: EdgeInsets.all(Dimensions.height20),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Dimensions.width20 * 6,
                              padding: EdgeInsets.only(
                                left: Dimensions.width20,
                                top: Dimensions.height10 / 2,
                                right: Dimensions.width20,
                                bottom: Dimensions.height10 / 2,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.colorButton,
                              ),
                              child: Center(
                                child: BigText(
                                  text: "news".tr,
                                  color: Colors.white,
                                  size: Dimensions.font16,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            BigText(
                              text: post!.title!,
                              color: AppColors.textColorBlue800,
                              size: Dimensions.font20,
                              maxLines: 4,
                            ),
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                            Container(
                              width: Dimensions.screenWidth * 0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.timer_outlined,
                                          color: Colors.grey,
                                        ),
                                        SmallText(
                                          text: language_index == 1
                                              ? formattedDateVi
                                              : formattedDateUs,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Dimensions.screenWidth,
                        margin: EdgeInsets.only(
                          left: Dimensions.height20,
                          right: Dimensions.height20,
                        ),
                        alignment: Alignment.center,
                        child: HtmlWidget(
                          '<div style="text-align: justify;">${post!.body!}</div>',
                          //textStyle: TextStyle(textAlign: TextAlign.justify),
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(Dimensions.height20),
                              child: BigText(
                                text: "highlight_tour".tr,
                                color: AppColors.textColorBlue800,
                                size: Dimensions.font20,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20,
                              ),
                              child: ShowNews(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CustomLoader(),
                ),
        );
      },
    );
  }
}
