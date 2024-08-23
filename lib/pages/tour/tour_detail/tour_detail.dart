import 'package:flutter/material.dart';
import 'package:flutter_babe/models/tour_modal.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_babe/controller/tour_controller.dart';
import 'package:flutter_babe/pages/tour/widgets/gallery_image.dart';
import 'package:flutter_babe/pages/tour/widgets/highlight_tour.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/icon_and_text.dart';
import 'package:flutter_babe/widgets/small_text.dart';

class TourDetail extends StatefulWidget {
  int tourID;
  String pageID;
  TourDetail({
    Key? key,
    required this.tourID,
    required this.pageID,
  }) : super(key: key);

  @override
  State<TourDetail> createState() => _TourDetailState();
}

class _TourDetailState extends State<TourDetail> {
  final TourController tourController = Get.find<TourController>();
  Tour? tour;
  bool isFavorite = false;

  ScrollController scrollController = ScrollController();
  bool showbtn = false;

  @override
  void initState() {
    // TODO: implement initState
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
    tourController.getTourDetail(widget.tourID!).then((value) {
      setState(() {
        tour = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("tour_detail".tr),
          centerTitle: true,
          backgroundColor: AppColors.colorAppBar,
        ),
        floatingActionButton: AnimatedOpacity(
          duration: const Duration(milliseconds: 1000),
          opacity: showbtn ? 1.0 : 0.0,
          child: FloatingActionButton(
            heroTag: 'tour_detail${widget.tourID}', // Add a unique heroTag
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
        body: tour != null
            ? SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Dimensions.screenWidth * 0.65,
                                child: BigText(
                                    text: tour!.title!,
                                    color: Colors.blue[800]),
                              ),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              Container(
                                width: Dimensions.screenWidth * 0.65,
                                child: SmallText(
                                    text: "address".tr + ": " + tour!.address!,
                                    size: Dimensions.font16),
                              ),
                              SizedBox(
                                height: Dimensions.height10 / 2,
                              ),
                              //share social button
                              Container(
                                width: Dimensions.screenWidth * 0.6,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(
                                      text: "share".tr + ": ",
                                      color: Colors.grey,
                                      size: Dimensions.font20,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.facebook,
                                      // size: Dimensions.font16,
                                      color: Colors.blue,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.xTwitter,
                                      // size: Dimensions.font16,
                                      //color: Colors.,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.linkedin,
                                      // size: Dimensions.font16,
                                      color: Colors.red,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.googlePlus,
                                      // size: Dimensions.font16,
                                      color: Color(0xFF4285F4),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              print("you have just clicked on button");
                              Get.toNamed(RouteHelper.getContactPage());
                            },
                            child: Container(
                              width: Dimensions.screenWidth * 0.2,
                              decoration: BoxDecoration(
                                  color: Colors.amber[600],
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius10)),
                              padding: EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
                              child: Center(
                                child: Text(
                                  "contact_for_consultation".tr,
                                  //maxLines: 2,
                                  //textAlign: TextAlign.justify,
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.font16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //gallery
                    GalleryImage(
                      tourID: widget.tourID,
                      pageID: "tourDetail",
                    ),
                    Container(
                      width: Dimensions.screenWidth,
                      height: Dimensions.height10 * 4,
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconAndTextWidget(
                              icon: Icons.timer_outlined,
                              text: tour!.days.toString() + "day".tr,
                              textColor: Colors.blue[800],
                              textSize: 15,
                              iconColor: Color.fromARGB(255, 21, 101, 192)),
                          IconAndTextWidget(
                              icon: Icons.train,
                              text: "coach".tr,
                              textColor: Colors.blue[800],
                              textSize: 15,
                              iconColor: Color.fromARGB(255, 21, 101, 192))
                        ],
                      ),
                    ),

                    Container(
                      width: Dimensions.screenWidth,
                      margin: EdgeInsets.all(Dimensions.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: "tour_detail".tr,
                            color: Colors.blue[800],
                            size: Dimensions.font20,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          HtmlWidget(
                            ''' <div style="text-align: justify;">
                                ${tour!.content!}
                              </div>  
                          ''',
                            //textStyle: TextStyle(fontSize: Dimensions.font16),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          BigText(
                            text: "the_tour".tr,
                            color: Colors.blue[800],
                            size: Dimensions.font20,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          SmallText(
                            text: tour!.desc!,
                            size: Dimensions.font16,
                            color: Colors.black87,
                          ),
                          // ExpandableTextWidget(
                          //     text: tour!.desc!, showSeeLessOrMore: false),
                        ],
                      ),
                    ),
                    //Feed back

                    Container(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(Dimensions.height20),
                            child: BigText(
                              text: "highlight_tour".tr,
                              color: Colors.blue[800],
                              size: Dimensions.font20,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: Dimensions.width10),
                              child: HighLightTour())
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    )
                  ],
                ),
              )
            : CustomLoader());
  }
}
