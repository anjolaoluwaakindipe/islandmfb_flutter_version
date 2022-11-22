import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static SnackbarController error(String title, String message) {
    return Get.snackbar(title, message,
        backgroundColor: Colors.red[700],
        colorText: Colors.white,
        borderRadius: 0);
  }

  static SnackbarController warning(String title, String message) {
    return Get.snackbar(title, message,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        borderRadius: 0);
  }
}
