import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';

import '../components/shared/app_button.dart';
import '../utilities/colors.dart';

class ProfileSetPinPage extends StatefulWidget {
  const ProfileSetPinPage({Key? key}) : super(key: key);

  @override
  _ProfileSetPinPageState createState() => _ProfileSetPinPageState();
}

class _ProfileSetPinPageState extends State<ProfileSetPinPage> {
  // button state
  bool isButtonDisabled = true;
  GlobalKey<FormState> pinPageFormKey = GlobalKey<FormState>();
  String? text = "";
  bool setMe = true;

  // textediting controllers
  TextEditingController enterPinTextController = TextEditingController();
  TextEditingController confirmPinTextController = TextEditingController();

  // button handler
  buttonStateHandler() {
    if (enterPinTextController.text.length < 4 ||
        confirmPinTextController.text.length < 4 ||
        enterPinTextController.text != confirmPinTextController.text) {
      setState(() {
        isButtonDisabled = true;
      });
    } else {
      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  // pin logic

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
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
            "Set PIN",
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
        body: SizedBox(
          height: double.maxFinite,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: pinPageFormKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Please provide a four digit pin you would like to use.",
                        style: TextStyle(
                          color: lightextColor,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textController: enterPinTextController,
                        onChanged: (String value) {
                          buttonStateHandler();
                        },
                        label: "Enter PIN",
                        hideText: true,
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        textController: confirmPinTextController,
                        label: "Confirm PIN",
                        onChanged: (String value) {
                          buttonStateHandler();
                        },
                        validator: ValidationBuilder()
                            .minLength(4)
                            .maxLength(4)
                            .build(),
                        hideText: true,
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 20,
          ),
          child: AppButton(
            text: "Confirm",
            onPress: () {},
            isDisabled: isButtonDisabled,
          ),
        ),
      ),
    );
  }
}
