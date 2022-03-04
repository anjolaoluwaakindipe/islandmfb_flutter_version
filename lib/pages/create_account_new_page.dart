import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/personal_informaton_page.dart';
import 'package:islandmfb_flutter_version/pages/verification_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

import '../components/shared/app_textfield.dart';

class CreateAccountNewPage extends StatefulWidget {
  CreateAccountNewPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountNewPage> createState() => _CreateAccountNewPageState();
}

class _CreateAccountNewPageState extends State<CreateAccountNewPage> {
  // text controllers
  TextEditingController bvnTextController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  // form key
  GlobalKey<FormState> _createAccountFormKey = GlobalKey<FormState>();

  // button state
  bool isButtonDisabled = true;

  // Validation to enable/disable the Continue button
  void buttonStateHandler() {
    if (bvnTextController.text.isEmpty ||
        phoneNumberTextEditingController.text.isEmpty ||
        emailTextEditingController.text.isEmpty ||
        bvnTextController.text.length < 11 ||
        phoneNumberTextEditingController.text.length < 11) {
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  void onContinueHandler() {
    if (_createAccountFormKey.currentState!.validate()) {
      Get.to(PersonalInformationPage());
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
            onContinueHandler();
          },
          isDisabled: isButtonDisabled,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Form(
          key: _createAccountFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 1,
              ),
              const Text(
                "Create Your Account",
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
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100,),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                hint: "Enter your BVN",
                label: "BVN",
                textController: bvnTextController,
                textInputType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
                onChanged: (value) {
                  buttonStateHandler();
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(11)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                hint: "Enter your phone number",
                label: "Phone Number",
                textController: phoneNumberTextEditingController,
                onChanged: (value) {
                  buttonStateHandler();
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(11)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                hint: "Enter your email",
                label: "Email Address",
                onChanged: (value) {
                  buttonStateHandler();
                },
                textController: emailTextEditingController,
                validator: ValidationBuilder()
                    .email("Not a valid email address")
                    .build(),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: whiteColor,
    );
  }
}
