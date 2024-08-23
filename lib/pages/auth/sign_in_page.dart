import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/auth_controller.dart';
import 'package:flutter_babe/pages/auth/sign_up_page.dart';
import 'package:flutter_babe/routes/router_help.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/app_text_filed.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    String previousRoute = Get.arguments ?? '/menu-page';
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    var signUpImage = ["facebook.png", "google.png"];

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        CustomSnackBar("enter_your_email".tr, title: "email".tr);
      } else if (!GetUtils.isEmail(email)) {
        CustomSnackBar("enter_your_valid_email".tr, title: "email".tr);
      } else if (password.isEmpty) {
        CustomSnackBar("enter_your_password".tr, title: "password".tr);
      } else if (password.length <= 7) {
        CustomSnackBar("password_at_least_8".tr, title: "password".tr);
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            CustomSnackBar("login_successfully".tr,
                isError: false, title: "success".tr);

            print(previousRoute.toString());
            Get.offAndToNamed(previousRoute);
            // Get.back();
            print("login ok");
          } else {
            CustomSnackBar(status.message!);
          }
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("login".tr),
          backgroundColor: AppColors.colorAppBar,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (controller) {
          return !controller.isLoading
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        Container(
                          height: Dimensions.screenHeight * 0.20,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 60,
                              backgroundImage:
                                  AssetImage("assets/images/logobabe.png"),
                            ),
                          ),
                        ),
                        Text(
                          "login".tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AppTextField(
                            textController: emailController,
                            labelText: "Email",
                            icon: Icons.email),
                        AppTextField(
                          textController: passwordController,
                          labelText: "password".tr,
                          icon: Icons.password,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _login(controller);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            width: double.maxFinite,
                            height: Dimensions.screenHeight / 15,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                            ),
                            child: Center(
                              child: BigText(
                                text: "login".tr,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: Dimensions.height15,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.back(),
                                  text: "forgot_password".tr,
                                  style: TextStyle(
                                    color: Colors.red[400],
                                    fontSize: Dimensions.font16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        RichText(
                          text: TextSpan(
                            //recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                            text: "dont_you_have_account".tr + " ",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => SignUpPage()),
                                text: "signup".tr,
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: Dimensions.font16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        // RichText(
                        //   text: TextSpan(
                        //     recognizer: TapGestureRecognizer()
                        //       ..onTap = () => Get.back(),
                        //     text: "login_with".tr,
                        //     style: TextStyle(
                        //       color: Colors.grey[500],
                        //       fontSize: Dimensions.font16,
                        //     ),
                        //   ),
                        // ),
                        // Wrap(
                        //   children: List.generate(
                        //     signUpImage.length,
                        //     (index) => Padding(
                        //       padding: EdgeInsets.all(10.0),
                        //       child: CircleAvatar(
                        //         radius: Dimensions.radius20,
                        //         backgroundImage: AssetImage(
                        //             "assets/images/" + signUpImage[index]),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              : CustomLoader();
        }));
  }
}
