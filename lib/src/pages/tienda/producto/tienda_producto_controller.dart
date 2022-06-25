import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:get/get.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class TiendaProductoController extends GetxController {
  //Get.arguments['pedidoId']
  int id = Get.arguments['id'];

  TiendaProductoController() {
    obtenerProducto();
  }

  Future<Producto> obtenerProducto() async {
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://www.nutricioncanarias.com/",
        consumerKey: "ck_d00e8de97d2957fd5d021380681c3e7d7444b1c1",
        consumerSecret: "cs_71abbf9e1641d1b44ee06c777c8ab202cd97a0b7");
    
    var productoResp = await wooCommerceAPI.getAsync("products/$id");

    // MAPEAMOS RESPUESTA
    Producto producto = Producto.fromJson(productoResp);
    //print('Producto recibido: $producto');
    return producto;
  }


  void addToBag(Producto product, var price, var counter) {
    // if (counter.value > 0) {
    //   //validar si el producto ya estaba en el carrito
    //   int index = selectedProducts.indexWhere((p) => p.id == product.id);
    //   if (index == -1) {
    //     // NO ESTABA AGREGADO
    //     if (product.quantity == null) {
    //       if (counter.value > 0) {
    //         product.quantity = counter.value;
    //       } else {
    //         product.quantity = 1;
    //       }
    //     }

    //     selectedProducts.add(product);
    //   } else {
    //     // EL PRODUCTO YA ESTA EN ESTORAGE
    //     selectedProducts[index].quantity = counter.value;
    //   }

    //   GetStorage().write('shopping_bag', selectedProducts);
    //   Fluttertoast.showToast(msg: 'Producto agregado');
    // } else {
    //   Fluttertoast.showToast(
    //       msg: 'Debes seleccionar al menos un item para agregar');
    // }
  }

  void addItem(Producto product, var price, var counter) {
    counter.value = counter.value + 1;
    price.value = double.parse(product.price!) * counter.value;
    //print('valor: ${product.toJson()}');
  }

  void removeItem(Producto product, var price, var counter) {
    if (counter.value > 1) {
      counter.value = counter.value - 1;
      price.value = double.parse(product.price!) * counter.value;
    }
  }
}
