import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/components/shared/app_alert_dialogue.dart';
import 'package:islandmfb_flutter_version/pages/airtime_page.dart';
import 'package:islandmfb_flutter_version/pages/bill_payment_page.dart';
import 'package:islandmfb_flutter_version/pages/lets_get_started_page.dart';
import 'package:islandmfb_flutter_version/pages/login_page.dart';
import 'package:islandmfb_flutter_version/pages/profile_main_page.dart';
import 'package:islandmfb_flutter_version/pages/profile_set_pin.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);

  final accountState = Get.put(AccountStateController());

  @override
  Widget build(BuildContext context) {
    var selectedAccount = accountState.selectedAccountState;

    void onLogoutClick() {
      showDialog(
          context: context,
          builder: (BuildContext context) => AppAlertDialogue(
                content: "Are you sure you want to Logout?",
                contentColor: blackColor,
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.to(const LetsGetStartedPage());
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: blackColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(
                        color: blackColor,
                      ),
                    ),
                  ),
                ],
              ),
          barrierDismissible: true);
    }

    return Drawer(
      backgroundColor: whiteColor,
      child: Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Obx(() => Initicon(
                            text: selectedAccount["accountName"] ?? "",
                            backgroundColor: primaryColor,
                            size: 50,
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Obx(() => Text(
                          selectedAccount["accountName"] ?? "",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("BVN: " "222900866343",
                        style: TextStyle(fontSize: 12)),
                    const SizedBox(height: 20),
                  ],
                ),
                Column(
                  children: [
                    DrawerNavButtons(
                      name: "Accounts",
                      svgUrl: "assets/images/drawerAccounts.svg",
                      onClickHandler: () {},
                    ),
                    DrawerNavButtons(
                      name: "Transfer",
                      svgUrl: "assets/images/drawerTransfer.svg",
                      onClickHandler: () {},
                    ),
                    DrawerNavButtons(
                      name: "Loan",
                      svgUrl: "assets/images/drawerLoan.svg",
                      onClickHandler: () {},
                    ),
                    DrawerNavButtons(
                      name: "Airtime",
                      svgUrl: "assets/images/drawerAirtime.svg",
                      onClickHandler: () {
                        Get.to(const AirtimePage());
                      },
                    ),
                    DrawerNavButtons(
                      name: "Bill payment",
                      svgUrl: "assets/images/drawerBillPayment.svg",
                      onClickHandler: () {
                        Get.to(const BillPaymentPage());
                      },
                    ),
                    DrawerNavButtons(
                      name: "Self service",
                      svgUrl: "assets/images/drawerSelfService.svg",
                      onClickHandler: () {},
                    ),
                    DrawerNavButtons(
                      name: "Self service",
                      svgUrl: "assets/images/drawerSelfService.svg",
                      onClickHandler: () {},
                    ),
                    DrawerNavButtons(
                      name: "Profile",
                      svgUrl: "assets/images/drawerProfile.svg",
                      onClickHandler: () {
                        Get.to(const ProfileMainPage());
                      },
                    ),
                    DrawerNavButtons(
                      name: "Set PIN",
                      svgUrl: "assets/images/drawerSetPin.svg",
                      onClickHandler: () {
                        Get.to(const ProfileSetPinPage());
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        DrawerNavButtons(
                          name: "Logout",
                          svgUrl: "assets/images/drawerLogout.svg",
                          onClickHandler: onLogoutClick,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerNavButtons extends StatelessWidget {
  const DrawerNavButtons(
      {Key? key,
      required this.name,
      required this.svgUrl,
      required this.onClickHandler})
      : super(key: key);

  final String name;
  final String svgUrl;
  final onClickHandler;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onClickHandler();
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Ink(
          child: Row(
            children: [
              name == "Profile"
                  ? const SizedBox(width: 2)
                  : const SizedBox(
                      width: 0,
                    ),
              SvgPicture.asset(
                svgUrl,
              ),
              const SizedBox(
                width: 10,
              ),
              name == "Profile"
                  ? const SizedBox(width: 3)
                  : const SizedBox(
                      width: 0,
                    ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
