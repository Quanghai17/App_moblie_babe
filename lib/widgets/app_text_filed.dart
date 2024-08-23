import 'package:flutter/material.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController textController;
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    required this.textController,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.screenHeight / 14,
      margin: EdgeInsets.only(
        left: Dimensions.width20,
        right: Dimensions.width20,
        top: Dimensions.height20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        obscureText: _obscureText,
        controller: widget.textController,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.colorAppBar,
            size: Dimensions.iconSize16,
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: _obscureText
                          ? Theme.of(context).disabledColor
                          : AppColors.colorAppBar),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColors.colorAppBar!,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius10),
          ),
        ),
      ),
    );
  }
}
