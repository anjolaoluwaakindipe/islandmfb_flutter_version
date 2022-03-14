import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../components/shared/app_dropdown.dart';
import '../components/shared/app_textfield.dart';
import '../utilities/colors.dart';

class ProfilePersonalInformationPage extends StatefulWidget {
  const ProfilePersonalInformationPage({Key? key}) : super(key: key);

  @override
  _ProfilePersonalInformationPageState createState() =>
      _ProfilePersonalInformationPageState();
}

class _ProfilePersonalInformationPageState
    extends State<ProfilePersonalInformationPage> {
  final titleItems = ["Mr", "Mrs", "***"];
  String? titleValue;
  final genderItems = [
    "Male",
    "Female",
  ];
  String? genderValue;
  final maritalItems = ["Single", "Married"];
  String? maritalValue;
  final nationality = ["Nigerian"];
  String? nationalityValue;
  final stateOfOriginItems = [
    "Abia",
    "Adamawa",
    "Akwa Ibom",
    "Anambra",
    "Bauchi",
    "Bayelsa",
    "Benue",
    "Borno",
    "Cross River",
    "Delta",
    "Ebonyi",
    "Edo",
    "Ekiti",
    "Enugu",
    "Gombe",
    "Imo",
    "Jigawa",
    "Kaduna",
    "Kano",
    "Katsina",
    "Kebbi",
    "Kogi",
    "Kwara",
    "Lagos",
    "Nasarawa",
    "Niger",
    "Ogun",
    "Ondo",
    "Osun",
    "Oyo",
    "Plateau",
    "Rivers",
    "Sokoto",
    "Taraba",
    "Yobe",
    "Zamfara",
    "Abuja (FCT)"
  ];
  String? stateOfOriginValue;
  final lgaItems = ["Lagelu"];
  String? lgaValue;

  // button state
  bool isButtonDisabled = true;

  // textediting controllers
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController middleNameTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController dateOfBirthTextController = TextEditingController();
  TextEditingController mothersMaidenNameTextController =
      TextEditingController();
  TextEditingController taxIdentificationNumberTextController =
      TextEditingController();

  // drop down menu items builder
  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      child: Text(item),
      value: item,
    );
  }

  unDisableButton() {
    if (titleValue == null ||
        firstNameTextController.text.isEmpty ||
        middleNameTextController.text.isEmpty ||
        lastNameTextController.text.isEmpty ||
        genderValue == null ||
        maritalValue == null ||
        dateOfBirthTextController.text.isEmpty ||
        mothersMaidenNameTextController.text.isEmpty ||
        nationalityValue == null ||
        stateOfOriginValue == null ||
        lgaValue == null ||
        taxIdentificationNumberTextController.text.isEmpty ||
        taxIdentificationNumberTextController.text.length < 4) {
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
          "Personal Information",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
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
              ),
              color: Colors.transparent,
            ),
          ),
        ],
        toolbarHeight: 80,
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppDropdown(
                requiredItems: titleItems,
                itemValue: titleValue,
                text: "Title",
                hintText: "Select Title"),
            const SizedBox(height: 0),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "First Name",
                style: TextStyle(
                  fontSize: 17,
                  color: lightextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextField(
                textController: firstNameTextController,
                textInputType: TextInputType.text,
                onChanged: (value) {
                  unDisableButton();
                },
              ),
              const SizedBox(height: 15),
              const Text(
                "Middle Name",
                style: TextStyle(
                  fontSize: 17,
                  color: lightextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextField(
                textController: middleNameTextController,
                textInputType: TextInputType.text,
                onChanged: (value) {
                  unDisableButton();
                },
              ),
              const SizedBox(height: 15),
              const Text(
                "Last Name",
                style: TextStyle(
                  fontSize: 17,
                  color: lightextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextField(
                textController: lastNameTextController,
                textInputType: TextInputType.text,
                onChanged: (value) {
                  unDisableButton();
                },
              ),
            ]),
            const SizedBox(height: 15),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AppDropdown(
                  text: "Gender",
                  hintText: "Select Gender",
                  requiredItems: genderItems,
                  itemValue: genderValue),
              const SizedBox(height: 15),
              AppDropdown(
                  text: "Marital Status",
                  hintText: "Select status",
                  requiredItems: maritalItems,
                  itemValue: maritalValue),
              const SizedBox(height: 15),
              const Text(
                "Date of Birth",
                style: TextStyle(
                  fontSize: 17,
                  color: lightextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextField(
                textController: dateOfBirthTextController,
                textInputType: TextInputType.datetime,
                onChanged: (value) {
                  unDisableButton();
                },
              ),
              const SizedBox(height: 15),
              const Text(
                "Mothers maiden name",
                style: TextStyle(
                  fontSize: 17,
                  color: lightextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextField(
                textController: mothersMaidenNameTextController,
                textInputType: TextInputType.text,
                onChanged: (value) {
                  unDisableButton();
                },
              ),
              const SizedBox(height: 15),
              AppDropdown(
                  text: "Nationality",
                  hintText: "Select Country",
                  requiredItems: nationality,
                  itemValue: nationalityValue),
              const SizedBox(height: 15),
              AppDropdown(
                  text: "State of Origin",
                  hintText: "Select State",
                  requiredItems: stateOfOriginItems,
                  itemValue: stateOfOriginValue),
              const SizedBox(height: 15),
              AppDropdown(
                  text: "LGA",
                  hintText: "Select local government area",
                  requiredItems: lgaItems,
                  itemValue: lgaValue),
              const SizedBox(height: 15),
              const Text(
                "Tax Identification Number",
                style: TextStyle(
                  fontSize: 17,
                  color: lightextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppTextField(
                textController: taxIdentificationNumberTextController,
                textInputType: TextInputType.number,
                onChanged: (value) {
                  unDisableButton();
                },
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
