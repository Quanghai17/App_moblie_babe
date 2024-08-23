import 'package:flutter/material.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:shimmer/shimmer.dart';

class CustomSkelton extends StatelessWidget {
  final double? height, width;
  CustomSkelton({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: width,
            height: height,
            child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.width10),
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    color: Colors.grey,
                  ),
                )),
          );
        },
      ),
    );
  }
}
