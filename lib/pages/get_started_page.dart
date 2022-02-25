import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/lets_get_started_page.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';
import 'package:islandmfb_flutter_version/state/token_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

class GetStartedPage extends StatefulWidget {
  GetStartedPage({Key? key}) : super(key: key);

  TokenController tokenInfoController = Get.put(TokenController());

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.tokenInfoController.tokenInfoState.value);
    widget.tokenInfoController.setTokenFromLogin("aji", "test1234");
    Timer(Duration(seconds: 3),
        () => print(widget.tokenInfoController.tokenInfoState.value));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "../../logo.svg",
              semanticsLabel: 'Island Logo',
            ),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "Welcome to Island Microfinance Bank",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w200,
                  color: Color(0xFF333333)),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 60.0),
              child: Text(
                "Now level of microfinance banking with out customer app",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            AppButton(
              text: "Start",
              onPress: () {
                Get.to(const LetsGetStartedPage());
              },
            ),
            const SizedBox(
              height: 15,
            ),
            const GetStartedSignInLink()
          ],
        ),
      ),
      backgroundColor: whiteColor,
    );
  }
}
