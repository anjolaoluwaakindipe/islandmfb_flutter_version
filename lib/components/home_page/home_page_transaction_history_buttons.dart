import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class HomePageTransactionHistoryButtons extends StatelessWidget {
  const HomePageTransactionHistoryButtons({
    Key? key,
    required this.nairaFormat,
    this.accountOwner = "",
    this.isCredit = false,
    this.moneyAmount,
    this.otherAccount = "",
    this.date = "",
  }) : super(key: key);

  final NumberFormat nairaFormat;
  final String accountOwner;
  final String otherAccount;
  final moneyAmount;
  final bool isCredit;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {},
          child: Ink(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: accentColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(fontSize: 10),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        (isCredit ? "TRF/FRM " : "TRF/To ") + otherAccount,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        (isCredit ? "To " : "FRM ") + accountOwner,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      nairaFormat.format(500000000),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: isCredit ? successColor : primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
