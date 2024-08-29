import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/controller/notification_controller.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:flutter_babe/utils/app_constants.dart';

import '../../widgets/small_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationController notificationController =
      Get.find<NotificationController>();
  int page = 1;
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
    notificationController.getAllNotifications(null, page);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizationController) {
        return Scaffold(
          appBar: AppBar(
            title: Text("notification".tr),
            centerTitle: true,
            backgroundColor: AppColors.colorAppBar,
          ),
          body: GetBuilder<NotificationController>(
            builder: (controller) {
              // Nếu đang tải dữ liệu
              if (!controller.isLoaded) {
                return Center(child: CircularProgressIndicator());
              }

              // Nếu danh sách thông báo trống
              if (controller.notificationList.isEmpty) {
                return Center(child: Text("No notifications available"));
              }

              // Sử dụng ListView.builder để hiển thị danh sách thông báo
              return ListView.builder(
                controller: scrollController,
                itemCount: controller.notificationList.length,
                itemBuilder: (BuildContext context, int index) {
                  final notification = controller.notificationList[index];
                  return _notificationItem(
                    notification.image ??
                        '', // Sử dụng link ảnh từ dữ liệu thông báo
                    notification.title ?? 'New notification',
                    notification.body ?? 'Welcome to my app',
                    index,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

Widget _notificationItem(
    String imageLink, String title, String description, int index) {
  String fullImageUrl = AppConstants.BASE_URL + "storage/" + imageLink;
  return InkWell(
    onTap: () {
      print("You just clicked on notification: $index");
    },
    child: Container(
      height: Dimensions.height150,
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: Dimensions.height10 * 10,
            width: Dimensions.width10 * 5,
            child: CircleAvatar(
              backgroundImage: NetworkImage(fullImageUrl),
            ),
          ),
          SizedBox(
            width: Dimensions.width15,
          ),
          // Sử dụng Flexible để cho phép văn bản tự động xuống dòng
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // Cắt văn bản nếu quá dài
                  maxLines:
                      2, // Hiển thị tối đa 1 dòng, bạn có thể tăng số lượng dòng nếu cần
                ),
                SizedBox(height: Dimensions.height10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: Dimensions.font16,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines:
                      2, // Hiển thị tối đa 2 dòng, có thể thay đổi theo nhu cầu
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
