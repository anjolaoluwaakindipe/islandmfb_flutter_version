import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/account_type_page.dart';
import 'package:islandmfb_flutter_version/pages/get_started_page.dart';
import 'package:islandmfb_flutter_version/pages/verification_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';

import '../components/shared/app_textfield.dart';

class PersonalInformationPage extends StatelessWidget {
  PersonalInformationPage({
    Key? key,
  }) : super(key: key);

  // TextField controllers
    TextEditingController firstNameTextController = TextEditingController();
  TextEditingController lastNameTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  final BsSelectBoxController _select1 = BsSelectBoxController(options: [
    const BsSelectBoxOption(value: 1, text: Text('Male')),
    const BsSelectBoxOption(value: 2, text: Text('Female')),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        // leading: SizedBox(
        //   height: 1,
        //   child: SvgPicture.asset(
        //     '../../images/back.svg',
        //     height: 1,
        //     width: 1,
        //     fit: BoxFit.contain,
        //   ),
        // ),
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
      body: Padding(
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
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333)),
            ),
            const SizedBox(
              height: 2,
            ),
            const Padding(
              padding: EdgeInsets.only(),
              child: Text(
                "Create an account by providing the details needed below.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            AppTextField(hint: "Enter your first name", label: "First Name", textController: firstNameTextController,),
            const SizedBox(
              height: 20,
            ),
            AppTextField(hint: "Enter your last name", label: "Last Name", textController: lastNameTextEditingController,),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
                hint: "Enter your email adddress", label: "Email Address", textController: emailTextEditingController,),
            const SizedBox(
              height: 5,
            ),
            BsSelectBox(
              hintText: 'Male',
              controller: _select1,
            ),
            // AppTextField(hint: "Enter your email adddress", label: "Gender"),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
      backgroundColor: whiteColor,
    );
  }
}
