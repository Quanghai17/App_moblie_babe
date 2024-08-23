import 'package:flutter/material.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/widgets/big_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButtonExist;
  final Function? onBackPressed;
  final List<Widget>? actions;
  final TextStyle? titleTextStyle;
  final Widget? leading;
  final Color? backgroundColor;
  final double? elevation;

  CustomAppBar({
    Key? key,
    required this.title,
    this.backButtonExist = true,
    this.onBackPressed,
    this.actions,
    this.titleTextStyle,
    this.leading,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BigText(
        text: title,
        color: Colors.white,
      ),
      backgroundColor: backgroundColor ?? AppColors.mainColor,
      centerTitle: true,
      elevation: elevation ?? 0,
      leading: leading ??
          (backButtonExist
              ? IconButton(
                  onPressed: () => onBackPressed != null
                      ? onBackPressed!()
                      : Navigator.pushReplacementNamed(context, "/menu-page"),
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                )
              : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(500, 50);
}
