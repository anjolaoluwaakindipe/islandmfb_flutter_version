import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/pages/loan_product_form_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class LoanProductPage extends StatefulWidget {
  LoanProductPage({Key? key}) : super(key: key);

  @override
  State<LoanProductPage> createState() => _LoanProductPageState();
}

class _LoanProductPageState extends State<LoanProductPage> {
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
        title: const Text(
          "Loan Products",
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Loan Products",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const Text(
                "We offer different loan products, you can start with low value and progressively grow",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  LoanProductPageLoanProductButtons(
                    loanTitle: "Quick Loan",
                    loanSubtitle: "5% interest",
                    onClick: () {
                      Get.to(LoanProductForm(formTitle: "Quick Loan"));
                    },
                  ),
                  const SizedBox(height: 10),
                  LoanProductPageLoanProductButtons(
                    loanTitle: "Student Loan",
                    loanSubtitle: "10% interest",
                    onClick: () {
                      Get.to(LoanProductForm(formTitle: "Student Loan"));
                    },
                  ),
                  const SizedBox(height: 10),
                  LoanProductPageLoanProductButtons(
                    loanTitle: "Business Loan",
                    loanSubtitle: "25% interest",
                    onClick: () {
                      Get.to(LoanProductForm(formTitle: "Business Loan"));
                    },
                  ),
                  const SizedBox(height: 10),
                  LoanProductPageLoanProductButtons(
                    loanTitle: "Educational Loan",
                    loanSubtitle: "10% interest",
                    onClick: () {
                      Get.to(LoanProductForm(formTitle: "Educational Loan"));
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoanProductPageLoanProductButtons extends StatelessWidget {
  const LoanProductPageLoanProductButtons(
      {Key? key,
      required this.loanTitle,
      required this.loanSubtitle,
      this.onClick})
      : super(key: key);

  final String loanTitle;
  final String loanSubtitle;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/images/loanApplyForLoan.svg"),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    loanTitle,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    loanSubtitle,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: onClick,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                  child: Text(
                    "APPLY",
                    style: TextStyle(color: whiteColor),
                  ),
                ),
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(primaryColor)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
