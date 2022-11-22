import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_switch.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/state/transfer_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

import '../models/transfer.dart';

class TransferToOtherBanksVerificationPage extends StatefulWidget {
  const TransferToOtherBanksVerificationPage({Key? key}) : super(key: key);

  @override
  State<TransferToOtherBanksVerificationPage> createState() =>
      _TransferToOtherBanksVerificationPageState();
}

class _TransferToOtherBanksVerificationPageState
    extends State<TransferToOtherBanksVerificationPage> {
  final nairaFormat = NumberFormat.currency(name: "N ");

  final transferState = Get.put(TransferStateController());

  // button handler
  String _buttonText = "Send";
  bool _isloading = false;

  void onPayHandler() async {
    setState(() {
      _isloading = true;
      _buttonText = "Loading...";
    });

    var transactionError =
        await transferState.makeTransaction(TransferType.toOtherBanks);

    if (transactionError != null) {
      print(transactionError);
    }

    setState(() {
      _isloading = false;
      _buttonText = "Verify";
    });
    await Get.put(AccountStateController()).refreshAccountsState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/images/back.svg",
              height: 20,
            ),
          ),
        ),
        backgroundColor: whiteColor,
        title: const Text(
          "Transfer",
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

      //BOTTOM NAV
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20,
        ),
        child: AppButton(
          text: _buttonText,
          onPress: () {
            onPayHandler();
          },
          isDisabled: _isloading,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(children: [
            const SizedBox(
              height: 0,
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 0,
                right: 0,
              ),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() => Column(children: [
                    Center(
                      child: Text(
                        nairaFormat.format(transferState
                                .transferToOtherBanksState.value.amount ??
                            0),
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 50),
                      child: SvgPicture.asset(
                        "assets/images/receiptDivider.svg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Bank",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                  transferState.transferToOtherBanksState.value
                                          .bankName ??
                                      "",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Account Number",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Text(
                                  transferState.transferToOtherBanksState.value
                                          .toAccountNo ??
                                      "",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Account Name",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Text(
                                  transferState.transferToOtherBanksState.value
                                          .receipientName ??
                                      "",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 40.0),
                                child: Text("Amount",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              Expanded(
                                child: Text(
                                    nairaFormat.format(transferState
                                            .transferToOtherBanksState
                                            .value
                                            .amount ??
                                        0),
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Charges",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Text("",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                  ])),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Save as beneficiary"),
                const SizedBox(
                  width: 30,
                ),
                AppSwitch(ontoggleChange: (value) {
                  print(value);
                }),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
