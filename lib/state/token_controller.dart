import 'package:get/get.dart';
import 'package:islandmfb_flutter_version/requests/auth_request.dart';

class TokenController extends GetxController {
  final tokenInfoState = {}.obs;

  void setTokenFromLogin(String username, String password) async {
    Map tokenInfo = await loginUser(username, password);
    tokenInfoState.value = tokenInfo;
  }
}
