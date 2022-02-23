import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class name extends StatelessWidget {
  const name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
      ),
      body: Column(
        children: <Widget>[
          SvgPicture.asset("../../logo.svg"),
          Text("Use your email address, phone number or account number sd your login id"),

        ],
      ),
    );
  }
}
