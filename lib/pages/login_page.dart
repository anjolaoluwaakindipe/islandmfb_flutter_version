import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islandmfb_flutter_version/components/shared/app_alert_dialogue.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/pages/lets_get_started_page.dart';
import 'package:islandmfb_flutter_version/requests/account_request.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/state/loading_state_controller.dart';
import 'package:islandmfb_flutter_version/state/token_state_controller.dart';
import 'package:islandmfb_flutter_version/state/user_state_controller.dart';

import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextControllers
  final passwordTextController = TextEditingController();
  final loginIdController = TextEditingController();

  // State controllers
  final tokenState = Get.put(TokenStateController());
  final accountState = Get.put(AccountStateController());
  final userState = Get.put(UserStateController());

  // page state
  bool isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    void userLoginOnClick() async {
      context.loaderOverlay.show();

      final token = tokenState.tokenState;
      final user = userState.user;
      await tokenState.setTokenFromLogin(
        loginIdController.text,
        passwordTextController.text,
      );

      await userState.setUserStateFromToken();
      late String? accountError;
      if (user.containsKey("customer_no")) {
        accountError = await accountState
            .setAccountStateFromLogin(user["customer_no"].toString());
      }

      context.loaderOverlay.hide();

      if (token.containsKey("access_token") &&
          user.isNotEmpty &&
          accountState.customerAccounts.isNotEmpty) {
        Get.to(() => const HomePage());
      } else {
        showDialog(
            context: context,
            builder: (_) => AppAlertDialogue(
                  content: token["error_description"] ??
                      (accountError ??
                          "An unexpected error occurred while login in. Please try again"),
                  contentColor: primaryColor,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(
                          color: blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
            barrierDismissible: true);
      }
    }

    void isTextFieldBlankValidation(String value) {
      if (loginIdController.text.isEmpty ||
          passwordTextController.text.isEmpty) {
        setState(() {
          isButtonDisabled = true;
        });
      } else {
        setState(() {
          isButtonDisabled = false;
        });
      }
    }

    return LoaderOverlay(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      SvgPicture.asset("assets/images/logo.svg",
                          semanticsLabel: 'Island Logo'),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "Use your email address, phone number or account number as your login id",
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppTextField(
                        label: "Login ID",
                        hint: "login id",
                        key: Key(1.toString()),
                        textController: loginIdController,
                        onChanged: isTextFieldBlankValidation,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppTextField(
                        label: "Password",
                        hint: "***********",
                        key: Key(2.toString()),
                        textController: passwordTextController,
                        onChanged: isTextFieldBlankValidation,
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: const TextSpan(
                            text: "Forgot Password?",
                            style: TextStyle(color: blackColor)),
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppButton(
                        text: "Sign In",
                        onPress: userLoginOnClick,
                        isDisabled: isButtonDisabled,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(),
                            children: <TextSpan>[
                              const TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(color: blackColor),
                              ),
                              TextSpan(
                                text: "Get Started",
                                style: const TextStyle(color: successColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(const LetsGetStartedPage());
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
