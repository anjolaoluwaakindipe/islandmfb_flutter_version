import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';

import '../components/shared/app_dropdown.dart';
import '../components/shared/app_textfield.dart';
import '../utilities/colors.dart';

class ProfileEmploymentDetailsPage extends StatefulWidget {
  const ProfileEmploymentDetailsPage({Key? key}) : super(key: key);

  @override
  _ProfileEmploymentDetailsPageState createState() =>
      _ProfileEmploymentDetailsPageState();
}

class _ProfileEmploymentDetailsPageState
    extends State<ProfileEmploymentDetailsPage> {
  final empStatusItems = ["Self Employed"];
  String? empStatusValue;
  final busTypeItems = ["Information Technology"];
  String? busTypeValue;
  final countryItems = ["Nigerian"];
  String? countryValue;
  final stateItems = [
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
  String? stateValue;
  final cityItems = ["Lagos"];
  String? cityValue;

  // textediting controllers
  TextEditingController empNameTextController = TextEditingController();
  TextEditingController empAddressTextController = TextEditingController();
  TextEditingController lastNameTextController = TextEditingController();
  TextEditingController phoneNumberTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  // drop down menu items builder
  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
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
          "Employment Details",
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
                requiredItems: empStatusItems,
                itemValue: empStatusValue,
                text: "Employment Status",
                hintText: "Select Employment Status"),
            const SizedBox(height: 0),
            AppTextField(
              textController: empNameTextController,
              textInputType: TextInputType.text,
              label: "Employers Name",
              labelColor: lightextColor,
              onChanged: (value) {},
            ),
            const SizedBox(height: 15),
            AppTextField(
              textController: empAddressTextController,
              textInputType: TextInputType.text,
              label: "Employers Address",
              labelColor: lightextColor,
              onChanged: (value) {},
            ),
            const SizedBox(height: 15),
            AppDropdown(
                text: "Country",
                hintText: "Select Country",
                requiredItems: countryItems,
                itemValue: countryValue),
            const SizedBox(height: 15),
            AppDropdown(
                text: "State",
                hintText: "Select State",
                requiredItems: stateItems,
                itemValue: stateValue),
            const SizedBox(height: 15),
            AppDropdown(
                text: "City",
                hintText: "Select City",
                requiredItems: cityItems,
                itemValue: cityValue),
            const SizedBox(height: 15),
            AppDropdown(
                text: "Business Type",
                hintText: "Select Business Type",
                requiredItems: busTypeItems,
                itemValue: busTypeValue),
            const SizedBox(height: 15),
            AppTextField(
              textController: phoneNumberTextController,
              textInputType: TextInputType.text,
              label: "Phone Number",
              labelColor: lightextColor,
              onChanged: (value) {},
            ),
            const SizedBox(height: 15),
            AppTextField(
              textController: emailTextController,
              textInputType: TextInputType.text,
              label: "Email",
              labelColor: lightextColor,
              onChanged: (value) {},
            ),
            const SizedBox(height: 15),
          ]),
        ),
      ),
    );
  }
}
