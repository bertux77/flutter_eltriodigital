import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static snackBarOk(String title, String message){
    Get.snackbar(title, message,
          icon: const Icon(Icons.check, color: Colors.green),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.blue,
          backgroundColor: Colors.white);
  }

  static snackBarError(String title, String message){
    Get.snackbar(title, message,
          icon: const Icon(Icons.dangerous, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.blue,
          backgroundColor: Colors.white);
  }
}