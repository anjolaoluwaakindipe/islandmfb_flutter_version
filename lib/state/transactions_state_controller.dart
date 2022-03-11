import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/requests/account_request.dart';
import 'package:islandmfb_flutter_version/state/account_state_controller.dart';

class TransactionStateController extends GetxController {
  final recentTransactionHistoryState = [].obs;
  final selectedTransactionState = {}.obs;
  final fullTransactionHistoryState = [].obs;

  Future setRecentTransactionHistory() async {
    var selectedAccountNumber = await Get.put(AccountStateController())
        .selectedAccount["primaryAccountNo"]?["_number"];
    recentTransactionHistoryState.value =
        await getCustomerRecentTransactions(selectedAccountNumber)
            .then((value) {
      if (value["success"] == true) {
        return value["data"];
      } else {
        return [];
      }
    });
    if (recentTransactionHistoryState.isEmpty) {
      return;
    }

    return recentTransactionHistoryState;
  }
}
