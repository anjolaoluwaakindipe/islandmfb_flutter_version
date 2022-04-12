import 'package:bs_flutter/bs_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/shared/app_button.dart';
import '../utilities/colors.dart';

class ProfileSetPinPage extends StatefulWidget {
  const ProfileSetPinPage({Key? key}) : super(key: key);

  @override
  _ProfileSetPinPageState createState() => _ProfileSetPinPageState();
}

class _ProfileSetPinPageState extends State<ProfileSetPinPage> {
  // button state
  bool isButtonDisabled = true;
  String? text = "";
  bool setMe = true;

  // textediting controllers
  TextEditingController enterPinTextController = TextEditingController();
  TextEditingController confirmPinTextController = TextEditingController();

  unDisableButton() {
    if (enterPinTextController.text.length == 4 &&
        confirmPinTextController.text.length == 4 &&
        enterPinTextController.text == confirmPinTextController.text) {
      setState(() {
        isButtonDisabled = false;
        setMe = false;
        text = "";
      });
    } else {
      setState(() {
        isButtonDisabled = true;
        setMe = false;
        text = "PIN must be four digits only.";
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
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/images/back.svg",
              height: 20,
            ),
          ),
        ),
        backgroundColor: whiteColor,
        title: const Text(
          "Set PIN",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Enter PIN",
              style: TextStyle(
                  fontSize: 17,
                  color: lightextColor,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            BsInput(
                controller: enterPinTextController,
                autofocus: true,
                obscureText: true,
                suffixIcon: Icons.block),
            const SizedBox(
              height: 5,
            ),
            Text("$text"),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Confirm PIN",
              style: TextStyle(
                  fontSize: 17,
                  color: lightextColor,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            BsInput(
              controller: confirmPinTextController,
              autofocus: true,
              obscureText: true,
              onChange: (value) {
                unDisableButton();
              },
              suffixIcon: Icons.block,
            ),
            const SizedBox(
              height: 15,
            ),
            Offstage(
              offstage: setMe,
              child: AppButton(
                text: "Set Pin",
                onPress: () {},
                isDisabled: isButtonDisabled,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
