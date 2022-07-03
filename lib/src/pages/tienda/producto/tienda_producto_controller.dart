import 'package:collection/collection.dart';
import 'package:eltriodigital_flutter/src/models/atributo.dart';
import 'package:eltriodigital_flutter/src/models/producto.dart' as p;
import 'package:eltriodigital_flutter/src/models/producto_variaciones.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

//CLASE DONDE GUARDAREMOS LAS VARIACIONES DEL PRODUCTO VARIABLE
class SelectVariaciones {
  int id;
  String? sku;
  String price;
  String? regularPrice;
  String? salePrice;
  bool onSale;
  bool? manageStock;
  int? stockQuantity;
  String name;

  SelectVariaciones(
      {required this.id,
      this.sku,
      required this.price,
      this.regularPrice,
      this.salePrice,
      required this.onSale,
      this.manageStock,
      this.stockQuantity,
      required this.name});
}

class TiendaProductoController extends GetxController {
  List<p.Producto> selectedProducts = [];
  List<ProductoVariaciones> variaciones = <ProductoVariaciones>[].obs;
  var producto = p.Producto();
  var isLoading = true.obs;
  List<Attribute> atributos = [];
  Map<int?, List<Attribute>> opciones = {};
  List<SelectVariaciones> disponibles = [];
  List<String> opcionesDisponible = [];
  String selectValue = "Selecciona una opción";

  List<SelectVariaciones> selectVariaciones = [];

  TiendaProductoController() {
    producto = Get.arguments['producto'];
    //print('producto id: ${producto.id}');
    if (producto.type == "variable") {
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
  }

  void cambiarVariaciones(String value) {
    //print('Cuantos dropdown hay: ${selectVariaciones.length}');
    selectValue = value;
    update();
    // int indiceDropAlternativo;
    // cambiar el selectVariaciones del indix anterior o posterior

    // if (selectVariaciones.length == 1) {
    //   // SOLO HAY UN DROPDOWN
    //   selectVariaciones[index].options = disponibles1;
    // } else if (selectVariaciones.length == 2) {
    //   // HAY 2
    //   List<String> resultado = [];
    //   // BUSCAMOS EL INDICE DEL DROPDOWN SIGUIENTE
    //   // Y BUSCAMOS DENTRO DE DISPONIBLES2 LAS OPCIONES QUE COINCIDEN
    //   if (index == 0) {
    //     // EL DROPDOWN SELECCIONADO ES EL PRIMERO(TAMAÑO) POR LO QUE HAY QUE BUSCAR SUS OPCIONES EN EL SEGUNDO(SABOR)
    //     indiceDropAlternativo = 1;
    //     disponibles2.forEach((element) {
    //       if (element["$value"] != null) {
    //         String? valor = element["$value"];
    //         resultado.add(valor!);
    //       }
    //     });
    //     selectVariaciones[indiceDropAlternativo].options = resultado;
    //   } else {
    //     indiceDropAlternativo = 0;
    //     disponibles2.forEach((element) {
    //       if(element[] == );
    //     });
    //   }

    //print('disponibles 2: ${disponibles2}');
    //print('value: ${value}');

    // selectVariaciones[indiceDropAlternativo].options?.forEach((element) {
    //   if (element["$value"] != null) {
    //     selectVariaciones[indiceDropAlternativo].options = element["$value"]!;
    //   }
    // });
    // }

    // update();
  }

  Future obtenerVariaciones() async {
    int id = producto.id!;
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://www.nutricioncanarias.com/",
        consumerKey: "ck_d00e8de97d2957fd5d021380681c3e7d7444b1c1",
        consumerSecret: "cs_71abbf9e1641d1b44ee06c777c8ab202cd97a0b7");

    var variacionesResp =
        await wooCommerceAPI.getAsync("products/${id}/variations") as List;

    // API MAPEAMOS RESPUESTA DE LAS VARIACIONES
    variaciones = variacionesResp
        .map((item) => ProductoVariaciones.fromJson(item))
        .toList();

    // RESPUESTA API VARIACIONES:
    //HAY QUE OBTENER LOS VALORES DISPONIBLES EN LOS TAMAÑOS Y EN LOS SABORES
    variaciones.forEach((variacion) {
      // UTILIZAREMOS EL KEY VALUE PARA CREAR EL MAPA EN LOS DISPONIBLES 2
      var key = '';
      var value = '';
      String linea = '';
      variacion.attributes?.forEach((atributo) {
        // PASA 1 o 2 VECES: 1 TAMAÑO: 2KG, OTRA SABOR: CHOCOLATE
        // ATRIBUTOS [{id:1, name:"tamaño", option:"1 Kg"}, {id:2, name:"sabor", option:"chocolate"}]
        if (variacion.attributes!.length == 1) {
          // UNA OPCION
          //disponibles.add('${atributo.option});
          linea = '${atributo.option}';
        } else {
          // DE AQUI TENEMOS QUE SALIR CON UNA LINEA POR VARIACION, LA LINEA QUEDARIA ASI:
          //{"1KG": "CHOCOLATE"}
          if (key == '') {
            key = '${atributo.option}';
          } else {
            value = '${atributo.option}';
            linea = '$key : $value';
            //opcionesDisponible.add(linea);
          }
        }
      });

      //opcionesDisponible.sort();
      //opcionesDisponible.insert(0, "Selecciona una opción");

      //MAPEAMOS LA RESPUESTA CORRECTA
      selectVariaciones.add(SelectVariaciones(
        id: variacion.id!,
        sku: variacion.sku,
        price: variacion.price ?? '',
        regularPrice: variacion.regularPrice,
        salePrice: variacion.salePrice,
        onSale: variacion.onSale ?? false,
        manageStock: variacion.manageStock,
        stockQuantity: variacion.stockQuantity,
        name: linea,
      ));
    });

    // ORDENAR
    selectVariaciones.sort((a, b) => a.name.compareTo(b.name));
    update();
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
