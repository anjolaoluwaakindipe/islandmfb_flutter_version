import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';
import 'package:islandmfb_flutter_version/pages/airtime_verification.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/state/airtime_state_controller.dart';
import 'package:islandmfb_flutter_version/storage/dropdowns_build_menu_items.dart';
import 'package:islandmfb_flutter_version/textValidations/is_below_balance.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class AirtimePage extends StatefulWidget {
  const AirtimePage({Key? key}) : super(key: key);

  @override
  State<AirtimePage> createState() => _AirtimePageState();
}

class _AirtimePageState extends State<AirtimePage> {
  // DropDown variables
  final billerItems = ["Glo", "MTN", "Airtel", "Vodacom"];
  String? billerValue;
  final productItems = ["VTU"];
  String? productValue;

  // button state
  bool isButtonDisabled = true;

  // textediting controllers
  TextEditingController amountTextController = TextEditingController();
  TextEditingController mobileNumberTextController = TextEditingController();
  TextEditingController narrationTextController = TextEditingController();
  TextEditingController pinTextController = TextEditingController();

  // state controllers
  AirtimeStateController airtimeState = Get.put(AirtimeStateController());

  // disables button if fields are empty
  unDisableButton() {
    if (billerValue == null ||
        productValue == null ||
        amountTextController.text.isEmpty ||
        mobileNumberTextController.text.isEmpty ||
        narrationTextController.text.isEmpty ||
        pinTextController.text.isEmpty ||
        pinTextController.text.length < 4 ||
        mobileNumberTextController.text.length < 11) {
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  // form key state
  final GlobalKey<FormState> _airtimeFormKey = GlobalKey<FormState>();

  // function for the verification button
  void onVerifyHnadler() {
    if (_airtimeFormKey.currentState!.validate()) {
      airtimeState.setAirtimeState(
        amount: double.parse(amountTextController.text),
        biller: billerValue,
        product: productValue,
        narration: narrationTextController.text,
        mobileNumber: "+234" + mobileNumberTextController.text,
      );

      Get.to(const AirtimeVerificationPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            onPressed: () {
              Get.to(const HomePage());
            },
            icon: SvgPicture.asset(
              "assets/images/back.svg",
              height: 20,
            ),
          ),
        ),
        backgroundColor: whiteColor,
        title: const Text(
          "Airtime",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Biller",
                style: TextStyle(
                    fontSize: 15,
                    color: lightextColor,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  items: billerItems.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => billerValue = value),
                  hint: const Text("Select biller"),
                  isExpanded: true,
                  value: billerValue,
                  buttonHeight: 70,
                  focusColor: accentColor,
                  buttonPadding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
                  dropdownElevation: 0,
                  offset: const Offset(0, -4),
                  buttonDecoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  dropdownDecoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              billerValue != null
                  ? const Text(
                      "Product",
                      style: TextStyle(
                        fontSize: 15,
                        color: lightextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10),
              billerValue != null
                  ? DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        items: productItems.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => productValue = value),
                        hint: const Text("Select product"),
                        isExpanded: true,
                        value: productValue,
                        focusColor: accentColor,
                        buttonHeight: 70,
                        buttonPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 4),
                        dropdownElevation: 0,
                        offset: const Offset(0, -4),
                        buttonDecoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        dropdownDecoration: BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  : Container(),
              productValue != null
                  ? Form(
                      key: _airtimeFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          AppTextField(
                            textController: amountTextController,
                            prefixIcon: SizedBox(
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/naira.svg",
                                  color: primaryColor,
                                  height: 20,
                                ),
                              ),
                              width: 50,
                            ),
                            label: "Amount",
                            labelColor: lightextColor,
                            hint: "Input Amount...",
                            textInputType:
                                const TextInputType.numberWithOptions(
                                    decimal: true, signed: false),
                            inputFormatters: [
                              CurrencyTextInputFormatter(symbol: "")
                            ],
                            onChanged: (String value) {
                              unDisableButton();
                            },
                            validator: (fieldContent) =>
                              isBelowBalance(
                                  fieldContent, amountTextController)
                            ,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AppTextField(
                            prefixIcon: const SizedBox(
                              child:  Center(
                                child: Text("+234", style:TextStyle(color: lightextColor, fontWeight: FontWeight.w900))
                              ),
                              width: 50,
                            ),
                            textController: mobileNumberTextController,
                            label: "Mobile Number",
                            labelColor: lightextColor,
                            textInputType:
                                const TextInputType.numberWithOptions(
                                    decimal: false, signed: false),
                            onChanged: (value) {
                              unDisableButton();
                            },
                            validator: ValidationBuilder()
                                .phone()
                                .minLength(11)
                                .build(),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(10)
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AppTextField(
                            textController: narrationTextController,
                            label: "Narration",
                            labelColor: lightextColor,
                            onChanged: (value) {
                              unDisableButton();
                            },
                            validator:
                                ValidationBuilder().maxLength(50).build(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AppTextField(
                            textController: pinTextController,
                            label: "Pin",
                            labelColor: lightextColor,
                            textInputType: TextInputType.number,
                            hideText: true,
                            onChanged: (value) {
                              unDisableButton();
                            },
                            suffixIconWidget: null,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              LengthLimitingTextInputFormatter(4)
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20,
        ),
        child: AppButton(
          text: "Verify",
          onPress: () {
            onVerifyHnadler();
          },
          isDisabled: isButtonDisabled,
        ),
      ),
    );
  }
}
