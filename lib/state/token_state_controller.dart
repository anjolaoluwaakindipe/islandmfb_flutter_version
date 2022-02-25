import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';

class TokenStateController extends GetxController {
  final tokenState = {}.obs;

  Future setTokenFromLogin(String username, String password) async {
    Map tokenInfo = await loginUser(username, password);
    tokenState.value = tokenInfo;
  }
}
