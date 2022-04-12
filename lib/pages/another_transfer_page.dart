import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/pages/own_account_transfer_page.dart';
import 'package:islandmfb_flutter_version/pages/mfb_account_transfer_page.dart';
import 'package:islandmfb_flutter_version/pages/transfer_to_other_banks_page.dart';
import 'package:islandmfb_flutter_version/state/transfer_state_controller.dart';

import '../utilities/colors.dart';

class TransferTypePage extends StatefulWidget {
  const TransferTypePage({Key? key}) : super(key: key);

  @override
  _TransferTypePageState createState() => _TransferTypePageState();
}

class _TransferTypePageState extends State<TransferTypePage> {
  final transactionState = Get.put(TransferStateController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future(() {
      transactionState.setfullNameAndCustomerNoAutomatically();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: whiteColor,
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
        title: const Text(
          "Transfer Type",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                "Choose Transfer Type",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(81, 81, 81, 1)),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Get.to(const MfbAccountTransferPage(),
                      transition: Transition.rightToLeft);
                },
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
                          Row(
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(188, 75, 82, 0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/images/IF.svg",
                                    height: 20,
                                    fit: BoxFit.cover,
                                    width: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("To island MF Account",
                                  style: TextStyle(color: lightextColor)),
                            ],
                          ),
                          SvgPicture.asset(
                            "assets/images/right.svg",
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Get.to(TransferToOtherBanksPage(),
                      transition: Transition.rightToLeft);
                },
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
                          Row(
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(188, 75, 82, 0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/images/house.svg",
                                    height: 25,
                                    fit: BoxFit.cover,
                                    width: 25,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("To Other Bank Account",
                                  style: TextStyle(color: lightextColor)),
                            ],
                          ),
                          SvgPicture.asset(
                            "assets/images/right.svg",
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Get.to(OwnAccountTransferPage(),
                      transition: Transition.rightToLeft);
                },
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
                          Row(
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(188, 75, 82, 0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    "assets/images/own.svg",
                                    height: 25,
                                    fit: BoxFit.cover,
                                    width: 25,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Own Account Transfer",
                                  style: TextStyle(color: lightextColor)),
                            ],
                          ),
                          SvgPicture.asset(
                            "assets/images/right.svg",
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
