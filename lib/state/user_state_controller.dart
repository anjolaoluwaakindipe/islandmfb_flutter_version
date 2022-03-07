import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';
import 'package:islandmfb_flutter_version/storage/secure_storage.dart';

class UserStateController extends GetxController {
  final user = {}.obs;

  Future setUserStateFromLogin() async {
    String accessToken = await SecureStorage.readAValue("accessToken");

    if (accessToken.isNotEmpty) {
      user.value = await getUserInfo(accessToken);
    }
  }
}
