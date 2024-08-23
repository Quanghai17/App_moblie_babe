import 'package:flutter/material.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:get/get.dart';

void CustomSnackBar(String message,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(
    title,
    message,
    titleText: BigText(
      text: title,
      color: Colors.white,
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: isError ? Colors.redAccent : Colors.black26,
  );
}
