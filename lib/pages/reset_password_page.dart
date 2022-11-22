import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';
import 'package:islandmfb_flutter_version/pages/success_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  // text controllers
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      TextEditingController();

  // keys
  GlobalKey<FormState> resetPasswordPageFormKey = GlobalKey<FormState>();

  // button state
  bool isButtonDisabeld = true;
  void buttonStateHandler() {
    if (_passwordTextController.text.isEmpty ||
        _confirmPasswordTextController.text.isEmpty ||
        _passwordTextController.text != _confirmPasswordTextController.text) {
      setState(() {
        isButtonDisabeld = true;
      });
    } else {
      setState(() {
        isButtonDisabeld = false;
      });
    }
  }

  // continue button function
  void onContinueHandler() {
    if (resetPasswordPageFormKey.currentState!.validate()) {
      Get.to(SuccessPage(
          buttonText: "Continue",
          successMessage: "Your password has been sucessfully resetted"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: resetPasswordPageFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Reset Password",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              AppTextField(
                textController: _passwordTextController,
                hint: "********",
                label: "New Password",
                onChanged: (value) {
                  buttonStateHandler();
                },
                validator: ValidationBuilder().minLength(8).build(),
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                textController: _confirmPasswordTextController,
                hint: "********",
                label: "Confirm Password",
                onChanged: (value) {
                  buttonStateHandler();
                },
                validator: ValidationBuilder().minLength(8).build(),
              ),
            ],
          ),
        ),
      )),
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
          isDisabled: isButtonDisabeld,
        ),
      ),

      backgroundColor: whiteColor,
    );
  }
}
