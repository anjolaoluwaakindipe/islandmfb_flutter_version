import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/models/response_model.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';
import 'package:islandmfb_flutter_version/storage/secure_storage.dart';

class AuthStateController extends GetxController {
  late RxMap<String, dynamic> tokenState = RxMap<String, dynamic>();
  RxString loginErrorMessage = "".obs;

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

    tokenState.value = RxMap<String, dynamic>();
  }

  Future setTokenFromLogin(String username, String password) async {
    loginErrorMessage.value = "";
    loginErrorMessage.refresh();
    SecureStorage.deleteAValue("refresh_token");
    SecureStorage.deleteAValue("access_token");
    ResponseM<Map<String, dynamic>> tokenInfo =
        await loginUserWithUsernameAndPassword(username, password);

    if (tokenInfo.customErrorMessage != null &&
        tokenInfo.customErrorMessage!.isNotEmpty) {
      loginErrorMessage.value = tokenInfo.customErrorMessage ?? "";
      return;
    }

    if (tokenInfo.data != null &&
        tokenInfo.status != null &&
        tokenInfo.status!.isOk) {
      tokenState.value = tokenInfo.data ?? tokenState;
      await SecureStorage.writeAValue(
          "refresh_token", tokenInfo.data!["refresh_token"]);
      await SecureStorage.writeAValue(
          "access_token", tokenInfo.data!["access_token"]);

      tokenState.refresh();
      return;
    } else if (tokenInfo.status != null && tokenInfo.status!.isUnauthorized) {
      loginErrorMessage.value = "Invalid Username or Password";
    }
  }

  void clearTokenState() {
    tokenState.value = {};
    tokenState.refresh();
  }
}
