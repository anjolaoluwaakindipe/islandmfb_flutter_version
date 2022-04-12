import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/components/get_started_page/get_started_sign_in_link.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';
import 'package:get/get.dart';

import '../components/shared/app_textfield.dart';
import '../components/shared/app_verification_textfield.dart';

void main() {
  runApp(OtherBankVer());
}

class OtherBankVer extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  // static const String _title = 'Sample App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int? selectedValue = 1;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            '../../images/back.svg',
            height: 20,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: AppButton(
          text: "Verify",
          onPress: () {},
        ),
      ),
      body: ListView(
        children: <Widget>[
          // SvgPicture.assets("assets/"),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Transfer',
                style: TextStyle(
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: const Text(
                'Bank',
                style: TextStyle(fontSize: 17),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: DropdownButtonFormField(
              value: selectedValue,
              items: [
                DropdownMenuItem(
                  child: Text("Bank 1"),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Bank 2"),
                  value: 2,
                ),
                DropdownMenuItem(child: Text("Bank 3"), value: 3),
              ],
              onChanged: (value) {
                setState(() {
                  selectedValue = value as int?;
                });
              },
              //controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bank',
              ),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: const Text(
                'Account Number',
                style: TextStyle(fontSize: 17),
              )),
          AppTextField(hint: "Enter Account Number"),
          const SizedBox(
            height: 20,
          ),

          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: const Text(
                'Amount',
                style: TextStyle(fontSize: 17),
              )),

          AppTextField(hint: "Amount"),
          const SizedBox(
            height: 20,
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: const Text(
                'Narration',
                style: TextStyle(fontSize: 17),
              )),

          AppTextField(hint: "Narration"),
          const SizedBox(
            height: 20,
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: const Text(
                'Pin',
                style: TextStyle(fontSize: 17),
              )),
          AppTextField(hint: "***************", obscureText: true),
          const SizedBox(
            height: 20,
          ),
          // Container(
          //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          //child: TextField(
          //obscureText: true,
          //controller: passwordController,
          //decoration: const InputDecoration(
          //border: OutlineInputBorder(),
          //labelText: 'Pin',
          // ),
          //),
          //),
        ],
      ),
    );
  }
}
