import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/languagues_widget.dart';
import 'package:get/get.dart';

class LanguagePage extends StatelessWidget {
  final bool fromMenu;
  bool appBarDisplay;
  LanguagePage({this.fromMenu = false, required this.appBarDisplay});

  @override
  Widget build(BuildContext context) {
    double? width = 375;
    return Scaffold(
      appBar: appBarDisplay
          ? AppBar(
              title: Text("languages".tr),
              centerTitle: true,
              backgroundColor: AppColors.colorAppBar,
            )
          : null,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<LocalizationController>(
            builder: (localizationController) {
          return Column(children: [
            Expanded(
                child: Center(
              child: Scrollbar(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(5),
                  child: Center(
                      child: SizedBox(
                    width: width,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Center(
                          //   child: localizationController.selectedIndex == 1
                          //       ? Image.asset(
                          //           "assets/images/vi.png",
                          //           width: 120,
                          //           height: 80,
                          //           fit: BoxFit.cover,
                          //         )
                          //       : Image.asset(
                          //           "assets/images/en.png",
                          //           width: 120,
                          //           height: 80,
                          //           fit: BoxFit.cover,
                          //         ),
                          // ),
                          SizedBox(height: Dimensions.height10),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: BigText(
                              text: 'select_a_language'.tr,
                            ),
                          ),
                          SizedBox(height: 10),

                          GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                            ),
                            itemCount:
                                2, //localizationController.languages.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => LanguageWidget(
                              languageModel:
                                  localizationController.languages[index],
                              localizationController: localizationController,
                              index: index,
                            ),
                          ),

                          SizedBox(height: 10),

                          //Text('you_can_change_language'.tr, ),
                        ]),
                  )),
                ),
              ),
            )),
            Container(
              margin: EdgeInsets.only(bottom: Dimensions.height16),
              child: ElevatedButton(
                child: Text('save'.tr),
                onPressed: () {
                  if (localizationController.languages.length > 0 &&
                      localizationController.selectedIndex != -1) {
                    localizationController.setLanguage(Locale(
                      AppConstants
                          .languages[localizationController.selectedIndex]
                          .languageCode,
                      AppConstants
                          .languages[localizationController.selectedIndex]
                          .countryCode,
                    ));
                    localizationController.saveLanguage(Locale(
                      AppConstants
                          .languages[localizationController.selectedIndex]
                          .languageCode,
                      AppConstants
                          .languages[localizationController.selectedIndex]
                          .countryCode,
                    ));
                    if (fromMenu) {
                      Navigator.pop(context);
                    } else {
                      Get.offNamed(RouteHelper.getMenuPage());
                    }
                  } else {
                    Get.snackbar(
                        'select_a_language'.tr, 'select_a_language'.tr);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorButton,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10 * 10,
                      vertical: Dimensions.height10 * 1.5),
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}
