import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/models/requests/account_types_response.dart';
import 'package:islandmfb_flutter_version/pages/account_services_pages.dart';
import 'package:islandmfb_flutter_version/utilities/colors.dart';

class AccountTypeButtons extends StatelessWidget {
  const AccountTypeButtons(
      {Key? key, required this.accountType, this.selected, this.onSelect})
      : super(key: key);

  final AccountTypesResponse accountType;
  final void Function(AccountTypesResponse accountTypesResponse)? onSelect;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onSelect != null) {
          onSelect!(accountType);
        }
      },
      child: Ink(
        decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(10),
            border: selected == true
                ? Border.all(color: primaryColor, width: 2)
                : null),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Row(
          children: [
            SvgPicture.asset('assets/images/Group.svg'),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                  constraints: const BoxConstraints(maxHeight: 100),
                  child: Text(accountType.description ?? "")),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}
