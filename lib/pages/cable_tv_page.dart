import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../components/shared/app_button.dart';
import '../components/shared/app_textfield.dart';
import '../utilities/colors.dart';

class CableTvPage extends StatefulWidget {
  const CableTvPage({Key? key}) : super(key: key);

  @override
  _CableTvPageState createState() => _CableTvPageState();
}

class _CableTvPageState extends State<CableTvPage> {
  final billerItems = [
    "GOtv",
    "Iroko Tv",
    "DStv Subscription",
    "Cable Africa Network TV(CanTv)"
  ];
  String? billerValue;
  final productItems = [
    "GOtv Smallie (Monthly) (800 NGN)",
    "GOtv Smallie (Yearly) (2000 NGN)",
    "Jolli (2,490 NGN)",
    "Max (3,600 NGN)"
  ];
  String? productValue;

  // button state
  bool isButtonDisabled = true;

  // textediting controllers
  TextEditingController amountTextController = TextEditingController();
  TextEditingController customerUniqueTextController = TextEditingController();
  TextEditingController mobileNumberTextController = TextEditingController();

  // drop down menu items builder
  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }

  unDisableButton() {
    if (billerValue == null ||
        productValue == null ||
        amountTextController.text.isEmpty ||
        customerUniqueTextController.text.isEmpty ||
        mobileNumberTextController.text.isEmpty ||
        mobileNumberTextController.text.length < 4) {
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      setState(() {
        isButtonDisabled = false;
      });
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
          "Cable Tv",
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
                    fontSize: 17,
                    color: lightextColor,
                    fontWeight: FontWeight.w500),
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
                        fontSize: 17,
                        color: lightextColor,
                        fontWeight: FontWeight.w500,
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
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        AppTextField(
                          textController: amountTextController,
                          label: "Amount",
                          labelColor: lightextColor,
                          textInputType: TextInputType.number,
                          onChanged: (value) {
                            unDisableButton();
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AppTextField(
                          textController: customerUniqueTextController,
                          label: "Customer's Unique Number",
                          labelColor: lightextColor,
                          textInputType: TextInputType.phone,
                          onChanged: (value) {
                            unDisableButton();
                          },
                        ),
                        AppTextField(
                          textController: mobileNumberTextController,
                          label: "Phone Number",
                          labelColor: lightextColor,
                          onChanged: (value) {
                            unDisableButton();
                          },
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
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
          text: "Continue",
          onPress: () {},
          isDisabled: isButtonDisabled,
        ),
      ),
    );
  }
}
