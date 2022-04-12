import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:islandmfb_flutter_version/pages/profile_personal_information_page.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';

import '../utilities/colors.dart';

class ProfileMainPage extends StatefulWidget {
  const ProfileMainPage({Key? key}) : super(key: key);

  @override
  _ProfileMainPageState createState() => _ProfileMainPageState();
}

class _ProfileMainPageState extends State<ProfileMainPage> {
  AccountStateController accountState = Get.put(AccountStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/images/back.svg",
              height: 20,
            ),
          ),
        ),
        backgroundColor: whiteColor,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const GFAvatar(
                      backgroundImage:
                          NetworkImage("assets/images/mainProfile.png"),
                      size: GFSize.LARGE,
                      radius: 70,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      accountState.customerDetails["name"] ?? " ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("BVN: " + (accountState.customerDetails["bvn"] ?? "")),
                    const SizedBox(
                      height: 25,
                    ),
                    ProfileListTile(
                      titleText: "Personal Information",
                      color: accentColor,
                      onTap: () {
                        Get.to(const ProfilePersonalInformationPage());
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ProfileListTile(
                      titleText: "Contact Details",
                      color: accentColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ProfileListTile(
                      titleText: "Means of Identification",
                      color: accentColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ProfileListTile(
                      titleText: "Proof of Address",
                      color: accentColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ProfileListTile(
                      titleText: "Employment Details",
                      color: accentColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ProfileListTile(
                      titleText: "Next of kin Details",
                      color: accentColor,
                    ),
                    const SizedBox(height: 40)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  ProfileListTile(
      {Key? key, required this.color, required this.titleText, this.onTap})
      : super(key: key);

  final String titleText;
  final Color color;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(titleText),
                  const Icon(Icons.chevron_right_sharp),
                ],
              )
            ]),
      ),
    );
  }
}
