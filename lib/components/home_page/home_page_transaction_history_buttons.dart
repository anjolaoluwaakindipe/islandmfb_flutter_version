import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class HomePageTransactionHistoryButtons extends StatelessWidget {
  const HomePageTransactionHistoryButtons(
      {Key? key,
      required this.nairaFormat,
      this.accountOwner = "",
      this.isCredit = false,
      this.moneyAmount,
      this.otherAccount = "",
      this.date = "",
      this.narrative = ""})
      : super(key: key);

  final NumberFormat nairaFormat;
  final String accountOwner;
  final String otherAccount;
  final dynamic moneyAmount;
  final bool isCredit;
  final String date;
  final String narrative;

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                         DateFormat("h:mm a, EEE, d MMM, yyyy")
                            .format(DateTime.parse(date)),
                        style: const TextStyle(fontSize: 10),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        narrative,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      nairaFormat.format(moneyAmount),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: moneyAmount > 0 ? successColor : primaryColor,
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
