import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:eltriodigital_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class TiendaProductoController extends GetxController {
  List<Producto> selectedProducts = [];
  int id = Get.arguments['id'];

  TiendaProductoController() {
    var logger = Logger(
      filter: null,
      printer: PrettyPrinter(),
      output: null,
    );
    print(
        'cuando cargamos la pagina de producto Gestorage es: $selectedProducts');
    selectedProducts.forEach((element) {
      logger.d(element.toJson());
    });
    obtenerProducto();
    if (GetStorage().read('shopping_bag') != null) {
      var result = GetStorage().read('shopping_bag');
      selectedProducts.clear();
      selectedProducts.addAll(result);
      // if (GetStorage().read('shopping_bag') is List<Producto>) {
      //   // var result = GetStorage().read('shopping_bag');
      //   // selectedProducts.clear();
      //   // selectedProducts.addAll(result);
      //   print('Pantalla producto if');
      // } else {
      //   print('pantalla producto else');
      //   // var result = Producto.fromJsonList(GetStorage().read('shopping_bag'));
      //   // selectedProducts.clear();
      //   // selectedProducts.addAll(result);
      // }
    }
  }

  Future<Producto> obtenerProducto() async {
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://www.nutricioncanarias.com/",
        consumerKey: "ck_d00e8de97d2957fd5d021380681c3e7d7444b1c1",
        consumerSecret: "cs_71abbf9e1641d1b44ee06c777c8ab202cd97a0b7");

    var productoResp = await wooCommerceAPI.getAsync("products/$id");

    // MAPEAMOS RESPUESTA
    Producto producto = Producto.fromJson(productoResp);
    //print('Producto recibido: ${producto.toJson()}');
    return producto;
  }

  void addToBag(Producto product, var price, var counter) {
    if (counter.value > 0) {
      //validar si el producto ya estaba en el carrito
      int index = selectedProducts.indexWhere((p) => p.id == product.id);
      if (index == -1) {
        //NO ESTABA AGREGADO
        if (counter.value > 0) {
          product.quantity = counter.value;
        } else {
          product.quantity = 1;
        }

        selectedProducts.add(product);
      } else {
        //EL PRODUCTO YA ESTA EN ESTORAGE
        selectedProducts[index].quantity = counter.value;
      }

      print('antes de escribir el selectedProducts:');
      var logger = Logger(
        filter: null,
        printer: PrettyPrinter(),
        output: null,
      );

      selectedProducts.forEach((element) {
        logger.d(element.toJson());
      });
      // logger.d(selectedProducts[0].toJson());

      GetStorage().write('shopping_bag', selectedProducts);
      goToCarritoPage();
      Utils.snackBarOk('Carrito', 'Producto agregado al carrito');
    }
  }

  void goToCarritoPage() {
    Get.toNamed('tienda/carrito');
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
