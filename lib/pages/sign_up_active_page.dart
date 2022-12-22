import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_gesture_detector.dart';
import 'package:islandmfb_flutter_version/components/shared/app_snackbar.dart';
import 'package:islandmfb_flutter_version/models/enums/verification_from_type.dart';
import 'package:islandmfb_flutter_version/models/response_model.dart';
import 'package:islandmfb_flutter_version/pages/navigation.dart';
import 'package:islandmfb_flutter_version/pages/verification_page.dart';
import 'package:islandmfb_flutter_version/state/signup_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

import '../components/shared/app_textfield.dart';

class SignUpActivePage extends StatefulWidget {
  const SignUpActivePage({Key? key}) : super(key: key);

  @override
  State<SignUpActivePage> createState() => _SignUpActivePageState();
}

class _SignUpActivePageState extends State<SignUpActivePage> {
  bool _isButtonDisabled = true;

  // getx controllers and values
  final _signUpController = Get.put(SetUpProfileFormController());

  // textinput controllers
  final accountNumberTextController = TextEditingController();

  final passwordTextController = TextEditingController();

  final confirmPasswordTextController = TextEditingController();

  final loginIdTextController = TextEditingController();

  // button state
  bool _isLoading = false;

  // streams
  StreamSubscription<ResponseM>? sendOtpStream;

  void buttonValidationCheck() {
    if (accountNumberTextController.text.isEmpty ||
        
        loginIdTextController.text.isEmpty ||
        passwordTextController.text != confirmPasswordTextController.text ||
        accountNumberTextController.text.length < 7) {
      setState(() {
        _isButtonDisabled = true;
      });
    } else {
      setState(() {
        _isButtonDisabled = false;
      });
    }
  }

  Future sendOtp() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    sendOtpStream?.cancel();
    _signUpController.setAccountNumberUsernameAndPassword(
        accountNumberTextController.text,
        passwordTextController.text,
        loginIdTextController.text);
    sendOtpStream = _signUpController.sendOtp().asStream().listen((event) {
      if (event.data == null) {
        if (event.customErrorMessage != null &&
            event.customErrorMessage!.isNotEmpty) {
          AppSnackBar.error(
            "Error",
            event.customErrorMessage!,
          );
        }
      } else {
        if (event.customErrorMessage != null &&
            event.customErrorMessage!.isNotEmpty) {
          AppSnackBar.warning(
            "Warning",
            event.customErrorMessage!,
          );
        }
        Get.toNamed(
          AppRoutes.verificationPage,
          arguments: {
            "verficationFrom": VerificationFromType.setUpOnlineProfile
          },
        );
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    sendOtpStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AppGestureDetector(
      child: Scaffold(
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
            text: _isLoading ? "Loading..." : "Continue",
            onPress: () async {
              // Get.to(const VerificationPage());
              await sendOtp();
            },
            isDisabled: _isButtonDisabled || _isLoading,
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
                  validator: ValidationBuilder().minLength(7).build(),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  hint: "Enter Login ID",
                  label: "Login ID",
                  textController: loginIdTextController,
                  onChanged: (text) {
                    buttonValidationCheck();
                  },
                  textInputType: TextInputType.text,
                  validator: ValidationBuilder().minLength(5).build(),
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
                  isPassword: true,
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
                  validator: ValidationBuilder().minLength(8).add((value) {
                    if (value != passwordTextController.text) {
                      return "Confirm password must match password";
                    }
                    return null;
                  }).build(),
                  isPassword: true,
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
      ),
    );
  }
}
