import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/components/loan_page/loan_page_quick_actions.dart';
import 'package:islandmfb_flutter_version/pages/home_page.dart';
import 'package:islandmfb_flutter_version/pages/loan_product_page.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async {
      await reLoginWithRefreshToken();
    });
  }

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
          padding: const EdgeInsets.symmetric(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(10)),
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
              const Text(
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
                  LoanPageQuickActions(
                    iconUrlString: "assets/images/loanApplyForLoan.svg",
                    subtitle: "See what loans you qualify for",
                    title: "Apply for Loan",
                    onClick: () {
                      Get.to(LoanProductPage());
                    },
                  ),
                  const SizedBox(height: 20),
                  LoanPageQuickActions(
                    iconUrlString: "assets/images/loanLoanRepayment.svg",
                    subtitle: "Repay your loans in time to access more",
                    title: "Loan Repayment",
                  ),
                  const SizedBox(height: 20),
                  LoanPageQuickActions(
                    iconUrlString: "assets/images/loanLoanTransaction.svg",
                    subtitle: "Check out you loan(s) transactions",
                    title: " Loan Transaction",
                  ),
                  const SizedBox(height: 40)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
