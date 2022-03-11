import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/success_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

import '../components/home_page/home_page_quick_action.dart';
import '../components/shared/app_textfield.dart';
import '../components/shared/app_verification_textfield.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/images/back.svg",
                height: 20,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: AppButton(
          text: "Continue",
          onPress: () {
            Get.to(const SuccessPage());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 1,
            ),
            Text(
              "Verification",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333)),
            ),
            SizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: Text(
                "Enter 4 digit code we sent to the mobile number linked to your account",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Row(
            //     children: [
            //       HomePageQuicActionButtons(
            //         name: "Transfer",
            //         onTap: () {},
            //         svgUrlString: "",
            //       ),
            //       const SizedBox(
            //         width: 40,
            //       ),
            //       HomePageQuicActionButtons(
            //         name: "Airtime",
            //         onTap: () {},
            //         svgUrlString: "",
            //       ),
            //       const SizedBox(
            //         width: 40,
            //       ),
            //       HomePageQuicActionButtons(
            //         name: "Bills",
            //         onTap: () {},
            //         svgUrlString: "",
            //       )
            //     ],
            //   ),
          ],
        ),
      ),
      backgroundColor: whiteColor,
    );
  }
}
