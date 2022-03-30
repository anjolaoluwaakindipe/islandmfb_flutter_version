import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';
import 'package:islandmfb_flutter_version/pages/choose_beneficiary.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/storage/dropdowns_build_menu_items.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class TransferToOtherBanksPage extends StatefulWidget {
  TransferToOtherBanksPage({Key? key}) : super(key: key);

  @override
  State<TransferToOtherBanksPage> createState() =>
      _TransferToOtherBanksPageState();
}

class _TransferToOtherBanksPageState extends State<TransferToOtherBanksPage> {
  final bankItems = ["UBA", "GTB", "Access Bank", "EcoBank"];
  String? bankValue;

  // text controller
  TextEditingController accountNumberTextController = TextEditingController();
  TextEditingController accountNameTextController = TextEditingController();
  TextEditingController amountTextController = TextEditingController();
  TextEditingController narrativeTextController = TextEditingController();
  TextEditingController pinTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPress: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                    enabled: true,
                    items: bankItems,
                    selectedItem: bankValue,
                    onChanged: (value) => setState(() {
                      bankValue = value;
                    }),
                    mode: Mode.BOTTOM_SHEET,
                    popupBackgroundColor: whiteColor,
                    popupElevation: 0,
                    showSearchBox: true,
                    maxHeight: MediaQuery.of(context).size.height / 2,
                    dropdownSearchDecoration: InputDecoration(
                      focusColor: accentColor,
                      fillColor: accentColor,
                      hintText: "Select A Bank",
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
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
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
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
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                textController: amountTextController,
                hint: "Input amount",
                label: "Amount",
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                textController: narrativeTextController,
                label: "Narrative",
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                textController: pinTextController,
                hint: "****",
                label: "Pin",
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
