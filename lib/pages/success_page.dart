import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/create_account_new_page.dart';
import 'package:islandmfb_flutter_version/pages/lets_get_started_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/bi_shield-fill-check.svg",
              semanticsLabel: 'Success',
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Success!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                  color: Color(0xFF333333)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 1.0),
              child: Text(
                "You have successfully signed up your account in our app and can start using",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            AppButton(
              text: "Start using",
              onPress: () {
                Get.to( CreateAccountNewPage());
              },
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
