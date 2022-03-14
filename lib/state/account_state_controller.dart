import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/requests/account_request.dart';

class AccountStateController extends GetxController {
  final customerAccounts = [].obs;
  final selectedAccount = {}.obs;
  final customerDetails = {}.obs;

  Future setAccountStateFromLogin(String customerNo) async {
    var customerAccountsResponse = await getCustomerAccounts(customerNo);
    var customerDetailsResponse = await getCustomerDetails(customerNo);
    if (customerAccountsResponse["success"] == true &&
        customerDetailsResponse["success"] == true) {
      customerAccounts.value = customerAccountsResponse["data"];
      selectedAccount.value = customerAccounts[0];
      customerDetails.value = customerDetailsResponse["data"];
    }
  }

  void changeSelectedAccount(int index) {
    selectedAccount.value = customerAccounts[index];
  }
}
