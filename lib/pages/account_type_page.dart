import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/account_services_pages.dart';
import 'package:islandmfb_flutter_version/pages/personal_informaton_page.dart';
import 'package:islandmfb_flutter_version/pages/verification_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../components/shared/app_textfield.dart';

class AccountTypePage extends StatelessWidget {
  const AccountTypePage({Key? key}) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 1,
            ),
            const Text(
              "Account Type",
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
                "Select an account type",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: Container(
                color: accentColor,
                child: GFListTile(
                  avatar: SvgPicture.asset('assets/images/Group.svg'),
                  color: accentColor,
                  titleText: 'Savings Account',
                  // subTitleText: 'Savings Account',
                  onTap: () {
                    Get.to(const AccountServicesPage());
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: Container(
                color: accentColor,
                child: GFListTile(
                  avatar: SvgPicture.asset('assets/images/Group.svg'),
                  color: accentColor,
                  titleText: 'Current Account',
                  // subTitleText: 'Current Account',
                  onTap: () {
                    Get.to(const AccountServicesPage());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: whiteColor,
    );
  }
}
