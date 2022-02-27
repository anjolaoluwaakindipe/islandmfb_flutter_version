import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/pages/personal_informaton_page.dart';
import 'package:islandmfb_flutter_version/pages/verification_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../components/shared/app_textfield.dart';

class AccountServicesPage extends StatefulWidget {
  const AccountServicesPage({Key? key}) : super(key: key);

  @override
  State<AccountServicesPage> createState() => _AccountServicesState();
}

class _AccountServicesState extends State<AccountServicesPage> {
  bool? valuefirst = false;
  bool? valuesecond = false;
  bool? valuethird = false;

  String selectedValue = "";

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
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF333333)),
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: Text(
                "Please select from the options below the services you will require for the opening of your account",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Checkbox without Header and Subtitle: ',
              style: TextStyle(fontSize: 17.0),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  checkColor: Colors.greenAccent,
                  activeColor: Colors.red,
                  value: valuefirst,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedValue = "sms";
                      valuefirst = selectedValue == "sms" ? true : false;
                      valuesecond = selectedValue == "sms" ? false : true;
                      valuethird = selectedValue == "sms" ? false : true;
                    });
                  },
                ),
                Checkbox(
                  value: valuesecond,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedValue = "CreditOnly";
                      valuefirst = selectedValue == "CreditOnly" ? false : true;
                      valuesecond =
                          selectedValue == "CreditOnly" ? true : false;
                      valuethird = selectedValue == "CreditOnly" ? false : true;
                    });
                  },
                ),
                Checkbox(
                  value: valuesecond,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedValue = "Update";
                      valuefirst = selectedValue == "Update" ? false : true;
                      valuesecond = selectedValue == "Update" ? false : true;
                      valuethird = selectedValue == "Update" ? true : false;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: whiteColor,
    );
  }
}
