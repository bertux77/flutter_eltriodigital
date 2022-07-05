import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:eltriodigital_flutter/src/models/producto_carrito.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TiendaCarritoController extends GetxController {
  List<ProductoCarrito> selectedProducts = <ProductoCarrito>[].obs;
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
      if (GetStorage().read('shopping_bag') is List<ProductoCarrito>) {
        var result = GetStorage().read('shopping_bag');
        selectedProducts.clear();
        selectedProducts.addAll(result);
        // result.forEach(
        //     (element) => print('if: ${element.name} - ${element.quantity} '));
      } else {
        var result = ProductoCarrito.fromJsonList(GetStorage().read('shopping_bag'));
        // result.forEach(
        //     (element) => print('else: ${element.name} - ${element.quantity} '));
        selectedProducts.clear();
        selectedProducts.addAll(result);
      }
      getTotal();
    }
  }

  void removeItem(ProductoCarrito product) {
    if (product.quantity! > 1) {
      int index = selectedProducts.indexWhere((p) => p.id == product.id);
      selectedProducts.remove(product);
      product.quantity = product.quantity! - 1;
      selectedProducts.insert(index, product);
      GetStorage().write('shopping_bag', selectedProducts);
      getTotal();
    }
  }

  void addItem(ProductoCarrito product) {
    int index = selectedProducts.indexWhere((p) => p.id == product.id);
    selectedProducts.remove(product);
    product.quantity = product.quantity! + 1;
    selectedProducts.insert(index, product);
    GetStorage().write('shopping_bag', selectedProducts);
    getTotal();
  }

  void deleteItem(ProductoCarrito product) {
    selectedProducts.remove(product);
    GetStorage().write('shopping_bag', selectedProducts);
    getTotal();
  }

  void getTotal() {
    total.value = 0.0;
    selectedProducts.forEach((product) {
      total.value = (total.value +
          (product.quantity! * double.parse(product.price ?? '')));
    });
  }

  void goToCheckout() {
    Get.toNamed('tienda/checkout');
  }
}
