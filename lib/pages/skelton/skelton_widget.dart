import 'package:flutter/material.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:shimmer/shimmer.dart';

class SkeltonWidget extends StatelessWidget {
  final double? height, width;
  SkeltonWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
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
      ),
    );
  }
}
