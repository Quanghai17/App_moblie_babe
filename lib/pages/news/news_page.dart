import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/post_controller.dart';
import 'package:flutter_babe/models/post_model.dart';
import 'package:flutter_babe/pages/news/newspage_tabbar.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> with SingleTickerProviderStateMixin {
  PageController pageController = PageController(viewportFraction: 0.95);
  final PostController postController = Get.find<PostController>();
  var _currentPageValue = 0.0;
  //double _scaleFactor = 0.8;
  //double _height = Dimensions.pageViewContainer;
  int page = 1;

  late TabController _tabController;
  bool _isLoading = true;

  ScrollController scrollController = ScrollController();
  bool showbtn = false;

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
        _loadMoreNews(_tabController.index);
      }
    });
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });

    _tabController = TabController(length: 4, initialIndex: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    // Load initial data
    _loadDataForTab(_tabController.index);
  }

  @override
  void dispose() {
    pageController.dispose();
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging) {
      _loadDataForTab(_tabController.index);
    }
  }

  String _getFilterByIndex(int index) {
    switch (index) {
      case 0:
        return "day";
      case 1:
        return "week";
      case 2:
        return "month";
      case 3:
        return "all";
      default:
        return "all";
    }
  }

  void _loadDataForTab(int index) async {
    setState(() {
      _isLoading = true;
    });
    String filter = _getFilterByIndex(index);
    Get.find<PostController>().clearFutureList();
    await Get.find<PostController>().getPostListByFilter(filter, null, 1);
    setState(() {
      _isLoading = false;
    });
  }

  void _loadMoreNews(int index) {
    String filter = _getFilterByIndex(index);
    page++;
    postController.getPostListByFilter(filter, 8, page);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: Text("news".tr),
            centerTitle: true,
            backgroundColor: AppColors.colorAppBar,
          ),
          backgroundColor: Colors.grey[200],
          floatingActionButton: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: showbtn ? 1.0 : 0.0,
            child: FloatingActionButton(
              heroTag: "news_page",
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
          body: Container(
            //height: Dimensions.screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.height10,
                ),
                Container(
                  width: Dimensions.screenWidth,
                  margin: EdgeInsets.only(left: Dimensions.width15),
                  child: PictureWidget(pageController, _currentPageValue,
                      controller.featurePostList),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),

                TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.0,
                      color: _tabController.indexIsChanging
                          ? Colors.black
                          : Colors.blue,
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  tabs: [
                    Tab(text: '_day'.tr),
                    Tab(text: '_week'.tr),
                    Tab(text: '_month'.tr),
                    Tab(text: '_all'.tr),
                  ],
                  controller: _tabController,
                ),

                SizedBox(height: Dimensions.height20),
                Expanded(
                  child: _isLoading
                      ? Center(child: CustomLoader())
                      : TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            _buildNewsList(postController.postListFilter),
                            _buildNewsList(postController.postListFilter),
                            _buildNewsList(postController.postListFilter),
                            _buildNewsList(postController.postListFilter),
                          ],
                        ),
                ),

                // Container(
                //   height: Dimensions.screenHeight,
                //   margin: EdgeInsets.only(
                //       top: Dimensions.height15,
                //       left: Dimensions.width15,
                //       right: Dimensions.width15),
                //   child: NewsContentTabBar(),
                // ),
              ],
            ),
          ));
    });
  }

  Widget _buildNewsList(List<Post> posts) {
    return SingleChildScrollView(
      controller: scrollController,
      child: posts.length > 0
          ? Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width15, right: Dimensions.width15),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: posts.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _buildItemNews(posts[index]);
                    },
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  if (postController.isLoading)
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
            )
          : Center(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: Dimensions.height10),
                child: BigText(
                  text: "there_is_no_news".tr,
                  size: Dimensions.font16,
                ),
              ),
            ),
    );
  }

  Widget _buildItemNews(Post post) {
    int language_index = Get.find<LocalizationController>().selectedIndex;
    DateTime createdPost = DateTime.parse(post.createdAt!);
    String formattedDateVi = DateFormat('dd-MM-yyyy').format(createdPost);
    String formattedDateUs = DateFormat('yyyy-MM-dd').format(createdPost);
    return GestureDetector(
      onTap: () {
        print("id post:" + post.id!.toString());
        Get.toNamed(RouteHelper.getNewsDetailPage(post.id!, "newPage"));
      },
      child: Container(
        height: Dimensions.height10 * 13,
        width: Dimensions.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius10),
          color: Colors.white,
        ),
        margin: EdgeInsets.only(bottom: Dimensions.height10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: Dimensions.height10 * 13,
              width: Dimensions.screenWidth * 0.3,
              child: CachedNetworkImage(
                imageUrl: AppConstants.BASE_URL + "storage/" + post.image!,
                imageBuilder: (context, imageProvider) => Container(
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
                      child: Center(child: CircularProgressIndicator())),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Container(
              width: Dimensions.screenWidth * 0.57,
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: Dimensions.screenWidth * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, top: 2, right: 10, bottom: 2),
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
                          text: language_index == 1
                              ? formattedDateVi
                              : formattedDateUs,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Container(
                    width: Dimensions.width10 * 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: post.title!,
                          size: Dimensions.font16,
                          color: Colors.blue[600],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SmallText(
                          text: post.metaDescription!,
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
}

Widget PictureWidget(PageController pageController, var _currentPageValue,
    List<Post> postFeatureList) {
  return postFeatureList.length > 0
      ? Stack(
          children: [
            Container(
              height: Dimensions.height200,
              width: Dimensions.screenWidth,
              child: PageView.builder(
                itemCount: postFeatureList.length,
                controller: pageController,
                scrollDirection: Axis.horizontal,
                padEnds: false,
                itemBuilder: (context, index) {
                  return _buildPageItem(postFeatureList[index]);
                },
              ),
            ),
            Positioned(
              bottom: Dimensions.height10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DotsIndicator(
                    dotsCount: postFeatureList.length,
                    position: _currentPageValue,
                    decorator: const DotsDecorator(
                      color: Colors.white, // Inactive color
                      activeColor: Colors.amber,
                      size: Size.square(6.0),
                      activeSize: Size(15.0, 6.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      : SizedBox();
}

Widget _buildPageItem(Post post) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(RouteHelper.getNewsDetailPage(post.id!, "NewsPage"));
    },
    child: Container(
      margin: EdgeInsets.only(right: Dimensions.width10),
      height: Dimensions.height200,
      width: Dimensions.screenWidth,

      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(Dimensions.radius10),
      //   image: DecorationImage(
      //     image: NetworkImage(AppConstants.BASE_URL + "storage/" + post.image!),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: AppConstants.BASE_URL + "storage/" + post.image!,
            imageBuilder: (context, imageProvider) => Container(
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
                  child: Center(child: CircularProgressIndicator())),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Positioned(
            bottom: Dimensions.height30,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(5),
              width: Dimensions.screenWidth * 0.8,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Dimensions.width10 * 10,
                    padding:
                        EdgeInsets.only(left: 20, top: 2, right: 20, bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber[600],
                    ),
                    child: Center(
                        child: BigText(
                      text: "New",
                      color: Colors.white,
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BigText(
                    text: post.title!,
                    color: Colors.white,
                    size: Dimensions.font20,
                    maxLines: 1,
                  ),
                  SmallText(
                    text: post.metaKeywords!,
                    size: Dimensions.font16,
                    color: Colors.white,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 10,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    print("You clicked on icon message");
                  },
                  child: Icon(
                    Icons.message_outlined,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width10,
                ),
                InkWell(
                    onTap: () {
                      print("you clicked on icon share");
                    },
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
