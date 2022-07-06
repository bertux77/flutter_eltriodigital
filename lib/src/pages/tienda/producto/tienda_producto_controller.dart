import 'package:eltriodigital_flutter/src/models/producto.dart' as p;
import 'package:eltriodigital_flutter/src/models/producto_carrito.dart';
import 'package:eltriodigital_flutter/src/models/producto_variaciones.dart';
import 'package:eltriodigital_flutter/src/utils/utils.dart';
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
  List<ProductoCarrito> selectedProducts = []; // GESTORAGE CARRITO
  List<ProductoVariaciones> variaciones = <ProductoVariaciones>[].obs;
  var producto = p.Producto();
  var isLoading = true.obs;
  var price = 0.0.obs;
  var counter = 1.obs;
  List<SelectVariaciones> disponibles = [];
  List<String> opcionesDisponible = [];
  String selectValue = "Selecciona una opción";
  SelectVariaciones? seleccionado;
  List<SelectVariaciones> selectVariaciones = [];

  TiendaProductoController() {
    producto = Get.arguments['producto'];
    price.value = double.parse(producto.price ?? '');
    //print('producto id: ${producto.id}');
    if (producto.type == "variable") {
      obtenerVariaciones();
    }
    update();
    if (GetStorage().read('shopping_bag') != null) {
      if (GetStorage().read('shopping_bag') is List<ProductoCarrito>) {
        // SIEMPRE ENTRA AQUI
        var result = GetStorage().read('shopping_bag');
        selectedProducts.clear();
        selectedProducts.addAll(result);
      } else {
        var result =
            ProductoCarrito.fromJsonList(GetStorage().read('shopping_bag'));
        selectedProducts.clear();
        selectedProducts.addAll(result);
      }
    }
  }

  void cambiarVariaciones(SelectVariaciones value) {
    selectValue = value.name; // nombre seleccionado, Limon
    seleccionado = value; // cargamos el modelo entero en el seleccionado
    price.value =
        double.parse(value.price) * counter.value; // modificamos su precio
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

  void addToBag(p.Producto product, SelectVariaciones? variacionEnviada) {
    // if(product.type == "variable" && variacionEnviada == null){
    //   Utils.snackBarError('Carrito', 'Debes seleccionar una opci');
    // }
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

        //MAPEAMOS EL PRODUCTO Y SU VARIACION EN PRODUCTOCARRITO PARA AGREGAR AL LISTADO DEL STORAGE
        Variacion variacion = Variacion();
        if (variacionEnviada != null) {
          variacion = Variacion(
              id: variacionEnviada.id,
              sku: variacionEnviada.sku,
              price: variacionEnviada.price,
              regularPrice: variacionEnviada.regularPrice,
              salePrice: variacionEnviada.salePrice,
              name: variacionEnviada.name,
              quantity: counter.value,
              onSale: variacionEnviada.onSale);
        }

        ProductoCarrito productoCarrito = ProductoCarrito(
          id: product.id,
          name: product.name,
          type: product.type,
          status: product.status,
          sku: product.sku,
          price: product.price,
          regularPrice: product.regularPrice,
          salePrice: product.salePrice,
          onSale: product.onSale,
          stockQuantity: product.stockQuantity,
          parentId: product.parentId,
          quantity: product.quantity,
          image: product.images![0].src,
          variacion: variacion,
        );
        selectedProducts.add(productoCarrito);
      } else {
        //EL PRODUCTO YA ESTA EN ESTORAGE
        selectedProducts[index].quantity = counter.value;
      }
      GetStorage().write('shopping_bag', selectedProducts);
      goToCarritoPage();
      //Utils.snackBarOk('Carrito', 'Producto agregado al carrito');
    }
  }

  void goToCarritoPage() {
    Get.toNamed('tienda/carrito');
  }

  void addItem(precioRecibido) {
    counter.value = counter.value + 1;
    price.value = double.parse(precioRecibido!) * counter.value;
    update();
  }

  void removeItem(precioRecibido) {
    if (counter.value > 1) {
      counter.value = counter.value - 1;
      price.value = double.parse(precioRecibido!) * counter.value;
    }
    //print('valor: ${price.value}');
    update();
  }
}
