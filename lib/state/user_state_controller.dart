import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';

class UserStateController extends GetxController {
  final user = {}.obs;

  Future setUserStateFromLogin(String accessToken)async {
    user.value = await getUserInfo(accessToken);
  }
}
