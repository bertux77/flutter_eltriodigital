import 'package:get/get.dart';

class MyBottomNavigationBarController extends GetxController{
  var indexTabAppBar = 1.obs;

  void changeTab(int index){
    indexTabAppBar.value = index;
    switch (indexTabAppBar.value) {
    case 0: // UTILS
      Get.toNamed('/utils');
      break;
    case 1:  // TIENDA
      Get.toNamed('/tienda');
      break;
    case 2: // PERFIL
      Get.toNamed('/perfil');
      break;
    }
  }
}