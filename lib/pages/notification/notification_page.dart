import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../widgets/small_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return Scaffold(
        appBar: AppBar(
          title: Text("notification".tr),
          centerTitle: true,
          backgroundColor: AppColors.colorAppBar,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios),
          //   onPressed: () => Get.back(),
          // ),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              return _notificationItem(
                  "https://vrbabe.kennatech.vn//storage/locations/March2024/nS9EWEugJ7for6KNftqz.jpg",
                  "New notification",
                  "Welcome to my app",
                  index);
            },
          ),
        ),
      );
    });
  }

  Widget _notificationItem(
      String imageLink, String title, String decription, int index) {
    return InkWell(
      onTap: () {
        print("you just click on notification: " + index.toString());
      },
      child: Container(
        height: Dimensions.height70,
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        //margin: EdgeInsets.all(Dimensions.height10),
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Colors.grey.shade300)), // Add bottom border
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: Dimensions.height10 * 5,
              width: Dimensions.width10 * 5,
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageLink),
                //radius: 50,
              ),
            ),
            SizedBox(
              width: Dimensions.width15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: title),
                SmallText(text: decription),
              ],
            )
          ],
        ),
      ),
    );
  }
}
