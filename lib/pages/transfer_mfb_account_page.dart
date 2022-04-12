import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/pages/choose_beneficiary.dart';

import '../components/shared/app_button.dart';
import '../components/shared/app_textfield.dart';
import '../utilities/colors.dart';
import 'home_page.dart';

class MfbAccountTransferPage extends StatefulWidget {
  const MfbAccountTransferPage({Key? key}) : super(key: key);

  @override
  _MfbAccountTransferPageState createState() => _MfbAccountTransferPageState();
}

class _MfbAccountTransferPageState extends State<MfbAccountTransferPage> {
  bool _isButtonDisabled = true;

  final amountText = TextEditingController();
  final narrationText = TextEditingController();
  final pinText = TextEditingController();
  final accountNameText = TextEditingController();
  final accountNumberText = TextEditingController();

  void buttonValidationCheck() {
    if (accountNumberText.text.length < 10 ||
        accountNameText.text.length < 3 ||
        amountText.text.length < 2 ||
        pinText.text.length < 4) {
      setState(() {
        _isButtonDisabled = true;
      });
    } else {
      setState(() {
        _isButtonDisabled = false;
      });
    }
  }

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
              onPressed: () {
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
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(children: [
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
                    Get.to(ChooseBeneficiary());
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
            AppTextField(
              textController: accountNumberText,
              hint: "Input account Number",
              onChanged: (text) {
                buttonValidationCheck();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
              textController: accountNameText,
              label: "Account Name",
              hint: "Account name",
              onChanged: (text) {
                buttonValidationCheck();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
              hint: "Input Amount",
              textController: amountText,
              label: "Amount",
              onChanged: (text) {
                buttonValidationCheck();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
              textController: narrationText,
              label: "Narration",
              onChanged: (text) {
                buttonValidationCheck();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
              textController: pinText,
              label: "Pin",
              onChanged: (text) {
                buttonValidationCheck();
              },
            )
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: AppButton(
          text: "Verify",
          onPress: () {},
          isDisabled: _isButtonDisabled,
        ),
      ),
    );
  }
}
