import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_snackbar.dart';
import 'package:islandmfb_flutter_version/models/enums/verification_from_type.dart';
import 'package:islandmfb_flutter_version/pages/login_page.dart';
import 'package:islandmfb_flutter_version/pages/navigation.dart';
import 'package:islandmfb_flutter_version/pages/success_page.dart';
import 'package:islandmfb_flutter_version/state/signup_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key, this.verficationFrom}) : super(key: key);

  final VerificationFromType? verficationFrom;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  // buttons state
  bool _isButtonDisabled = true;
  bool _isButtonLoading = false;
  VerificationFromType? verificationFrom;
  // pin text controller
  TextEditingController pinTextController = TextEditingController();

// state controllers
  SetUpProfileFormController setUpProfileFormController =
      Get.put(SetUpProfileFormController());

  CreateAccountFormController createAccountFormController =
      Get.put(CreateAccountFormController());

  // steams
  StreamSubscription? verifyOtpAndCreateAccountStream;
  StreamSubscription? verifyOtpAndGoToPersonalInfoPage;

  String _verificationText = "";
  void buttonValidationCheck() {
    if (pinTextController.text.length < 6) {
      setState(() {
        _isButtonDisabled = true;
      });
    } else {
      setState(() {
        _isButtonDisabled = false;
      });
    }
  }

  void stopLoading() {
    if (mounted) {
      setState(() {
        _isButtonLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    verifyOtpAndCreateAccountStream?.cancel();
    verifyOtpAndGoToPersonalInfoPage?.cancel();
  }

  @override
  void initState() {
    super.initState();

    if (Get.arguments != null && Get.arguments["verificationFrom"] != null) {
      verificationFrom =
          Get.arguments?["verificationFrom"] as VerificationFromType?;
    } else if (widget.verficationFrom != null) {
      verificationFrom = widget.verficationFrom;
    } else {
      verificationFrom = VerificationFromType.setUpOnlineProfile;
    }

    if (mounted) {
      setState(() {
        switch (verificationFrom) {
          case VerificationFromType.setUpOnlineProfile:
            _verificationText =
                "Enter the 6 digit code we sent to the mobile number and email address linked to your account.";
            break;
          case VerificationFromType.createAccount:
            _verificationText =
                "Enter the 6 digit code sent to the email address and phone number you provided.";
            break;
          default:
            break;
        }
      });
    }
  }

  void verifyPin() {
    if (mounted) {
      setState(() {
        _isButtonLoading = true;
      });
    }
    switch (verificationFrom) {
      case VerificationFromType.setUpOnlineProfile:
        {
          verifyOtpAndCreateAccountStream = setUpProfileFormController
              .verifyOtpAndCreateAccount(pinTextController.text)
              .asStream()
              .listen((event) {
            if (event.data == null) {
              AppSnackBar.error("Error", event.customErrorMessage!);
            } else {
              Get.to(() => SuccessPage(
                    buttonText: "Start using",
                    successMessage:
                        "You have successfully signed up your account in our app and can start using",
                    nextPage: const LoginPage(),
                    offAll: true,
                  ));
            }
            stopLoading();
          });
          break;
        }
      case VerificationFromType.createAccount:
        {
          verifyOtpAndGoToPersonalInfoPage = createAccountFormController
              .verifyPin(pinTextController.text)
              .asStream()
              .listen((event) {
            if (event.data == null) {
              AppSnackBar.error("Error", event.customErrorMessage!);
            } else {
              Get.offNamed(AppRoutes.personalInformationPage);
            }
            stopLoading();
          });
          break;
        }
      default:
        {
          break;
        }
    }
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
          isDisabled: _isButtonDisabled || _isButtonLoading,
          text: _isButtonLoading ? "Loading..." : "Continue",
          onPress: verifyPin,
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
              "Verification",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333)),
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: Text(
                _verificationText,
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w100),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PinCodeTextField(
              controller: pinTextController,
              appContext: context,
              animationType: AnimationType.none,
              length: 6,
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
