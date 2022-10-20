import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';
import 'package:islandmfb_flutter_version/storage/secure_storage.dart';

class UserStateController extends GetxController {
  final user = {}.obs;

  Future setUserStateFromToken() async {
    String? accessToken = await SecureStorage.readAValue("access_token");

    if (accessToken != null) {
      user.value = await getUserInfo(accessToken);
      user.refresh();
    }
  }

  void clearUserState() {
    user.value = {};
  }
}
