import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double iconSize;

  AppIcon({
    super.key,
    required this.icon,
    this.backgroundColor = const Color.fromARGB(255, 255, 255, 255),
    this.iconColor = Colors.deepOrange,
    this.size = 40,
    this.iconSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor,
          border: Border.all(color: Theme.of(context).disabledColor)),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
