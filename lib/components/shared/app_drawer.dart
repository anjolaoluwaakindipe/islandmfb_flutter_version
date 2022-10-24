import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/components/shared/app_alert_dialogue.dart';
import 'package:islandmfb_flutter_version/pages/airtime_page.dart';
import 'package:islandmfb_flutter_version/pages/another_transfer_page.dart';

import 'package:islandmfb_flutter_version/pages/bill_payment_page.dart';
import 'package:islandmfb_flutter_version/pages/login_page.dart';
import 'package:islandmfb_flutter_version/pages/profile_main_page.dart';
import 'package:islandmfb_flutter_version/pages/profile_set_pin.dart';
import 'package:islandmfb_flutter_version/pages/loan_page.dart';
import 'package:islandmfb_flutter_version/pages/self_service_page.dart';

import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/state/token_state_controller.dart';
import 'package:islandmfb_flutter_version/state/transactions_state_controller.dart';
import 'package:islandmfb_flutter_version/state/user_state_controller.dart';
import 'package:islandmfb_flutter_version/storage/secure_storage.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({
    Key? key,
  }) : super(key: key);

  final accountState = Get.put(AccountStateController());

  final userState = Get.put(UserStateController());
  final tokenState = Get.put(TokenStateController());
  final transactionState = Get.put(TransactionStateController());

  @override
  Widget build(BuildContext context) {
    var customerDetails = accountState.customerDetails;

    void onLogoutClick() {
      showDialog(
          context: context,
          builder: (BuildContext context) => AppAlertDialogue(
                content: "You sure you want to Logout?",
                contentColor: blackColor,
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await Get.offAll(const LoginPage(),
                          transition: Transition.zoom);
                      userState.clearUserState();
                      accountState.clearAccountState();
                      transactionState.clearTransactionState();
                      tokenState.clearTokenState();
                      SecureStorage.deleteAValue("access_token");
                      SecureStorage.deleteAValue("refresh_token");
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
                          text: customerDetails["name"] ?? "",
                          backgroundColor: primaryColor,
                          size: 50,
                        )),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Obx(() => Text(
                        customerDetails["name"] ?? "",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("BVN: " + (customerDetails["bvn"] ?? ""),
                      style: const TextStyle(fontSize: 12)),
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
                    onClickHandler: () {
                      Get.to(const TransferTypePage());
                    },
                  ),
                  DrawerNavButtons(
                    name: "Loan",
                    svgUrl: "assets/images/drawerLoan.svg",
                    onClickHandler: () {
                      Get.to(LoanPage());
                    },
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
                    onClickHandler: () {
                      Get.to(const SelfServicePage());
                    },
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
  final Function onClickHandler;

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
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
