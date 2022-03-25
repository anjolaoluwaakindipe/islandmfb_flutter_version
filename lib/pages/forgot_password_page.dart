import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';
import 'package:islandmfb_flutter_version/pages/forgot_password_verification_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  // text controllers
  final TextEditingController _emailTextController = TextEditingController();

  // keys
  final GlobalKey<FormState> _forgotPasswordPageFormKey =
      GlobalKey<FormState>();

  void onContinueHandler() {
    if (_forgotPasswordPageFormKey.currentState!.validate()) {
      Get.to(ForgotPasswordVerificationPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/images/back.svg",
              height: 20,
            ),
          ),
        ),
        backgroundColor: whiteColor,
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
      ),
      //BOTTOM NAV
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20,
        ),
        child: AppButton(
          text: "Continue",
          onPress: () {
            onContinueHandler();
          },
        ),
      ),

      backgroundColor: whiteColor,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Forgot Password?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Enter your email to recover your password",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _forgotPasswordPageFormKey,
              child: AppTextField(
                textController: _emailTextController,
                label: "Email",
                hint: "example@gmail.com",
                textInputType: TextInputType.emailAddress,
                validator: ValidationBuilder(
                        requiredMessage: "This field can't be empty")
                    .email("Please provide a valid email address!")
                    .build(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
