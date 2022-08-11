import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';
import 'package:islandmfb_flutter_version/storage/secure_storage.dart';

class TokenStateController extends GetxController {
  late RxMap tokenState = {}.obs;

  @override
  void onInit() async {
    super.onInit();
    String? refreshToken = await SecureStorage.readAValue("refresh_token");
    String? accessToken = await SecureStorage.readAValue("access_token");
    if (refreshToken != null && accessToken != null) {
      tokenState.value =
          {"access_token": accessToken, "refresh_token": refreshToken}.obs;
      return;
    }

    tokenState.value = {}.obs;
  }

  Future setTokenFromLogin(String username, String password) async {
    SecureStorage.deleteAValue("refresh_token");
    SecureStorage.deleteAValue("access_token");
    Map tokenInfo = await loginUserWithUsernameAndPassword(username, password);
    tokenState.value = tokenInfo;

    if (tokenState["success"]) {
      await SecureStorage.writeAValue(
          "refresh_token", tokenState["data"]["refresh_token"]);
      await SecureStorage.writeAValue(
          "access_token", tokenState["data"]["access_token"]);
    }
  }

  void clearTokenState() {
    tokenState.value = {};
    tokenState.refresh();
  }
}
