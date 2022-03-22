import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/create_account_new_page.dart';
import 'package:islandmfb_flutter_version/pages/sign_up_active_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

class LetsGetStartedPage extends StatelessWidget {
  const LetsGetStartedPage({Key? key}) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/pana.svg",
              semanticsLabel: 'Island Logo',
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Let's get started",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                  color: Color(0xFF333333)),
            ),
            const SizedBox(
              height: 2,
            ),
            const Padding(
              padding: EdgeInsets.only(),
              child: Text(
                "Never a better time than new to start enjoying Microfinance banking on a new level",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            AppButton(
              text: "Set Up Profile",
              onPress: () {
                Get.to(SignUpActivePage());
              },
            ),
            const SizedBox(
              height: 15,
            ),
            RichText(
              text: TextSpan(
                  text: "Create an Account",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                    fontSize: 14,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Get.to(CreateAccountNewPage())),
            ),
          ],
        ),
      ),
      backgroundColor: whiteColor,
    );
  }
}
