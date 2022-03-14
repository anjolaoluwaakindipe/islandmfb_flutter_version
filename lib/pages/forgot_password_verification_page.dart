import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/reset_password_page.dart';
import 'package:islandmfb_flutter_version/pages/success_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../components/shared/app_textfield.dart';
import '../components/shared/app_verification_textfield.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordVerificationPage> createState() =>
      _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  bool _isButtonDisabled = true;

  // pin text controller
  TextEditingController pinTextController = TextEditingController();

  void buttonValidationCheck() {
    if (pinTextController.text.length < 4) {
      setState(() {
        _isButtonDisabled = true;
      });
    } else {
      setState(() {
        _isButtonDisabled = false;
      });
    }
  }

  void onContinueHandler() {
    Get.to(ResetPasswordPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        toolbarHeight: 80,
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: AppButton(
          isDisabled: _isButtonDisabled,
          text: "Continue",
          onPress: () {
            onContinueHandler();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 1,
            ),
            const Text(
              "Enter 4 digits Code",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333)),
            ),
            const SizedBox(
              height: 2,
            ),
            const Padding(
              padding: EdgeInsets.only(),
              child: Text(
                "Enter the 4 digits code we just sent you in your email address",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w100),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PinCodeTextField(
              hintCharacter: "*",
              autoDismissKeyboard: true,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(11)
              ],
              controller: pinTextController,
              appContext: context,
              animationType: AnimationType.none,
              length: 4,
              onChanged: (value) {
                buttonValidationCheck();
              },
              autoFocus: true,
              cursorColor: primaryColor,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: false,
                signed: false,
              ),
              enableActiveFill: true,
              pinTheme: PinTheme(
                borderRadius: BorderRadius.circular(5),
                activeColor: accentColor,
                shape: PinCodeFieldShape.box,
                activeFillColor: accentColor,
                inactiveFillColor: accentColor,
                selectedFillColor: accentColor,
                fieldWidth: 50,
                selectedColor: accentColor,
                inactiveColor: accentColor,
                disabledColor: accentColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
              text: const TextSpan(
                text: "Resend Code",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: whiteColor,
    );
  }
}
