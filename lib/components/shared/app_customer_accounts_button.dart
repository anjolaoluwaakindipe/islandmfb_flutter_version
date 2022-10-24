import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class AppCustomerAccountButtons extends StatelessWidget {
  const AppCustomerAccountButtons(
      {Key? key,
      required this.nairaFormat,
      this.accountBalance,
      this.accountNo = "",
      required this.onClick})
      : super(key: key);

  final NumberFormat nairaFormat;
  final String accountNo;
  final double? accountBalance;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: [
                  const TextSpan(text: "Current Account  "),
                  TextSpan(
                    text: accountNo,
                    style: const TextStyle(
                        color: primaryColor, fontWeight: FontWeight.w600),
                  ),
                ], style: const TextStyle(fontSize: 14)),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(nairaFormat.format(accountBalance ?? 0),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800)),
              const Text("Available Balance", style: TextStyle(fontSize: 10))
            ],
          )),
    );
  }
}
