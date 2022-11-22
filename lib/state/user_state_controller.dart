import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';
import 'package:islandmfb_flutter_version/storage/secure_storage.dart';

class UserStateController extends GetxController {
  final keycloakUserInfo = {}.obs;

  Future setKeycloakUserInfoStateFromToken() async {
    String? accessToken = await SecureStorage.readAValue("access_token");

    if (accessToken != null) {
      keycloakUserInfo.value = await getUserInfoKeycloak(accessToken);
      keycloakUserInfo.refresh();
    }
  }

  void clearUserState() {
    keycloakUserInfo.value = {};
  }
}
