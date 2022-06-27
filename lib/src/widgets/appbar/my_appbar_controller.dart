import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:eltriodigital_flutter/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyAppBarController extends GetxController {
  List<Producto> selectedProducts = <Producto>[];
  var items = 0;

  MyAppBarController() {
    cargarCarrito();
  }

  Future cargarCarrito() async {
    if (GetStorage().read('shopping_bag') != null) {
      if (GetStorage().read('shopping_bag') is List<Producto>) {
        var result = GetStorage().read('shopping_bag');
        selectedProducts.clear();
        selectedProducts.addAll(result);
        // result.forEach(
        //     (element) => print('${element.name} - ${element.quantity} '));
      } else {
        var result = Producto.fromJsonList(GetStorage().read('shopping_bag'));
        // result.forEach(
        //     (element) => print('${element.name} - ${element.quantity} '));
        selectedProducts.clear();
        selectedProducts.addAll(result);
      }
      //getTotal();
      //print('selected products en controller: ${selectedProducts.length}');
      items = selectedProducts.length;
    }
  }

  // LAS 2 FUNCIONES DE ABAJO ESTAN PREPARADAS PARA CUANDO AGREGUEMOS PRODUCTOS DIRECTAMENTE DESDE LOS LISTADOS
  // void addProductoCarrito(Producto product) {
  //   //goToProductoPage(id);
  //   //print('Producto recibido: $product');
  //   GetStorage().write('shopping_bag', selectedProducts);
  //   Utils.snackBarOk('Carrito', 'Producto agregado al carrito');
  //   itemsCount();
  // }

  // void itemsCount() {
  //   items.value = 0;
  //   selectedProducts.forEach((p) {
  //     items.value = items.value;
  //   });
  // }

  void goToCarritoPage() {
    Get.offNamed('/tienda/carrito');
  }

  void goToTiendaPage() {
    Get.offAllNamed('/tienda');
  }

  void signOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);
  }
}
