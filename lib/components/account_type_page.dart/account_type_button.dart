import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/pages/account_services_pages.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class AccountTypeButtons extends StatelessWidget {
  const AccountTypeButtons({Key? key, required this.accountType})
      : super(key: key);

  final String accountType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(const AccountServicesPage());
      },
      child: Ink(
        color: accentColor,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/images/Group.svg'),
                const SizedBox(
                  width: 10,
                ),
                Text(accountType),
              ],
            ),
            const Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}
