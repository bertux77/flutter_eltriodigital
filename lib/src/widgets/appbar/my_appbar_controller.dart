import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyAppBarController extends GetxController {


  void addProductoCarrito(int id){
    //goToProductoPage(id);
  }

  

  void goToHomePage(){
    Get.offNamed('/home');
  }

  void signOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}