import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/home_page/home_page_app_bar.dart';
import 'package:islandmfb_flutter_version/components/home_page/home_page_quick_action.dart';
import 'package:islandmfb_flutter_version/components/home_page/home_page_transaction_history_buttons.dart';
import 'package:islandmfb_flutter_version/components/shared/app_drawer.dart';
import 'package:islandmfb_flutter_version/pages/login_page.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/state/token_state_controller.dart';
import 'package:islandmfb_flutter_version/state/user_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userState = Get.put(UserStateController());
  final tokenState = Get.put(TokenStateController());
  final accountState = Get.put(AccountStateController());

  @override
  Widget build(BuildContext context) {
    // if (userState.user.isEmpty) {
    //   return LoginPage();
    // }

    var selectedAccount = accountState.selectedAccountState;
    final nairaFormat = NumberFormat.currency(name: "N  ");

    void openChangeAccountModal() {
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                height: 500,
                color: whiteColor,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: 2,
                        width: 100,
                        color: greyColor,
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: whiteColor,
      drawer: AppDrawer(),
      appBar: homePageAppBar(() {}),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Hi " + (userState.user["given_name"] ?? "Moses "),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Change Account",
                        style: const TextStyle(
                          color: successColor,
                          fontSize: 11,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            openChangeAccountModal();
                          }),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style:
                              const TextStyle(color: blackColor, fontSize: 10),
                          children: <TextSpan>[
                            TextSpan(
                              text: (selectedAccount["product"] +
                                      "SAVINGS ACCOUNT") ??
                                  "Savings Account    ",
                            ),
                            TextSpan(
                              text: (selectedAccount["primaryAccountNo"]
                                      ?["_number"]) ??
                                  "01290293820",
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        nairaFormat
                            .format(selectedAccount["availableBalance"] ?? 0),
                        softWrap: true,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      const Text(
                        "Available Balance",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          style:
                              const TextStyle(color: blackColor, fontSize: 10),
                          children: <TextSpan>[
                            const TextSpan(text: "Book Balance   "),
                            TextSpan(
                              text: nairaFormat
                                  .format(selectedAccount["bookBalance"] ?? 0),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  HomePageQuicActionButtons(
                    name: "Transfer",
                    onTap: () {},
                    svgUrlString: "assets/images/transferQuickActions.svg",
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  HomePageQuicActionButtons(
                    name: "Airtime",
                    onTap: () {},
                    svgUrlString: "assets/images/airtimeQuickActions.svg",
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  HomePageQuicActionButtons(
                    name: "Bills",
                    onTap: () {},
                    svgUrlString: "assets/images/billsQuickActions.svg",
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Transaction History",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                  HomePageTransactionHistoryButtons(
                    nairaFormat: nairaFormat,
                    accountOwner: "Akinjoke",
                    otherAccount: "Akinloluwa",
                    moneyAmount: 30000,
                    isCredit: true,
                    date: "Thursday, July 12th 2022",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
