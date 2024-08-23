// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final bool showSeeLessOrMore;

  ExpandableTextWidget({
    Key? key,
    required this.text,
    required this.showSeeLessOrMore,
  }) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 2.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              text: firstHalf,
              size: Dimensions.font16,
            )
          : Column(
              children: [
                SmallText(
                    color: AppColors.textColor,
                    height: 1.5,
                    size: Dimensions.font16,
                    text: hiddenText
                        ? (firstHalf + "...")
                        : (firstHalf + secondHalf)),
                if (widget
                    .showSeeLessOrMore) // Only show if showSeeLessOrMore is true
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        SmallText(
                          text: hiddenText ? "Show more" : "See less",
                          color: AppColors.mainColor,
                        ),
                        Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}
