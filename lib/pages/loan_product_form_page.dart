import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/components/shared/app_button.dart';
import 'package:islandmfb_flutter_version/components/shared/app_textfield.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class LoanProductForm extends StatefulWidget {
  LoanProductForm({Key? key, required this.formTitle}) : super(key: key);

  String formTitle;

  @override
  State<LoanProductForm> createState() => _LoanProductFormState();
}

class _LoanProductFormState extends State<LoanProductForm> {
  // text controllers
  TextEditingController amountTextController = TextEditingController();
  TextEditingController tenureTextController = TextEditingController();
  TextEditingController purposeTextController = TextEditingController();
  TextEditingController interestTextController = TextEditingController();
  TextEditingController totalDueTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        title:  Text(
          widget.formTitle,
          style: const TextStyle(
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20,
        ),
        child: AppButton(
          text: "Submit",
          onPress: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              AppTextField(
                  textController: amountTextController, label: "Amount"),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                  textController: tenureTextController, label: "Tenure"),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                  textController: purposeTextController, label: "Purpose"),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                  textController: interestTextController, label: "Interest"),
              const SizedBox(
                height: 10,
              ),
              AppTextField(
                  textController: totalDueTextController, label: "Total Due"),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
