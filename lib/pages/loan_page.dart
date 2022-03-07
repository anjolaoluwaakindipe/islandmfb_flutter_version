import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class LoanPage extends StatefulWidget {
  LoanPage({Key? key}) : super(key: key);

  @override
  State<LoanPage> createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
  // naira formatter
  final nairaFormat = NumberFormat.currency(name: "N  ");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            onPressed: () {
              Get.to(const HomePage());
            },
            icon: SvgPicture.asset(
              "assets/images/back.svg",
              height: 20,
            ),
          ),
        ),
        backgroundColor: whiteColor,
        title: const Text(
          "Loan",
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
        padding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi Akinloluwa",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              decoration: BoxDecoration(
                  color: accentColor, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nairaFormat.format(4000),
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Loan Balance", style: TextStyle(fontSize: 16)),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: "Next repayment date  ",
                      ),
                      TextSpan(
                          text: "dd/mm/yy",
                          style: TextStyle(fontWeight: FontWeight.w600))
                    ], style: TextStyle(fontSize: 15)),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                LoanPageQuickActions(),
              ],
            )
          ],
        ),
      )),
    );
  }
}

class LoanPageQuickActions extends StatefulWidget {
  const LoanPageQuickActions({
    Key? key,
  }) : super(key: key);

  @override
  State<LoanPageQuickActions> createState() => _LoanPageQuickActionsState();
}

class _LoanPageQuickActionsState extends State<LoanPageQuickActions> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      highlightColor: primaryColor,
      child: Ink(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset("assets/images/loanApplyForLoan.svg"),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Apply for Loan",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("See what loans you qualify for "),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
