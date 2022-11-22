
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/components/shared/app_alert_dialogue.dart';
import 'package:islandmfb_flutter_version/models/transfer.dart';
import 'package:islandmfb_flutter_version/pages/choose_beneficiary.dart';
import 'package:islandmfb_flutter_version/pages/mfb_account_transfer_verification_page.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/state/transfer_state_controller.dart';
import 'package:islandmfb_flutter_version/textValidations/is_below_balance.dart';

import '../components/shared/app_button.dart';
import '../components/shared/app_textfield.dart';
import '../utilities/colors.dart';

class MfbAccountTransferPage extends StatefulWidget {
  const MfbAccountTransferPage({Key? key}) : super(key: key);

  @override
  _MfbAccountTransferPageState createState() => _MfbAccountTransferPageState();
}

class _MfbAccountTransferPageState extends State<MfbAccountTransferPage> {
  String accountNameDisplay = "...";

  // Text controllers
  final amountTextController = TextEditingController();
  final narrationTextController = TextEditingController();
  final pinTextController = TextEditingController();
  final accountNameTextController = TextEditingController();
  final accountNumberTextController = TextEditingController();

  // Form key
  final GlobalKey<FormState> mfbTransferPageFormKey = GlobalKey<FormState>();

  // State
  final transferState = Get.put(TransferStateController());

  getRecipientName(String accountNo) async {
    if (accountNumberTextController.text.isBlank!) return;

    accountNameTextController.text = "";
    setState(() {
      accountNameDisplay = "...";
    });
    String? recipientName = await transferState.loadRecipientName(
        TransferType.toMFBAccount, accountNo);

    if (recipientName != "" && recipientName != null) {
      print(recipientName);
      accountNameTextController.text = recipientName;
    } else {
      setState(() {
        accountNameDisplay = "Could not get recipient!";
      });
    }
  }

  // Verify button state handlers
  bool _isButtonDisabled = true;
  void buttonStateHandler() {
    if (accountNumberTextController.text.isEmpty ||
        accountNameTextController.text == "" ||
        amountTextController.text.length < 2 ||
        narrationTextController.text.isEmpty ||
        pinTextController.text.length < 4) {
      setState(() {
        _isButtonDisabled = true;
      });
    } else {
      setState(() {
        _isButtonDisabled = false;
      });
    }
  }

  bool _isLoading = false;
  String _buttonText = "Verify";

  void onVerifyHandler(BuildContext context) async {
    if (mfbTransferPageFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _buttonText = "Loading...";
      });

      // _isLoading.refresh();
      // _buttonText.refresh();
      await transferState.loadRecipientName(
          TransferType.toMFBAccount, accountNumberTextController.text);

      if (transferState.transferToMFBAccountState.value.receipientName !=
          null) {
        transferState.transferToMFBAccountState.value.narration =
            narrationTextController.text;
        transferState.transferToMFBAccountState.value.toAccountNo =
            accountNumberTextController.text;
        transferState.transferToMFBAccountState.value.amount =
            double.parse(amountTextController.text.replaceAll(",", ""));

        await Get.to(const MfbAccountTransferVerificationPage());
      } else {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AppAlertDialogue(
                content: "Invalid Account Number",
                contentColor: primaryColor,
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
      setState(() {
        _isLoading = false;
        _buttonText = "Verify";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    transferState.transferToMFBAccountState.value.fromAccountNo =
        Get.put(AccountStateController())
            .selectedAccount
            .value
            .primaryAccountNo!["_number"];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        // APPBAR
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          leading: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: IconButton(
                onPressed: () {
                  transferState.clearTransferState(TransferType.toMFBAccount);
                  Get.back();
                },
                icon: SvgPicture.asset(
                  "assets/images/back.svg",
                  height: 20,
                ),
              ),
            ),
          ),
          title: const Text(
            "Transfer",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: blackColor,
            ),
          ),
          centerTitle: true,
          toolbarHeight: 80,
        ),

        // BODY BACKGROUND COLOR
        backgroundColor: whiteColor,

        // BODY
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: mfbTransferPageFormKey,
              child: Column(children: [
                // ACCOUNT NUMBER HEADER WITH FIND BENEFICIARY BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Account Number",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(const ChooseBeneficiary());
                      },

                      child: const Text(
                        "Find Beneficiary",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // onTap: () {},
                    )
                  ],
                ),
                const SizedBox(height: 10),

                // ACCOUNT NUMBER TEXTFIELD
                AppTextField(
                  textController: accountNumberTextController,
                  hint: "Input account Number",
                  onChanged: (text) {
                    getRecipientName(text);
                    buttonStateHandler();
                  },
                  textInputType: const TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                // STATEFUL ACCOUNT NAME TEXTFIELD
                AppTextField(
                  textController: accountNameTextController,
                  label: "Account Name",
                  readOnly: true,
                  hint: accountNameDisplay,
                  onChanged: (text) {
                    buttonStateHandler();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                // AMOUNT TEXTFIELD
                AppTextField(
                  textController: amountTextController,
                  prefixIcon: SizedBox(
                    width: 50,
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/naira.svg",
                        color: primaryColor,
                        height: 20,
                      ),
                    ),
                  ),
                  label: "Amount",
                  hint: "Input Amount...",
                  textInputType: const TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  inputFormatters: [
                    CurrencyTextInputFormatter(symbol: "", decimalDigits: 2)
                  ],
                  onChanged: (String value) {
                    buttonStateHandler();
                  },
                  validator: (fieldContent) =>
                      isBelowBalance(fieldContent, amountTextController),
                ),
                const SizedBox(
                  height: 20,
                ),

                // NARRATION TEXT FIELD
                AppTextField(
                  textController: narrationTextController,
                  label: "Narration",
                  onChanged: (text) {
                    buttonStateHandler();
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                // PIN TEXT FIELD
                AppTextField(
                  textController: pinTextController,
                  label: "Pin",
                  onChanged: (text) {
                    buttonStateHandler();
                  },
                  hideText: true,
                  hint: "****",
                  textInputType: const TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4)
                  ],
                )
              ]),
            ),
          ),
        ),

        // BOTTOM BUTTON
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
          child: AppButton(
            text: _buttonText,
            onPress: () {
              onVerifyHandler(context);
            },
            isDisabled: _isLoading || _isButtonDisabled,
          ),
        ),
      ),
    );
  }
}
