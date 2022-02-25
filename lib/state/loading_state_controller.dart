import 'package:get/get.dart';

class LoadingStateController extends GetxController {
  final isLoading = false.obs;

  void setLoadingFalse() {
    isLoading.value = false;
  }
  
  void setLoadingTrue() {
    isLoading.value = true;
  }
}
