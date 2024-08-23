import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/contact_controller.dart';
import 'package:flutter_babe/controller/setting_controller.dart';
import 'package:flutter_babe/models/contact_model.dart';
import 'package:flutter_babe/utils/app_constants.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/custom_snackbar.dart';
import 'package:flutter_babe/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:flutter_babe/controller/localization_controller.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/icon_and_text.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final SettingController settingController = Get.find<SettingController>();

  @override
  void initState() {
    super.initState();
    settingController.getSetting();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController fullNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController messageController = TextEditingController();

    void _sendContact() {
      var contactController = Get.find<ContactController>();

      String fullName = fullNameController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();
      String message = messageController.text.trim();

      if (fullName.isEmpty) {
        CustomSnackBar("enter_your_name".tr, isError: true, title: "Ops");
      } else if (!GetUtils.isEmail(email) || email.isEmpty) {
        CustomSnackBar("enter_your_valid_email".tr, title: "Ops");
      } else if (!GetUtils.isPhoneNumber(phone) || phone.isEmpty) {
        CustomSnackBar("enter_your_phone".tr, title: "Ops");
      } else if (message.isEmpty) {
        CustomSnackBar("enter_your_mesage".tr, title: "Ops");
      } else {
        ContactModel contactModel = ContactModel(
            name: fullName, phone: phone, email: email, message: message);
        print(contactModel.toJson());
        contactController.sendContact(contactModel).then((status) {
          if (status.isSuccess) {
            fullNameController.clear();
            emailController.clear();
            phoneController.clear();
            messageController.clear();
            CustomSnackBar("message_was_sent".tr,
                isError: false, title: "success".tr);
          } else {
            CustomSnackBar(status.message!);
          }
        });
      }
    }

    return GetBuilder<SettingController>(builder: (controller) {
      return GetBuilder<LocalizationController>(
          builder: (localizationController) {
        return Scaffold(
          appBar: AppBar(
            title: Text("contact".tr),
            centerTitle: true,
            backgroundColor: AppColors.colorAppBar,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Get.back(),
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: !controller.isLoading
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: Dimensions.screenWidth,
                        height: Dimensions.height200,
                        child: CachedNetworkImage(
                          imageUrl: AppConstants.BASE_URL +
                              "storage/" +
                              controller.settingModel!.siteLogo!,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius10,
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(
                            child: Container(
                                width: 30,
                                height: 30,
                                child:
                                    Center(child: CircularProgressIndicator())),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(
                          children: [
                            BigText(
                              text: "contact_us".tr,
                              color: Colors.blue,
                              size: Dimensions.font20,
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            //form contact
                            Center(
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  //height: 450,
                                  width: Dimensions.screenWidth * 0.85,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 211, 201, 201),
                                        offset: const Offset(
                                          1.5,
                                          1.5,
                                        ),
                                        blurRadius: 2.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                      BoxShadow(
                                        color: Colors.white,
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //name
                                      Text("fullname".tr),
                                      SizedBox(
                                        height: Dimensions.height10 / 2,
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.name,
                                        controller: fullNameController,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              //borderRadius: BorderRadius.circular(5),
                                              ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      //phone
                                      Text("phone".tr),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.phone,
                                        controller: phoneController,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      //email
                                      Text("email".tr),
                                      SizedBox(
                                        height: Dimensions.height10 / 2,
                                      ),
                                      TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      //message
                                      Text("message".tr),
                                      SizedBox(
                                        height: Dimensions.height10 / 2,
                                      ),
                                      TextField(
                                        controller: messageController,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                        ),
                                        minLines: 1,
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      //button
                                      Center(
                                        child: ElevatedButton(
                                          child: Text('send'.tr),
                                          onPressed: () {
                                            _sendContact();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber[700],
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 60, vertical: 10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            //Contact information
                            Container(
                              width: Dimensions.screenWidth * 0.85,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: BigText(
                                      text: "contact_information".tr,
                                      color: Colors.blue,
                                      size: Dimensions.font20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: Dimensions.height10 / 2,
                                      ),
                                      Container(
                                        width: Dimensions.screenWidth * .75,
                                        child: SmallText(
                                          text: "address".tr +
                                              ": " +
                                              controller
                                                  .settingModel!.siteAddress!,
                                          size: Dimensions.font16,
                                          color: Colors.black87,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  IconAndTextWidget(
                                      icon: Icons.phone,
                                      text: controller.settingModel!.sitePhone!,
                                      iconColor: Colors.amber),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  IconAndTextWidget(
                                      icon: Icons.timer,
                                      text: controller
                                          .settingModel!.siteWorkTime!,
                                      iconColor: Colors.amber),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   child: HtmlWidget(settingController.settingModel!.siteMap!),
                      // )
                    ],
                  ),
                )
              : CustomLoader(),
        );
      });
    });
  }
}
