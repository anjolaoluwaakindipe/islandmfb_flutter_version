import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class LoanPageQuickActions extends StatefulWidget {
  LoanPageQuickActions(
      {Key? key,
      required this.title,
      required this.iconUrlString,
      required this.subtitle,
      this.onClick})
      : super(key: key);

  String title;
  String subtitle;
  String iconUrlString;
  void Function()? onClick;

  @override
  State<LoanPageQuickActions> createState() => _LoanPageQuickActionsState();
}

class _LoanPageQuickActionsState extends State<LoanPageQuickActions> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: widget.onClick,
      highlightColor: primaryColor,
      child: Ink(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(widget.iconUrlString),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.subtitle),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
