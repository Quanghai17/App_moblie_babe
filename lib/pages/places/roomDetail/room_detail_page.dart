import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/room_controller.dart';
import 'package:flutter_babe/models/room_model.dart';
import 'package:flutter_babe/pages/places/roomDetail/gallery_room.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RoomDetailPage extends StatefulWidget {
  int roomID;
  String pageID;

  RoomDetailPage({super.key, required this.roomID, required this.pageID});

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  final RoomsController roomsController = Get.find<RoomsController>();
  Room? room;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    roomsController.getRoomDetail(widget.roomID).then((value) {
      setState(() {
        room = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("room_detail".tr),
        centerTitle: true,
        backgroundColor: AppColors.colorAppBar,
      ),
      body: room != null
          ? SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: room!.title!,
                        color: Colors.lightBlue,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      BigText(
                        text: _formatCurrency(room!.price!),
                        color: Colors.lightBlue,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      GalleryRoomImage(
                          roomID: room!.id!, pageID: " Room Detail"),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      HtmlWidget(room!.content!),
                    ],
                  )),
            )
          : CustomLoader(),
    );
  }

  String _formatCurrency(num price) {
    final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatCurrency.format(price);
  }
}
