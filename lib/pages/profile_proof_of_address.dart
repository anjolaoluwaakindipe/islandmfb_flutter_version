import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';

import '../components/shared/app_button.dart';
import '../components/shared/app_textfield.dart';
import '../utilities/colors.dart';

class ProfileProofOfAddressPage extends StatefulWidget {
  const ProfileProofOfAddressPage({Key? key}) : super(key: key);

  @override
  _ProfileProofOfAddressPageState createState() =>
      _ProfileProofOfAddressPageState();
}

class _ProfileProofOfAddressPageState extends State<ProfileProofOfAddressPage> {
  final proofOfAddressItems = [
    "Valid Drivers license",
    "Utility Bill",
    "Insurance Card",
    "Voter's Registration Card",
    "College Enrollment Papers",
    "Property Tax Receipt",
    "Lease Agreement or Mortgage Statement"
  ];
  String? proofOfAddressValue;

  // button state
  bool isButtonDisabled = true;

  // drop down menu items builder
  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      child: Text(item),
      value: item,
    );
  }

  unDisableButton() {
    if (proofOfAddressValue == null) {
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
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/images/back.svg",
              height: 20,
            ),
          ),
        ),
        backgroundColor: whiteColor,
        title: const Text(
          "Proof of Address",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
        foregroundColor: blackColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: GFButton(
              text: "Save",
              onPressed: () {},
              size: 1,
              hoverColor: accentColor,
              focusColor: accentColor,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: blackColor,
              ),
              color: Colors.transparent,
            ),
          ),
        ],
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
                "Proof of Address",
                style: TextStyle(
                    fontSize: 17,
                    color: lightextColor,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  items: proofOfAddressItems.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() => proofOfAddressValue = value);
                    unDisableButton();
                  },
                  hint: const Text("Select Proof of Address"),
                  isExpanded: true,
                  value: proofOfAddressValue,
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
              const SizedBox(height: 20),
              AppButton(
                iconic: Icons.upload,
                text: "Upload",
                onPress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
