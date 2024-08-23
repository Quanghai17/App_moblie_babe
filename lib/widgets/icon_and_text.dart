import 'package:flutter/material.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? textColor;
  final double? iconSize;
  final double? textSize;

  final Color iconColor;
  const IconAndTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
    this.textColor,
    this.iconSize,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize ?? Dimensions.iconSize24,
        ),
        SizedBox(
          width: Dimensions.height10 / 2,
        ),
        Container(
          child: SmallText(
            text: text,
            color: textColor ?? Colors.black87,
            size: textSize ?? Dimensions.font16,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
