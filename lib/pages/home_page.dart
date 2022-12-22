import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/home_page/home_page_app_bar.dart';
import 'package:islandmfb_flutter_version/components/home_page/home_page_quick_action.dart';
import 'package:islandmfb_flutter_version/components/home_page/home_page_transaction_history_buttons.dart';
import 'package:islandmfb_flutter_version/components/shared/app_customer_accounts_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_drawer.dart';
import 'package:islandmfb_flutter_version/pages/airtime_page.dart';
import 'package:islandmfb_flutter_version/pages/transfer_type_page.dart';
import 'package:islandmfb_flutter_version/pages/login_page.dart';
import 'package:islandmfb_flutter_version/pages/transaction_history_page.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/state/token_state_controller.dart';
import 'package:islandmfb_flutter_version/state/transactions_state_controller.dart';
import 'package:islandmfb_flutter_version/state/user_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userState = Get.put(UserStateController());
  final tokenState = Get.put(AuthStateController());
  final accountState = Get.put(AccountStateController());
  final transactionState = Get.put(TransactionStateController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future(() async {
      if (userState.keycloakUserInfo.isEmpty ||
          accountState.customerAccounts.isEmpty) {
        Get.to(const LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedAccount = accountState.selectedAccount;
    var customerDetail = accountState.customerDetails;
    final nairaFormat = NumberFormat.currency(name: "N  ");

    Future(() async {
      await transactionState.setRecentTransactionHistory();
    });

    void openChangeAccountModal() {
      showModalBottomSheet<void>(
          context: context,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          builder: (BuildContext context) {
            return HomePageBottomSheet();
          });
    }

    if (userState.keycloakUserInfo.isEmpty ||
        accountState.customerAccounts.isEmpty) {
      return Container();
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: whiteColor,
        drawer: AppDrawer(),
        appBar: homePageAppBar(() {}),
        body: RefreshIndicator(
          onRefresh: () async {
            await reLoginWithRefreshToken();
            await userState.setKeycloakUserInfoStateFromToken();
            await accountState.refreshAccountsState();
          },
          backgroundColor: primaryColor,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          color: whiteColor,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
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
                      Obx(() => Text(
                            "Hi ${customerDetail["name"]?.split(" ")?[0]!.toString().capitalize ?? " "}",
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
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
                              style: const TextStyle(
                                  color: blackColor, fontSize: 10),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      "${(selectedAccount.value.product) ?? "Savings Account"}  ",
                                ),
                                TextSpan(
                                  text: (selectedAccount.value
                                          .primaryAccountNo!["_number"]) ??
                                      "",
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
                            nairaFormat.format(
                                selectedAccount.value.availableBalance ?? 0.00),
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
                              style: const TextStyle(
                                  color: blackColor, fontSize: 10),
                              children: <TextSpan>[
                                const TextSpan(text: "Book Balance   "),
                                TextSpan(
                                  text: nairaFormat.format(
                                      selectedAccount.value.bookBalance ?? 10),
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
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HomePageQuicActionButtons(
                          name: "Transfer",
                          onTap: () {
                            Get.to(() => const TransferTypePage(),
                                transition: Transition.downToUp);
                          },
                          svgUrlString:
                              "assets/images/transferQuickActions.svg",
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        HomePageQuicActionButtons(
                          name: "Airtime",
                          onTap: () {
                            Get.to(() => const AirtimePage());
                          },
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Transaction History",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const TransactionHistoryPage());
                        },
                        child: const Text(
                          "View all",
                          style: TextStyle(fontSize: 12, color: successColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  (FutureBuilder<List>(future: Future(() async {
                    await transactionState.setRecentTransactionHistory();
                    return Future.value(
                        transactionState.recentTransactionHistoryState);
                  }), builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return Obx(() => transactionState
                              .recentTransactionHistoryState.isEmpty
                          ? const Center(
                              child: Text("You have no transaction history",
                                  style: TextStyle(color: accentColor)),
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: ((context, index) {
                                return HomePageTransactionHistoryButtons(
                                  nairaFormat: nairaFormat,
                                  accountOwner: "Akinjoke",
                                  otherAccount: "Akinloluwa",
                                  moneyAmount: snapshot.data?[index]?["amount"],
                                  isCredit: true,
                                  narrative: snapshot.data?[index]
                                      ?["narrative"],
                                  date: snapshot.data?[index]?["postDate"],
                                );
                              }),
                            ));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    ));
                  })))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePageBottomSheet extends StatelessWidget {
  HomePageBottomSheet({
    Key? key,
  }) : super(key: key);

  final nairaFormat = NumberFormat.currency(name: "N  ");
  final accountState = Get.put(AccountStateController());

  @override
  Widget build(BuildContext context) {
    final selectedAccount = accountState.selectedAccount;

    final otherAccounts = accountState.customerAccounts.where((account) {
      return account != selectedAccount.value;
    }).toList();

    return Container(
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 3,
                    decoration: BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                otherAccounts.isEmpty
                    ? const Center(
                        child: Text("No other accounts available",
                            style: TextStyle(
                              color: greyColor,
                              fontSize: 18,
                            )),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return AppCustomerAccountButtons(
                            productType: otherAccounts[index].product ?? "",
                            nairaFormat: nairaFormat,
                            accountNo: otherAccounts[index]
                                .primaryAccountNo?["_number"],
                            accountBalance:
                                otherAccounts[index].availableBalance ?? 0,
                            onClick: () {
                              Navigator.pop(context);
                              accountState
                                  .changeSelectedAccount(otherAccounts[index]);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemCount: otherAccounts.length)
              ]),
        ),
      ),
    );
  }
}
