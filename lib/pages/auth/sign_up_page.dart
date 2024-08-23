import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/auth_controller.dart';
import 'package:flutter_babe/models/signup_model.dart';
import 'package:flutter_babe/pages/auth/sign_in_page.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/utils/dimension.dart';
import 'package:flutter_babe/widgets/app_text_filed.dart';
import 'package:flutter_babe/widgets/big_text.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:flutter_babe/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  var signUpImage = ["facebook.png", "google.png"];

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // Your build method code here
    return Scaffold(
      appBar: AppBar(
        title: Text("signup".tr),
        backgroundColor: AppColors.colorAppBar,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                      "signup".tr,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        textController: nameController,
                        labelText: "fullname".tr,
                        icon: Icons.person),
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
                    AppTextField(
                      textController: rePasswordController,
                      labelText: "confirm_password".tr,
                      icon: Icons.password,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _registration();
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
                            text: "signup".tr,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10 * 2,
                    ),
                    RichText(
                      text: TextSpan(
                        //recognizer: TapGestureRecognizer()
                        // ..onTap = () => Get.to(() => SignInPage()),
                        text: "have_an_account_already".tr,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.font16,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => SignInPage()),
                            text: "login".tr,
                            style: TextStyle(
                              color: AppColors.colorAppBar,
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
                    //     text: "Sign up using one of the following methods",
                    //     style: TextStyle(
                    //       color: Colors.grey[500],
                    //       fontSize: Dimensions.font16,
                    //     ),
                    //   ),
                    // ),
                    // Wrap(
                    //   children: List.generate(
                    //       signUpImage.length,
                    //       (index) => Padding(
                    //             padding: EdgeInsets.all(10.0),
                    //             child: CircleAvatar(
                    //               radius: Dimensions.radius20,
                    //               backgroundImage: AssetImage(
                    //                   "assets/images/" + signUpImage[index]),
                    //             ),
                    //           )),
                    // ),
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  void _registration() {
    var authController = Get.find<AuthController>();
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String rePassword = rePasswordController.text.trim();

    if (name.isEmpty) {
      CustomSnackBar("enter_your_name".tr, title: "fullname".tr);
    } else if (email.isEmpty) {
      CustomSnackBar("enter_your_email".tr, title: "email".tr);
    } else if (!GetUtils.isEmail(email)) {
      CustomSnackBar("enter_your_valid_email".tr, title: "email".tr);
    } else if (password.isEmpty) {
      CustomSnackBar("enter_your_password", title: "password".tr);
    } else if (password.length <= 7) {
      CustomSnackBar("password_at_least_8".tr, title: "password".tr);
    } else if (rePassword != password) {
      CustomSnackBar("password_does_not_mactch".tr, title: "password".tr);
    } else {
      SignUpModel signUpModel =
          SignUpModel(name: name, email: email, password: password);
      authController.signUp(signUpModel).then((status) {
        if (status.isSuccess) {
          print("ok");
          emailController.clear();
          nameController.clear();
          passwordController.clear();
          rePasswordController.clear();

          CustomSnackBar(
            "registered_successfully".tr,
            isError: false,
            title: "success".tr,
          );
        } else {
          CustomSnackBar(status.message);
        }
      });
    }
  }
}
