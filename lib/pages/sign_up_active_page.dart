import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/verification_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

import '../components/shared/app_textfield.dart';

class SignUpActivePage extends StatefulWidget {
  SignUpActivePage({Key? key}) : super(key: key);

  @override
  State<SignUpActivePage> createState() => _SignUpActivePageState();
}

class _SignUpActivePageState extends State<SignUpActivePage> {
  bool _isButtonDisabled = true;

  // textinput controllers
  final accountNumberTextController = TextEditingController();

  final passwordTextController = TextEditingController();

  final confirmPasswordTextController = TextEditingController();

  void buttonValidationCheck() {
    if (accountNumberTextController.text.isEmpty ||
        passwordTextController.text.isEmpty ||
        confirmPasswordTextController.text.isEmpty ||
        passwordTextController.text != confirmPasswordTextController.text ||
        accountNumberTextController.text.length < 10) {
      setState(() {
        _isButtonDisabled = true;
      });
    } else {
      setState(() {
        _isButtonDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          backgroundColor: whiteColor,
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
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: AppButton(
          text: "Continue",
          onPress: () {
            Get.to(const VerificationPage());
          },
          isDisabled: _isButtonDisabled,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 1,
              ),
              const Text(
                "Set Profile",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333)),
              ),
              const SizedBox(
                height: 2,
              ),
              const Padding(
                padding: EdgeInsets.only(),
                child: Text(
                  "Set up your online profile with Island MFB account by providing the details below.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              AppTextField(
                hint: "Enter Account Number",
                label: "Account Number",
                textController: accountNumberTextController,
                onChanged: (text) {
                  buttonValidationCheck();
                },
                textInputType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                validator: ValidationBuilder().minLength(10).build(),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                hint: "***************",
                label: "Enter Password",
                textController: passwordTextController,
                onChanged: (text) {
                  buttonValidationCheck();
                },
                hideText: true,
                validator: ValidationBuilder().minLength(8).build(),
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                hint: "***************",
                label: "Confirm Password",
                textController: confirmPasswordTextController,
                onChanged: (text) {
                  buttonValidationCheck();
                },
                hideText: true,
                validator: ValidationBuilder().minLength(8).build(),
              ),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
      backgroundColor: whiteColor,
    );
  }
}
