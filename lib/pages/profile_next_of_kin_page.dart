import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import '../components/shared/app_dropdown.dart';
import '../components/shared/app_textfield.dart';
import '../utilities/colors.dart';

class ProfileNextOfKinPage extends StatefulWidget {
  const ProfileNextOfKinPage({Key? key}) : super(key: key);

  @override
  _ProfileNextOfKinPageState createState() => _ProfileNextOfKinPageState();
}

class _ProfileNextOfKinPageState extends State<ProfileNextOfKinPage> {
  

  final relationshipItems = ["Father", "Mother", "Son", "Daughter", "Cousin", "Guardian"];
  String? relationshipValue;
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

  // textediting controllers
  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController middleNameTextController = TextEditingController();
  TextEditingController surNameTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  TextEditingController phoneNumberTextController =
      TextEditingController();

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
          "Next of kin information",
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
              AppTextField(
                textController: surNameTextController,
                textInputType: TextInputType.text,
                label: "Surname",
                labelColor: lightextColor,
                onChanged: (value) {
                },
              ),
              const SizedBox(height: 15),
              AppTextField(
                textController: firstNameTextController,
                textInputType: TextInputType.text,
                label: "First Name",
                labelColor: lightextColor,
                onChanged: (value) {
                },
              ),
              const SizedBox(height: 15),
              AppTextField(
                textController: middleNameTextController,
                textInputType: TextInputType.text,
                label: "Middle Name",
                labelColor: lightextColor,
                onChanged: (value) {
                },
              ),
              const SizedBox(height: 15),
              AppTextField(
                textController: addressTextController,
                textInputType: TextInputType.text,
                label: "Address",
                labelColor: lightextColor,
                onChanged: (value) {
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
              AppTextField(
                textController: phoneNumberTextController,
                textInputType: TextInputType.number,
                label: "Phone Number",
                labelColor: lightextColor,
                onChanged: (value) {
                },
              ),
              const SizedBox(height: 15),
              AppDropdown(
                  text: "Relationship",
                  hintText: "Select Relationship",
                  requiredItems: relationshipItems,
                  itemValue: relationshipValue),
              const SizedBox(height: 15),
            ]),
        ),
      ),
    );
  }
}
