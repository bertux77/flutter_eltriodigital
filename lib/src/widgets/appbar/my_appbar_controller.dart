import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:eltriodigital_flutter/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyAppBarController extends GetxController {
  //List<Product> selectedProducts = <Product>[].obs;
  List<int> selectedProducts = <int>[].obs;
  var items = 0.obs;
  void addProductoCarrito(Producto product){
    //goToProductoPage(id);
    print('Producto recibido: $product');
    GetStorage().write('shopping_bag', selectedProducts);
    Utils.snackBarOk('Carrito', 'Producto agregado al carrito');
    itemsCount();
  }

  void itemsCount(){
    items.value = 0;
    selectedProducts.forEach((p) {
      items.value = items.value;
    });
  }

  void addItem(int id) {
    // int index = selectedProducts.indexWhere((p) => p.id == product.id);
    // selectedProducts.remove(product);
    // product.quantity = product.quantity! + 1;
    // selectedProducts.insert(index, product);
    
    //getTotal();
   
    //itemsCount();
  }

  void goToHomePage(){
    Get.offNamed('/home');
  }

  void signOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}