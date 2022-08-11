// amount validation
  import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';
import 'package:islandmfb_flutter_version/state/transfer_state_controller.dart';

String? isBelowBalance(String? fieldContent, TextEditingController amountTextController ) {
    double amount = double.parse(amountTextController.text.replaceAll(",", ""));
    String? accountNo =
        Get.put(TransferStateController()).transferToMFBAccountState.value.fromAccountNo;
    double? availableBalance = Get.put(AccountStateController())
        .customerAccounts
        .firstWhere(
            (account) => account.primaryAccountNo!["_number"] == accountNo!)
        .availableBalance;
    if (accountNo != null &&
        availableBalance != null &&
        amount > availableBalance) {
      return "Balance exceeded!";
    }
    return null;
  }