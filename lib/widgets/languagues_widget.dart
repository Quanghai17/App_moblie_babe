import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/models/languages.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/small_text.dart';

import '../utils/app_constants.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  LanguageWidget(
      {required this.languageModel,
      required this.localizationController,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        localizationController.setLanguage(Locale(
          AppConstants.languages[index].languageCode,
          AppConstants.languages[index].countryCode,
        ));
        localizationController.setSelectIndex(index);
      },
      child: Container(
        //padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey[200]!, blurRadius: 10, spreadRadius: 2)
          ],
        ),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            languageModel.languageName.contains("Việt Nam")
                ? Image.asset("assets/images/vi.png",
                    width: 100, height: 70, fit: BoxFit.cover)
                : Image.asset(
                    "assets/images/en.png",
                    width: 100,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
            SizedBox(height: Dimensions.height10),
            SmallText(
              text: languageModel.languageName,
              size: Dimensions.font16,
              color: localizationController.selectedIndex == index
                  ? AppColors.textColorLightBlue
                  : Theme.of(context).disabledColor,
            ),
            SizedBox(height: Dimensions.height10),
            localizationController.selectedIndex == index
                ? Icon(Icons.check_circle,
                    color: AppColors.textColorLightBlue, size: 25)
                : Icon(Icons.check_circle,
                    color: Theme.of(context).disabledColor, size: 25),
          ]),
        ),
      ),
    );
  }
}
