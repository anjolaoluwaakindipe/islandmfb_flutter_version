import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';


class AccountServicesPage extends StatefulWidget {
  const AccountServicesPage({Key? key}) : super(key: key);

  @override
  State<AccountServicesPage> createState() => _AccountServicesState();
}

class _AccountServicesState extends State<AccountServicesPage> {
  bool valuefirst = false;
  bool valuesecond = false;
  bool valuethird = false;

  String selectedValue = "";

  bool isButtonDisabled = true;

  void buttonStateHandler() {
    if (selectedValue.isEmpty) {
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
      backgroundColor: whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: AppButton(
          text: "Submit Application",
          onPress: () {},
          isDisabled: isButtonDisabled,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 1,
            ),
            const Text(
              "Account Services",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333)),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Please select from the options below the services you will require for the opening of your account",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Checkbox(
                      checkColor: whiteColor,
                      activeColor: primaryColor,
                      value: valuefirst,
                      side: const BorderSide(color: blackColor, width: 2),
                      onChanged: (bool? value) {
                        if (valuefirst == true) {
                          setState(() {
                            selectedValue = "";
                            valuefirst = false;
                          });
                        } else {
                          setState(() {
                            selectedValue = "sms";
                            valuefirst = selectedValue == "sms" ? true : false;
                            valuesecond = selectedValue == "sms" ? false : true;
                            valuethird = selectedValue == "sms" ? false : true;
                          });
                        }
                        buttonStateHandler();
                      },
                    ),
                    const Text("sms")
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: whiteColor,
                      activeColor: primaryColor,
                      value: valuesecond,
                      side: const BorderSide(
                        color: blackColor,
                        width: 2,
                      ),
                      onChanged: (bool? value) {
                        if (valuesecond == true) {
                          setState(() {
                            selectedValue = "";
                            valuesecond = false;
                          });
                        } else {
                          setState(() {
                            selectedValue = "CreditOnly";
                            valuefirst =
                                selectedValue == "CreditOnly" ? false : true;
                            valuesecond =
                                selectedValue == "CreditOnly" ? true : false;
                            valuethird =
                                selectedValue == "CreditOnly" ? false : true;
                          });
                        }
                        buttonStateHandler();
                      },
                    ),
                    const Text("Credit Only")
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: whiteColor,
                      activeColor: primaryColor,
                      side: const BorderSide(color: blackColor, width: 2),
                      value: valuethird,
                      onChanged: (bool? value) {
                        if (valuethird == true) {
                          setState(() {
                            selectedValue = "";
                            valuethird = false;
                          });
                        } else {
                          setState(() {
                            selectedValue = "DebitOnly";
                            valuefirst =
                                selectedValue == "DebitOnly" ? false : true;
                            valuesecond =
                                selectedValue == "DebitOnly" ? false : true;
                            valuethird =
                                selectedValue == "DebitOnly" ? true : false;
                          });
                        }
                        buttonStateHandler();
                      },
                    ),
                    const Text("Debit Only")
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
