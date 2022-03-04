import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/account_type_page.dart';
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

  // gender dropdown variables
  List<String> genderItems = ["Male", "Female"];
  String? genderValue;

  DateTime? selectedDate;

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
            colorScheme: ColorScheme.light(
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
        selectedDate = selected;
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
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: AppButton(
          text: "Continue",
          onPress: () {
            Get.to(const AccountTypePage());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
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
                    fontWeight: FontWeight.w400,
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
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                hint: "Enter your first name",
                label: "First Name",
                textController: firstNameTextController,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                hint: "Enter your last name",
                label: "Last Name",
                textController: lastNameTextEditingController,
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                hint: "Enter your email adddress",
                label: "Email Address",
                textController: emailTextEditingController,
              ),
              const SizedBox(
                height: 20,
              ),
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
                  onChanged: (value) => setState(() => genderValue = value),
                  isExpanded: true,
                  value: genderValue,
                  buttonHeight: 60,
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
                height: 20,
              ),
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
                              selectedDate != null
                                  ? DateFormat("dd/MM/yyyy")
                                      .format(selectedDate!)
                                  : "dd/mm/yy",
                              style: TextStyle(color: lightextColor)),
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
      backgroundColor: whiteColor,
    );
  }
}
