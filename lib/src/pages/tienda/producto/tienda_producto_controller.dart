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
  String name;
  bool variation;
  List<String> options;
  List<Map<String, List<String>>>? disponibles;
  SelectVariaciones(
      {required this.id,
      required this.name,
      required this.variation,
      required this.options,
      this.disponibles});
}

class TiendaProductoController extends GetxController {
  //RxList<Models> myList = <Models>[].obs;
  List<p.Producto> selectedProducts = [];
  List<ProductoVariaciones> variaciones = <ProductoVariaciones>[].obs;
  var producto = p.Producto();
  var isLoading = true.obs;
  List<Attribute> atributos = [];
  Map<int?, List<Attribute>> opciones = {};

  // VAMOS A INTENTAR CONSTRUIR EL RESULTADO FANIL PARA PONERLO A PRUEBA
  // It is mandatory initialize with one value from listType

  Map<int, String> selectValue = {
    0: "Selecciona una opción",
    1: "Selecciona una opción"
  };
  List<SelectVariaciones> selectVariaciones = [
    SelectVariaciones(
      id: 1, 
      name: "Sabor", 
      variation: true, 
      options: [
      "Fresa",
      "Chocolate",
      "Vainilla",
      ], 
    disponibles: [
      {
        'Fresa': ["Selecciona una opción","1 kg"]
      },
      {
        'Chocolate': ["Selecciona una opción", "1 Kg", "2 Kg"]
      },
      {
        'Vainilla': ["Selecciona una opción","2 Kg"]
      },
    ]),
    SelectVariaciones(
        id: 2, // id del atributo
        name: "Tamaño",
        variation: true,
        options: [
          "1 Kg",
          "2 Kg",
        ],
        disponibles: [
          {
            '1 Kg': ["Selecciona una opción","Fresa", "Chocolate"]
          },
          {
            '2 Kg': ["Selecciona una opción","Vainilla", "Chocolate"]
          },
        ]),
  ];

  TiendaProductoController() {
    //print('Mandanga: $selectVariaciones');
    producto = Get.arguments['producto'];
    //print('Producto: ${producto.toJson()}');
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

  void cambiarVariaciones(String value, int index) {
    selectValue[index] = value;
    int indiceDropAlternativo;
    // cambiar el selectVariaciones del indix anterior o posterior
    if(index == 0){
      indiceDropAlternativo = 1;
    }else {
      indiceDropAlternativo = 0;
    }

    selectVariaciones[index].disponibles?.forEach((element) {

        //print(element["$value"]);
      if(element["$value"] != null){
        print(element["$value"]);
        selectVariaciones[indiceDropAlternativo].options = element["$value"]!;
      }
    });

    update();
  }

  Future obtenerVariaciones() async {
    int id = producto.id!;
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://www.nutricioncanarias.com/",
        consumerKey: "ck_d00e8de97d2957fd5d021380681c3e7d7444b1c1",
        consumerSecret: "cs_71abbf9e1641d1b44ee06c777c8ab202cd97a0b7");

    var variacionesResp =
        await wooCommerceAPI.getAsync("products/${id}/variations") as List;

    // MAPEAMOS RESPUESTA DE LAS VARIACIONES
    variaciones = variacionesResp
        .map((item) => ProductoVariaciones.fromJson(item))
        .toList();

    // RESPUESTA API VARIACIONES:
    //HAY QUE OBTENER LOS VALORES DISPONIBLES EN LOS TAMAÑOS Y EN LOS SABORES

    // DE AQUI DEBERIA SALIR UN ARRAY ASOCIATIVO
    // [
    //    "1KG": ["FRESA", "CHOCOLATE"]
    //    "2KG": ["FRESA"]
    //    "CHOCOLATE": ["1KG, 2KG"]
    //    "FRESA": ["2KG"]

    //MAPEMOS DEL PRODUCTO INICIAL
    for (var atributo in producto.attributes!) {
      //El atributo se utiliza para generar variaciones
      if (atributo.variation == true) {
        List disponibles = [];
        //API
        variaciones.forEach((variacion) {
          variacion.attributes?.forEach((variacion) {
            if (variacion.id == atributo.id) {
              //print('variacion: ${variacion.name} - ')
            }
          });
        });

        //MAPEAMOS EL SELECTVARIACIONES
        // selectVariaciones.add(SelectVariaciones(
        //     id: atributo.id!,
        //     name: atributo.name!,
        //     variation: atributo.variation!,
        //     options: atributo.options!));
      }
    }
    //print('Select variaciones: $selectVariaciones');

    // atributos.forEach((element) {
    //   print('atributo: ${element.toJson()}');
    // });

    // variaciones.forEach((element) {
    //   print(element.toJson());
    // });
    //  final ids = Set();
    //  atributos.retainWhere((x) => ids.add(x.id));
    //print('ids: $ids');

    // opciones = groupBy(atributos, (Attribute e) {
    //   return e.id;
    // });

    // print('opciones:  $opciones');

    // opciones.forEach((key, value) {
    //   print('key: ${key}: value: ${value[1].toJson()}');
    // });

    // opciones.map((val) {
    //   String idx = opciones.indexOf(val);
    //   return something;
    // }

    // var newMap = groupBy(atributos, (Map obj) => obj['release_date'])
    //     .map((k, v) => MapEntry(
    //         k,
    //         v.map((item) {
    //           item.remove('release_date');
    //           return item;
    //         }).toList()));
    // List<String> items = List.generate(
    //     opciones.length, (index) => '${opciones[0][index].name}');

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
