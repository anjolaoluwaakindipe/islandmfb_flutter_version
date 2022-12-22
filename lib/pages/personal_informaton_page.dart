import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_gesture_detector.dart';
import 'package:islandmfb_flutter_version/pages/account_type_page.dart';
import 'package:islandmfb_flutter_version/pages/navigation.dart';
import 'package:islandmfb_flutter_version/state/signup_state_controller.dart';
import 'package:islandmfb_flutter_version/storage/dropdowns_build_menu_items.dart';

import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

import '../components/shared/app_textfield.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  // TextField controllers

  TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController middleNameTextEditingController =
      TextEditingController();

  // state controllers
  final CreateAccountFormController _createAccountFormController =
      Get.put(CreateAccountFormController());

  // Form key
  GlobalKey<FormState> personalInformationFormKey = GlobalKey<FormState>();

  // gender dropdown variables
  List<String> genderItems = ["Male", "Female"];
  String? genderValue;

  DateTime? dateOfBirth;

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 150),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor, // header background color
              onPrimary: whiteColor, // header text color
              onSurface: lightextColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null) {
      setState(() {
        dateOfBirth = selected;
      });
    }
    buttonStateHandler();
  }

  bool isButtonDisabled = true;

  void buttonStateHandler() {
    setState(() {
      if (firstNameTextController.text.isEmpty ||
          lastNameTextEditingController.text.isEmpty ||
          emailTextEditingController.text.isEmpty ||
          genderValue == null ||
          dateOfBirth == null) {
        isButtonDisabled = true;
      } else {
        isButtonDisabled = false;
      }
    });
  }

  void onContinue() {
    if (personalInformationFormKey.currentState!.validate()) {
      _createAccountFormController.setPersonalInfo(
          firstNameTextController.text,
          lastNameTextEditingController.text,
          middleNameTextEditingController.text,
          genderValue!,
          dateOfBirth!);
      Get.toNamed(AppRoutes.accountTypePage);
    }
  }

  @override
  void initState() {
    super.initState();
    emailTextEditingController.text = _createAccountFormController.getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return AppGestureDetector(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 80,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: AppButton(
            text: "Continue",
            onPress: onContinue,
            isDisabled: isButtonDisabled,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: personalInformationFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 1,
                  ),
                  const Text(
                    "Personal Information",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      "Create an account by providing the details needed below.",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // FirstName field
                  AppTextField(
                    hint: "Enter your first name",
                    label: "First Name",
                    textController: firstNameTextController,
                    onChanged: (value) {
                      buttonStateHandler();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Last Name field
                  AppTextField(
                    hint: "Enter your last name",
                    label: "Last Name",
                    textController: lastNameTextEditingController,
                    onChanged: (value) {
                      buttonStateHandler();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Middle Name field
                  AppTextField(
                    hint: "Enter your middle name",
                    label: "Middle Name",
                    textController: middleNameTextEditingController,
                    onChanged: (value) {
                      buttonStateHandler();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Email Address field
                  AppTextField(
                    hint: "Enter your email adddress",
                    label: "Email Address",
                    readOnly: true,
                    textController: emailTextEditingController,
                    onChanged: (value) {
                      buttonStateHandler();
                    },
                    validator: ValidationBuilder().email().build(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Gender Select Field
                  const Text(
                    "Gender",
                    style: TextStyle(
                        fontSize: 15,
                        color: blackColor,
                        fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      items: genderItems.map(buildMenuItem).toList(),
                      onChanged: (value) {
                        setState(() => genderValue = value);
                        buttonStateHandler();
                      },
                      hint: const Text("Select your Gender"),
                      isExpanded: true,
                      value: genderValue,
                      buttonHeight: 60,
                      focusColor: accentColor,
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Date of Birth Select field
                  const Text(
                    "Date of Birth",
                    style: TextStyle(
                        fontSize: 15,
                        color: blackColor,
                        fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      height: 70,
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  dateOfBirth != null
                                      ? DateFormat("dd/MM/yyyy")
                                          .format(dateOfBirth!)
                                      : "dd/mm/yy",
                                  style: const TextStyle(color: lightextColor)),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: greyColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: whiteColor,
      ),
    );
  }
}
