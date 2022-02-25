import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/requests/account_request.dart';

class AccountStateController extends GetxController {
  final accountState = [].obs;
  final selectedAccountState = {}.obs;

  Future setAccountStateFromLogin(String customerNo) async {
    print(await getAccountInfo("0002"));
    var response = await getAccountInfo("0002");
    if (response["success"] == true) {
      accountState.value = response["data"];
    }

    print(accountState);
    selectedAccountState.value = accountState[0];
  }

  void changeSelectedAccount(int index) {
    selectedAccountState.value = accountState[index];
  }
}
