import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:islandmfb_flutter_version/utilities/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
      ),
      body: Column(
        children: <Widget>[
          SvgPicture.asset("../../logo.svg"),
          const Text(
              "Use your email address, phone number or account number sd your login id"),
        ],
      ),
    );
  }
}
