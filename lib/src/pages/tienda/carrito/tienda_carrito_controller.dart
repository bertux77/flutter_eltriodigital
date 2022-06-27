import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class TiendaCarritoController extends GetxController {
  List<Producto> selectedProducts = <Producto>[].obs;
  var total = 0.0.obs;

  TiendaCarritoController() {
    // var logger = Logger(
    //   filter: null,
    //   printer: PrettyPrinter(),
    //   output: null,
    // );
    // final shoppingBar = GetStorage().read('shopping_bag');
    // logger.d(shoppingBar);

    if (GetStorage().read('shopping_bag') != null) {
      if (GetStorage().read('shopping_bag') is List<Producto>) {
        var result = GetStorage().read('shopping_bag');
        selectedProducts.clear();
        selectedProducts.addAll(result);
        // result.forEach(
        //     (element) => print('if: ${element.name} - ${element.quantity} '));
      } else {
        var result = Producto.fromJsonList(GetStorage().read('shopping_bag'));
        // result.forEach(
        //     (element) => print('else: ${element.name} - ${element.quantity} '));
        selectedProducts.clear();
        selectedProducts.addAll(result);
      }
      getTotal();
    }
  }

  void deleteItem(Producto product) {
    selectedProducts.remove(product);
    GetStorage().write('shopping_bag', selectedProducts);
    getTotal();
  }

  void getTotal() {
    total.value = 0.0;
    selectedProducts.forEach((product) {
      total.value = total.value +
          (product.quantity ?? 1 * double.parse(product.price ?? ''));
    });
  }
}
