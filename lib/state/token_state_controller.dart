import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';
import 'package:islandmfb_flutter_version/storage/secure_storage.dart';

class TokenStateController extends GetxController {
  final tokenState = {}.obs;

  Future setTokenFromLogin(String username, String password) async {
    Map tokenInfo = await loginUser(username, password);
    tokenState.value = tokenInfo;

    if (tokenState.containsKey("access_token")) {
      await SecureStorage.writeAValue(
          "refresh_token", tokenState["refresh_token"]);
      
    }
  }
}
