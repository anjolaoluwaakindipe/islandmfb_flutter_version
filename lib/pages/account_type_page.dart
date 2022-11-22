import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/account_type_page.dart/account_type_button.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';


class AccountTypePage extends StatelessWidget {
  const AccountTypePage({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 1,
              ),
              Text(
                "Account Type",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333)),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(),
                child: Text(
                  "Select an account type",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w100),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              AccountTypeButtons(accountType: "Savings Account"),
              SizedBox(
                height: 10,
              ),
              AccountTypeButtons(accountType: "Current Account"),
              SizedBox(
                height: 10,
              ),
              AccountTypeButtons(accountType: "Esusu"),
              SizedBox(
                height: 10,
              ),
              AccountTypeButtons(accountType: "Terms Loan"),
              SizedBox(
                height: 10,
              ),
              AccountTypeButtons(accountType: "Staff Loan"),
              SizedBox(
                height: 10,
              ),
              AccountTypeButtons(accountType: "Mortgage Loan"),
              SizedBox(
                height: 10,
              ),
              AccountTypeButtons(accountType: "Call Deposit"),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
