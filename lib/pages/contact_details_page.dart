import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';

import '../components/shared/app_textfield.dart';
import '../utilities/colors.dart';

class ContactDetailsPage extends StatefulWidget {
  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  _ContactDetailsPageState createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  // button state
  bool isButtonDisabled = true;

  // textediting controllers
  TextEditingController streetNumberTextController = TextEditingController();
  TextEditingController streetNameTextController = TextEditingController();
  TextEditingController cityTownTextController = TextEditingController();
  TextEditingController nearestBusTextController = TextEditingController();
  TextEditingController phoneNumberTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  // drop down menu items builder
  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }

  unDisableButton() {
    if (streetNumberTextController.text.isEmpty ||
        streetNameTextController.text.isEmpty ||
        nearestBusTextController.text.isEmpty ||
        cityTownTextController.text.isEmpty ||
        phoneNumberTextController.text.isEmpty ||
        emailTextController.text.isEmpty ||
        emailTextController.text.length < 4) {
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
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/images/back.svg",
              height: 20,
            ),
          ),
        ),
        backgroundColor: whiteColor,
        title: const Text(
          "Contact Details",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: blackColor,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: GFButton(
              text: "Save",
              onPressed: () {},
              size: 1,
              hoverColor: accentColor,
              focusColor: accentColor,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
              color: Colors.transparent,
            ),
          ),
        ],
        toolbarHeight: 80,
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 15),
            AppTextField(
              textController: streetNumberTextController,
              label: "Street Number",
              labelColor: lightextColor,
              textInputType: TextInputType.text,
              onChanged: (value) {
                unDisableButton();
              },
            ),
            const SizedBox(height: 15),
            AppTextField(
              textController: streetNameTextController,
              label: "Street Name",
              labelColor: lightextColor,
              textInputType: TextInputType.text,
              onChanged: (value) {
                unDisableButton();
              },
            ),
            const SizedBox(height: 15),
            AppTextField(
              textController: cityTownTextController,
              label: "City/Town",
              labelColor: lightextColor,
              textInputType: TextInputType.text,
              onChanged: (value) {
                unDisableButton();
              },
            ),
            const SizedBox(height: 15),
            AppTextField(
              textController: nearestBusTextController,
              label: "Nearest Bus-stop",
              labelColor: lightextColor,
              textInputType: TextInputType.text,
              onChanged: (value) {
                unDisableButton();
              },
            ),
            const SizedBox(height: 15),
            AppTextField(
              textController: phoneNumberTextController,
              label: "Phone Number",
              labelColor: lightextColor,
              textInputType: TextInputType.text,
              onChanged: (value) {
                unDisableButton();
              },
            ),
            const SizedBox(height: 15),
            AppTextField(
              textController: emailTextController,
              label: "Email",
              labelColor: lightextColor,
              textInputType: TextInputType.text,
              onChanged: (value) {
                unDisableButton();
              },
            )
          ]),
        ),
      ),
    );
  }
}
