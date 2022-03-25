import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_customer_accounts_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class OwnAccountTransferPage extends StatefulWidget {
  OwnAccountTransferPage({Key? key}) : super(key: key);

  @override
  State<OwnAccountTransferPage> createState() => _OwnAccountTransferPageState();
}

class _OwnAccountTransferPageState extends State<OwnAccountTransferPage> {
  // Text Controllers
  TextEditingController amountTextController = TextEditingController();
  TextEditingController narrationTextController = TextEditingController();
  TextEditingController pinTextController = TextEditingController();

  // Account Value
  String? fromAccountNo;
  String? toAccountNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
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

      // BODY BACKGROUND COLOR
      backgroundColor: whiteColor,

      // BOTTOM BUTTON
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20,
        ),
        child: AppButton(
          text: "Verify",
          onPress: () {},
        ),
      ),

      // APP BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "From",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      context: context,
                      builder: (BuildContext context) {
                        return OwnAccountPageBottomSheet(
                          selectionType: SelectionType.from,
                        );
                      });
                },
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Select Account",
                              style: TextStyle(
                                  color: lightextColor, fontSize: 16)),
                          Icon(
                            Icons.arrow_drop_down,
                            color: greyColor,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "To",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      context: context,
                      builder: (BuildContext context) {
                        return OwnAccountPageBottomSheet(
                          selectionType: SelectionType.to,
                        );
                      });
                },
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Select Account",
                              style: TextStyle(
                                  color: lightextColor, fontSize: 16)),
                          Icon(
                            Icons.arrow_drop_down,
                            color: greyColor,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AppTextField(
                textController: amountTextController,
                label: "Amount",
                hint: "Input Amount...",
                textInputType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                textController: narrationTextController,
                label: "Narration",
                hint: "Give a narration...",
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                textController: pinTextController,
                label: "Pin",
                hint: "****",
                hideText: true,
                textInputType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum SelectionType { to, from }

class OwnAccountPageBottomSheet extends StatelessWidget {
  OwnAccountPageBottomSheet({Key? key, required this.selectionType})
      : super(key: key);

  final nairaFormat = NumberFormat.currency(name: "N  ");
  SelectionType selectionType;
  final accountState = Get.put(AccountStateController());

  @override
  Widget build(BuildContext context) {
    final customerAccounts = accountState.customerAccounts;
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
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return AppCustomerAccountButtons(
                        nairaFormat: nairaFormat,
                        accountNo:
                            customerAccounts[index].primaryAccountNo["_number"],
                        accountBalance:
                            customerAccounts[index].availableBalance,
                        onClick: () {
                          Navigator.pop(context);
                          if (selectionType == SelectionType.to) {}
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: customerAccounts.length)
              ]),
        ),
      ),
    );
  }
}
