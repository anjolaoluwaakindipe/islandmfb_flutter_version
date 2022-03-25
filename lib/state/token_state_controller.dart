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
    Map tokenInfo = await loginUserWithUsernameAndPassword(username, password);
    tokenState.value = tokenInfo;

    if (tokenState.containsKey("access_token")) {
      await SecureStorage.writeAValue(
          "refresh_token", tokenState["refresh_token"]);
      await SecureStorage.writeAValue(
          "access_token", tokenState["access_token"]);
    }
  }

  void clearTokenState() {
    tokenState.value = {};
  }
}
