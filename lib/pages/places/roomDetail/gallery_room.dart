import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/room_controller.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:flutter_babe/utils/dimension.dart';

class GalleryRoomImage extends StatefulWidget {
  int roomID;
  String pageID;
  GalleryRoomImage({
    Key? key,
    required this.roomID,
    required this.pageID,
  }) : super(key: key);

  @override
  State<GalleryRoomImage> createState() => _GalleryRoomImageState();
}

int selectedImageIndex = 0;

class _GalleryRoomImageState extends State<GalleryRoomImage> {
  late Future<List<String>> _imageListFuture;

  @override
  void initState() {
    super.initState();
    _imageListFuture = Get.find<RoomsController>().getImageList(widget.roomID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _imageListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error at gallery room: ${snapshot.error}');
        } else {
          List<String> images = snapshot.data ?? [];

          return Container(
            width: Dimensions.screenWidth,
            margin: EdgeInsets.all(Dimensions.height20),
            child: Container(
              width: Dimensions.screenWidth,
              child: Column(
                children: [
                  Container(
                    height: Dimensions.height100 * 2,
                    width: Dimensions.screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      image: selectedImageIndex < images.length
                          ? DecorationImage(
                              image: NetworkImage(AppConstants.BASE_URL +
                                  "storage/" +
                                  images[selectedImageIndex]),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    // Adjust the height of the large image container
                  ),
                  SizedBox(
                    height: Dimensions.height10 / 3,
                  ),
                  Container(
                    height: Dimensions.height10 *
                        6, // Adjust the height of the thumbnail images container
                    child: ListView.builder(
                      itemCount: images.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageIndex = index;
                            });
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Image.network(
                                AppConstants.BASE_URL +
                                    "storage/" +
                                    images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
