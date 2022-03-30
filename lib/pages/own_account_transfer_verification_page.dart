import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/pages/success_page.dart';
import 'package:islandmfb_flutter_version/state/airtime_state_controller.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class OwnAccountTransferVerificationPage extends StatefulWidget {
  const OwnAccountTransferVerificationPage({Key? key}) : super(key: key);

  @override
  State<OwnAccountTransferVerificationPage> createState() =>
      _OwnAccountTransferVerificationPageState();
}

class _OwnAccountTransferVerificationPageState
    extends State<OwnAccountTransferVerificationPage> {
  AirtimeStateController airtimeState = Get.put(AirtimeStateController());

  // naira formatter
  final nairaFormat = NumberFormat.currency(name: "N  ");

  void onPayHandler() {
    Get.to(SuccessPage(
      buttonText: "Continue",
      successMessage: "Airtime Payment was successful!!!",
      nextPage: const HomePage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> airtimeReceipt = airtimeState.airtimeState;

    bool _value = false;

    return Scaffold(
      // APP BAR
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
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
          "Transfer",
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

      //BOTTOM NAV
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20,
        ),
        child: AppButton(
          text: "Send",
          onPress: () {
            onPayHandler();
          },
        ),
      ),

      // BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(children: [
            const SizedBox(
              height: 0,
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 50,
                left: 0,
                right: 0,
              ),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() => Column(children: [
                    Center(
                      child: Text(
                        nairaFormat.format(airtimeReceipt["amount"] ?? 0),
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 50),
                      child: SvgPicture.asset(
                        "assets/images/receiptDivider.svg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Bank",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(airtimeReceipt["biller"] ?? "",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Account Number",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Text(airtimeReceipt["product"] ?? "",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Account Name",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Text("Akinloluwa Adeleye",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 40.0),
                                child: Text("Amount",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              Expanded(
                                child:
                                    Text(airtimeReceipt["mobileNumber"] ?? "",
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Charges",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Text("5.00",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                  ])),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Save as beneficiary"),
                const SizedBox(
                  width: 30,
                ),
                SwitchScreen(),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ]),
        ),
      ),
    );
  }
}

class SwitchScreen extends StatefulWidget {
  @override
  SwitchClass createState() => new SwitchClass();
}

class SwitchClass extends State {
  bool isSwitched = false;
  // var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 2,
          child: Switch(
            onChanged: toggleSwitch,
            value: isSwitched,
            activeColor: primaryColor,
            activeTrackColor: accentColor,
            inactiveThumbColor: primaryColor,
            inactiveTrackColor: accentColor,
          )),
      // Text(
      //   '$textValue',
      //   style: TextStyle(fontSize: 20),
      // )
    ]);
  }
}
