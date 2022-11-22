import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';
import 'package:islandmfb_flutter_version/storage/dropdowns_build_menu_items.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class LinkBVNPage extends StatefulWidget {
  const LinkBVNPage({Key? key}) : super(key: key);

  @override
  State<LinkBVNPage> createState() => _LinkBVNPageState();
}

class _LinkBVNPageState extends State<LinkBVNPage> {
  // text controllers
  TextEditingController bvnNumberTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  // phone number drop down state
  final phoneNumberItems = ["08032449238", "09298345723"];
  String? phoneNumberValue;

  // form key
  GlobalKey<FormState> linkBVNPageFormKey = GlobalKey<FormState>();

  // button state
  bool isButtonDisabled = true;

  void buttonStateHandler() {
    if (bvnNumberTextController.text.isEmpty ||
        phoneNumberValue == null ||
        emailTextController.text.isEmpty) {
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  void onLinkBVNHandler() {
    if (linkBVNPageFormKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    buttonStateHandler();
    return Scaffold(
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
        title: const Text(
          "Link BVN",
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
          text: "SEND",
          onPress: () {
            onLinkBVNHandler();
          },
          isDisabled: isButtonDisabled,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                textController: bvnNumberTextController,
                label: "BVN Number",
                onChanged: (value) {
                  buttonStateHandler();
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Phone Number",
                style: TextStyle(
                    fontSize: 15,
                    color: blackColor,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  items: phoneNumberItems.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() => phoneNumberValue = value);
                  },
                  isExpanded: true,
                  value: phoneNumberValue,
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
              const SizedBox(height: 20),
              AppTextField(
                textController: emailTextController,
                label: "Email",
                textInputType: TextInputType.emailAddress,
                validator: ValidationBuilder().email().build(),
                onChanged: (value) {
                  buttonStateHandler();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
