import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';

import '../utilities/colors.dart';

class LoanRepaymentVerifyAirtimePage extends StatefulWidget {
  const LoanRepaymentVerifyAirtimePage({Key? key}) : super(key: key);

  @override
  _LoanRepaymentVerifyAirtimePageState createState() =>
      _LoanRepaymentVerifyAirtimePageState();
}

class _LoanRepaymentVerifyAirtimePageState
    extends State<LoanRepaymentVerifyAirtimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/images/back.svg",
                height: 20,
              ),
            ),
          ),
        ),
        title: const Text(
          "Loan Repayment",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: blackColor,
          ),
        ),
        centerTitle: true,
        foregroundColor: blackColor,
        toolbarHeight: 80,
      ),
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          ListView(children: const [
            ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Text(
                "Savings Account",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text("N39,631.64"),
              leading: CircleAvatar(),
              trailing: Text("#345273672"),
            ),
          ])
        ]),
      ),
    );
  }
}
