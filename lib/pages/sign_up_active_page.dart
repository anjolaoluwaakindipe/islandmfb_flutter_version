import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/verification_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

import '../components/shared/app_textfield.dart';

class SignUpActivePage extends StatelessWidget {
  SignUpActivePage({Key? key}) : super(key: key);

  final accountNumberTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        // leading: SizedBox(
        //   height: 1,
        //   child: SvgPicture.asset(
        //     '../../images/back.svg',
        //     height: 1,
        //     width: 1,
        //     fit: BoxFit.contain,
        //   ),
        // ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: AppButton(
          text: "Continue",
          onPress: () {
            Get.to(const VerificationPage());
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
            ),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
              hint: "***************",
              label: "Enter Password",
              textController: passwordTextController,
            ),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
              hint: "***************",
              label: "Confirm Password",
              textController: confirmPasswordTextController,
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
      backgroundColor: whiteColor,
    );
  }
}
