import 'package:collection/collection.dart';
import 'package:eltriodigital_flutter/src/models/atributo.dart';
import 'package:eltriodigital_flutter/src/models/producto.dart' as p;
import 'package:eltriodigital_flutter/src/models/producto_variaciones.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class TiendaProductoController extends GetxController {
  //RxList<Models> myList = <Models>[].obs;
  List<p.Producto> selectedProducts = [];
  List<ProductoVariaciones> variaciones = <ProductoVariaciones>[].obs;
  var producto = p.Producto();
  var isLoading = true.obs;
  List<Attribute> atributos = [];
  Map<int?, List<Attribute>> opciones = {};

  TiendaProductoController() {
    producto = Get.arguments['producto'];
    print('Producto id: ${producto.id}');
    if (producto.type == "variable") {
      // llamada a la api para obtener las variaciones
      obtenerVariaciones();
    }
    update();
    if (GetStorage().read('shopping_bag') != null) {
      if (GetStorage().read('shopping_bag') is List<p.Producto>) {
        // SIEMPRE ENTRA AQUI
        var result = GetStorage().read('shopping_bag');
        selectedProducts.clear();
        selectedProducts.addAll(result);
      } else {
        var result = p.Producto.fromJsonList(GetStorage().read('shopping_bag'));
        selectedProducts.clear();
        selectedProducts.addAll(result);
      }
    }

    // var logger = Logger(
    //    filter: null,
    //    printer: PrettyPrinter(),
    //    output: null,
    //  );
    //  print(
    //      'cuando cargamos la pagina de producto Gestorage es: $selectedProducts');
    //  selectedProducts.forEach((element) {
    //    logger.d(element.toJson());
    //  });
  }

  Future obtenerVariaciones() async {
    int id = producto.id!;
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
         url: "https://www.nutricioncanarias.com/",
         consumerKey: "ck_d00e8de97d2957fd5d021380681c3e7d7444b1c1",
         consumerSecret: "cs_71abbf9e1641d1b44ee06c777c8ab202cd97a0b7");

    var variacionesResp = await wooCommerceAPI.getAsync("products/${id}/variations") as List;

     // MAPEAMOS RESPUESTA
    variaciones = variacionesResp.map((item) => ProductoVariaciones.fromJson(item)).toList();
    
   
    variaciones.forEach((variacion) { 
      variacion.attributes?.forEach((element) { 
        atributos.add(element);
      });
    });

    // atributos.forEach((element) { 
    //   print('atributo: ${element.toJson()}');
    // });

    // variaciones.forEach((element) {
    //   print(element.toJson());
    // });
    //  final ids = Set();
    //  atributos.retainWhere((x) => ids.add(x.id));
     //print('ids: $ids');

     opciones = groupBy(atributos, (Attribute e) {
        return e.id;
      });
    
    
    
    
    
  //   //producto.refresh();
  //   isLoading.value = false;
  //   update();
  //   //print('controller: ${producto.value}');
   }

  void addToBag(p.Producto product, var price, var counter) {
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

      // print('antes de escribir el selectedProducts:');
      // var logger = Logger(
      //   filter: null,
      //   printer: PrettyPrinter(),
      //   output: null,
      // );

      // selectedProducts.forEach((element) {
      //   logger.d(element.toJson());
      // });
      // logger.d(selectedProducts[0].toJson());

      GetStorage().write('shopping_bag', selectedProducts);
      goToCarritoPage();
      //Utils.snackBarOk('Carrito', 'Producto agregado al carrito');
    }
  }

  void goToCarritoPage() {
    Get.toNamed('tienda/carrito');
  }

  void addItem(p.Producto product, var price, var counter) {
    counter.value = counter.value + 1;
    price.value = double.parse(product.price!) * counter.value;
    //print('valor: ${product.toJson()}');
  }

  void removeItem(p.Producto product, var price, var counter) {
    if (counter.value > 1) {
      counter.value = counter.value - 1;
      price.value = double.parse(product.price!) * counter.value;
    }
  }
}
