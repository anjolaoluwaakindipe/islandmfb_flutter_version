import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islandmfb_flutter_version/components/shared/app_alert_dialogue.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';
import 'package:islandmfb_flutter_version/models/bank_info_model.dart';
import 'package:islandmfb_flutter_version/models/transfer.dart';
import 'package:islandmfb_flutter_version/pages/choose_beneficiary.dart';
import 'package:islandmfb_flutter_version/requests/transfer_request.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/state/transfer_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class TransferToOtherBanksPage extends StatefulWidget {
  TransferToOtherBanksPage({Key? key}) : super(key: key);

  @override
  State<TransferToOtherBanksPage> createState() =>
      _TransferToOtherBanksPageState();
}

class _TransferToOtherBanksPageState extends State<TransferToOtherBanksPage> {
  // Global keys
  GlobalKey<FormState> transferToOtherBanksFormKey = GlobalKey<FormState>();

  // bank list dropdown variables
  List<BankInfo> bankItems = [];
  BankInfo? bankValue;
  bool loadingBanks = true;
  bool loadingBankError = false;

  // State
  final transferState = Get.put(TransferStateController());

  // text controllers
  TextEditingController accountNumberTextController = TextEditingController();
  TextEditingController accountNameTextController = TextEditingController();
  TextEditingController amountTextController = TextEditingController();
  TextEditingController narrativeTextController = TextEditingController();
  TextEditingController pinTextController = TextEditingController();

  // on submission of details
  Future onVerifyButtonHandler() async {
    if (transferToOtherBanksFormKey.currentState!.validate()) {
      transferState.setAmountNarrationPinField(TransferType.toOwnAccount,
          amount: double.parse(amountTextController.text.replaceAll(",", "")),
          narration: narrativeTextController.text,
          pin: pinTextController.text);

      // Get.to(OwnAccountTransferVerificationPage());
    }
  }

  // control button state
  bool _isButtonDisabled = true;
  void buttonStateHandler() {
    if (accountNumberTextController.text.length != 10 ||
        accountNameTextController.text.length < 3 ||
        accountNameTextController.text == "Invalid Account Number" ||
        amountTextController.text.length < 2 ||
        narrativeTextController.text.isEmpty ||
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

  // amount validation
  String? amountChecker(String? fieldContent) {
    double amount = double.parse(amountTextController.text.replaceAll(",", ""));
    String? accountNo =
        transferState.transferToOwnAccountState.value.fromAccountNo;
    double? availableBalance = Get.put(AccountStateController())
        .customerAccounts
        .firstWhere(
            (account) => account.primaryAccountNo!["_number"] == accountNo!)
        .availableBalance;
    if (accountNo != null &&
        availableBalance != null &&
        amount > availableBalance) {
      return "Balance exceeded!";
    }
    return null;
  }

  // initialize the list of banks
  initializeBankList() async {
    try {
      var bankInfoResponse = await getAllBanks();
      if (bankInfoResponse.status.code == HttpStatus.ok) {
        setState(() {
          bankItems = bankInfoResponse.data;
        });
      }
    } catch (e) {
      setState(() {
        loadingBankError = true;
      });
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AppAlertDialogue(
              actions: [
                TextButton(
                  child: const Text(
                    'Close',
                    style: TextStyle(backgroundColor: primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
              content: "Could not load data please try again",
              title: "Error while loading data",
            );
          });
    }
    setState(() {
      loadingBanks = false;
    });
  }

  // get Account name of beneficiary
  getAccountName() async {
    try {
      if (accountNumberTextController.text.length == 10 && bankValue != null) {
        var accountNameResponse = await getOtherBankRecipientAccountName(
            bankCode: bankValue!.code,
            accountNumber: accountNumberTextController.text);

        print(accountNameResponse.data);
        if (accountNameResponse.status.code == HttpStatus.ok) {
          accountNameTextController.text =
              accountNameResponse.data ?? "Invalid Account Number";
        }
      } else {
        accountNameTextController.text = "";
      }
    } catch (e) {}
  }

  // onMount
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeBankList();
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
        backgroundColor: whiteColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 20,
          ),
          child: AppButton(
            text: "Verify",
            isDisabled: _isButtonDisabled,
            onPress: () {},
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: transferToOtherBanksFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("Bank",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          )),
                      RichText(
                          text: TextSpan(
                              text: "Find Beneficiary",
                              style: GoogleFonts.poppins(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(ChooseBeneficiary());
                                }))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(10)),
                    height: 70,
                    child: Center(
                      child: DropdownSearch<String>(
                        enabled: !loadingBanks,
                        items: bankItems.map((item) => item.name).toList(),
                        selectedItem:
                            bankValue != null ? bankValue?.name : null,
                        onChanged: (value) {
                          buttonStateHandler();
                          getAccountName();
                          setState(() {
                            bankValue = bankItems
                                .where((element) => element.name == value)
                                .first;
                          });
                        },
                        mode: Mode.BOTTOM_SHEET,
                        popupBackgroundColor: whiteColor,
                        popupElevation: 0,
                        showSearchBox: true,
                        maxHeight: MediaQuery.of(context).size.height / 2,
                        dropdownSearchDecoration: InputDecoration(
                          iconColor: loadingBankError && loadingBanks
                              ? Colors.transparent
                              : null,
                          focusColor: accentColor,
                          fillColor: accentColor,
                          hintText: loadingBanks
                              ? "Getting Banks..."
                              : (loadingBankError
                                  ? "Error while loading banks"
                                  : "Select A Bank"),
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 12, 0, 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    textController: accountNumberTextController,
                    hint: "Input account number",
                    label: "Account Number",
                    maxCharacterLength: 10,
                    onChanged: (String value) {
                      buttonStateHandler();
                      getAccountName();
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    textController: accountNameTextController,
                    hint: "...",
                    label: "Account Name",
                    readOnly: true,
                    onChanged: (String value) {
                      buttonStateHandler();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    textController: amountTextController,
                    hint: "Input amount",
                    label: "Amount",
                    onChanged: (String value) {
                      buttonStateHandler();
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    textController: narrativeTextController,
                    label: "Narrative",
                    onChanged: (String value) {
                      buttonStateHandler();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    textController: pinTextController,
                    hint: "****",
                    label: "Pin",
                    onChanged: (String value) {
                      buttonStateHandler();
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
