import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class StatementOfAccountPage extends StatefulWidget {
  const StatementOfAccountPage({Key? key}) : super(key: key);

  @override
  State<StatementOfAccountPage> createState() => _StatementOfAccountPageState();
}

class _StatementOfAccountPageState extends State<StatementOfAccountPage> {
  // text controllers
  TextEditingController emailTextController = TextEditingController();

  // date states
  Map<String, DateTime?> dates = {
    "startDate": null,
    "endDate": null,
  };

  // button state
  bool isButtonDisabled = true;

  // keys
  GlobalKey<FormState> stateMentOfAccountFormKey = GlobalKey<FormState>();

  // control date selectors
  _selectDate(BuildContext context, String selectedDate) async {
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

    print(selected);
    if (selected != null) {
      setState(() {
        dates[selectedDate] = selected;
      });
    }
    print(dates[selectedDate]);
  }

  // Send button handler
  void onSendHandler() {
    if (stateMentOfAccountFormKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    // handle button state
    void buttonStateHandler() {
      if (dates["startDate"] == null ||
          dates["endDate"] == null ||
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
          "Statement of Account",
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
            onSendHandler();
          },
          isDisabled: isButtonDisabled,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: stateMentOfAccountFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Start Date",
                  style: TextStyle(
                      fontSize: 15,
                      color: blackColor,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context, "startDate");
                    // buttonStateHandler();
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
                                dates["startDate"] != null
                                    ? DateFormat("dd/MM/yyyy")
                                        .format(dates["startDate"]!)
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
                  height: 20,
                ),
                const Text(
                  "End Date",
                  style: TextStyle(
                      fontSize: 15,
                      color: blackColor,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    _selectDate(context, "endDate");
                    // buttonStateHandler();
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
                                dates["endDate"] != null
                                    ? DateFormat("dd/MM/yyyy")
                                        .format(dates["endDate"]!)
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
                  height: 20,
                ),
                AppTextField(
                  textController: emailTextController,
                  label: "Email",
                  hint: "email@example.com",
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
      ),
    );
  }
}
