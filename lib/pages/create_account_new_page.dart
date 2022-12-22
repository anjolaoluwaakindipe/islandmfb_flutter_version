import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_gesture_detector.dart';
import 'package:islandmfb_flutter_version/components/shared/app_snackbar.dart';
import 'package:islandmfb_flutter_version/models/enums/verification_from_type.dart';
import 'package:islandmfb_flutter_version/pages/navigation.dart';
import 'package:islandmfb_flutter_version/pages/personal_informaton_page.dart';
import 'package:islandmfb_flutter_version/state/signup_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

import '../components/shared/app_textfield.dart';

class CreateAccountNewPage extends StatefulWidget {
  const CreateAccountNewPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountNewPage> createState() => _CreateAccountNewPageState();
}

class _CreateAccountNewPageState extends State<CreateAccountNewPage> {
  // text controllers
  TextEditingController bvnTextController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  PhoneNumber phoneNumberText = PhoneNumber(isoCode: "NG");
  var passwordTextEditingController = TextEditingController();
  var loginIdTextEditingController = TextEditingController();
  var confirmPasswordTextEditingControlller = TextEditingController();

  // form key
  final GlobalKey<FormState> _createAccountFormKey = GlobalKey<FormState>();

  // button state
  bool isButtonDisabled = true;
  bool _isContinueButtonLoading = false;

  // state controllers
  CreateAccountFormController createAccountFormController =
      Get.put(CreateAccountFormController());

  // steam
  StreamSubscription? sendOtpStream;

  @override
  void initState() {
    super.initState();
  }

  // Validation to enable/disable the Continue button
  void buttonStateHandler() {
    if (bvnTextController.text.isEmpty ||
        phoneNumberTextEditingController.text.isEmpty ||
        emailTextEditingController.text.isEmpty ||
        bvnTextController.text.length < 11 ||
        // passwordTextEditingController.text.isEmpty ||
        // confirmPasswordTextEditingControlller.text.isEmpty ||
        // loginIdTextEditingController.text.isEmpty ||
        // passwordTextEditingController.text !=
        // confirmPasswordTextEditingControlller.text ||
        phoneNumberTextEditingController.text.length < 10 ||
        phoneNumberText.phoneNumber!.length < 11) {
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  void onContinueHandler() {
    if (_createAccountFormKey.currentState!.validate()) {
      if (mounted) {
        setState(() {
          _isContinueButtonLoading = true;
        });
      }
      sendOtpStream?.cancel();
      sendOtpStream = createAccountFormController
          .setInitialInfoAndSendOtp(
              bvnTextController.text,
              phoneNumberText.phoneNumber!,
              emailTextEditingController.text,
              loginIdTextEditingController.text,
              passwordTextEditingController.text)
          .asStream()
          .listen((event) {
        if (event.data == null || event.data == false) {
          AppSnackBar.error("Error", event.customErrorMessage!);
        } else {
          if (event.customErrorMessage != null &&
              event.customErrorMessage!.isNotEmpty) {
            AppSnackBar.warning("Warning", event.customErrorMessage!);
          }
          Get.toNamed(AppRoutes.verificationPage, arguments: {
            "verificationFrom": VerificationFromType.createAccount
          });
        }

        if (mounted) {
          setState(() {
            _isContinueButtonLoading = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    sendOtpStream?.cancel();
    createAccountFormController.clearCreateAccountFormInfo();
  }

  @override
  Widget build(BuildContext context) {
    return AppGestureDetector(
      child: Scaffold(
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: AppButton(
            text: _isContinueButtonLoading ? "Loading..." : "Continue",
            onPress: () {
              onContinueHandler();
            },
            isDisabled: isButtonDisabled || _isContinueButtonLoading,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Form(
              key: _createAccountFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 1,
                  ),
                  const Text(
                    "Create Your Account",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      "Create an account by providing the details needed below.",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    hint: "Enter your BVN",
                    label: "BVN",
                    textController: bvnTextController,
                    textInputType: const TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false,
                    ),
                    onChanged: (value) {
                      buttonStateHandler();
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(11)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // AppTextField(
                  //   hint: "Enter your phone number",
                  //   label: "Phone Number",
                  //   textController: phoneNumberTextEditingController,
                  //   onChanged: (value) {
                  //     buttonStateHandler();
                  //   },
                  //   inputFormatters: <TextInputFormatter>[
                  //     LengthLimitingTextInputFormatter(14)
                  //   ],
                  //   textInputType: TextInputType.phone,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Phone number",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: blackColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: accentColor,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            setState(() {
                              phoneNumberText = number;
                            });
                            buttonStateHandler();
                          },
                          validator: (p0) {
                            return;
                          },
                          initialValue: PhoneNumber(isoCode: "NG"),
                          spaceBetweenSelectorAndTextField: 0,
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                          ignoreBlank: true,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          textFieldController: phoneNumberTextEditingController,
                          formatInput: false,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: InputBorder.none,
                          cursorColor: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    hint: "Enter your email",
                    label: "Email Address",
                    onChanged: (value) {
                      buttonStateHandler();
                    },
                    textController: emailTextEditingController,
                    validator: ValidationBuilder()
                        .email("Not a valid email address")
                        .build(),
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // AppTextField(
                  //   hint: "Enter Login ID",
                  //   label: "Login ID",
                  //   textController: loginIdTextEditingController,
                  //   onChanged: (text) {
                  //     buttonStateHandler();
                  //   },
                  //   textInputType: TextInputType.text,
                  //   validator: ValidationBuilder().minLength(5).build(),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // AppTextField(
                  //   hint: "***************",
                  //   label: "Enter Password",
                  //   textController: passwordTextEditingController,
                  //   onChanged: (text) {
                  //     buttonStateHandler();
                  //   },
                  //   isPassword: true,
                  //   validator: ValidationBuilder().minLength(8).build(),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // AppTextField(
                  //   hint: "***************",
                  //   label: "Confirm Password",
                  //   textController: confirmPasswordTextEditingControlller,
                  //   onChanged: (text) {
                  //     buttonStateHandler();
                  //   },
                  //   validator: ValidationBuilder().minLength(8).add((value) {
                  //     if (value != passwordTextEditingController.text) {
                  //       return "Confirm password must match password";
                  //     }
                  //     return null;
                  //   }).build(),
                  //   isPassword: true,
                  // ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: whiteColor,
      ),
    );
  }
}
