import 'package:eltriodigital_flutter/src/models/categoria.dart';
import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:get/get.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class TiendaPageController extends GetxController {
  List<Categoria> listaCategorias = [];
  List<Producto> listaProductos = [];
  TiendaPageController() {
    obtenerCategorias();
  }

  void goToProductoPage(producto) {
    Get.toNamed('/producto', arguments: {'producto': producto});
  }

  Future obtenerCategorias() async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://www.nutricioncanarias.com/",
        consumerKey: "ck_d00e8de97d2957fd5d021380681c3e7d7444b1c1",
        consumerSecret: "cs_71abbf9e1641d1b44ee06c777c8ab202cd97a0b7");
    var categories = await wooCommerceAPI
        .getAsync("products/categories?per_page=20") as List;

    // MAPEAMOS RESPUESTA
    listaCategorias =
        categories.map((item) => Categoria.fromJson(item)).toList();

    return categories;
  }

  Future getProduct(int idCategory) async {
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://www.nutricioncanarias.com/",
        consumerKey: "ck_d00e8de97d2957fd5d021380681c3e7d7444b1c1",
        consumerSecret: "cs_71abbf9e1641d1b44ee06c777c8ab202cd97a0b7");

    var productos = await wooCommerceAPI.getAsync(
        "products?in_stock=true&category=${idCategory}&per_page=50") as List;

    // MAPEAMOS RESPUESTA
    listaProductos = productos.map((item) => Producto.fromJson(item)).toList();
    // print('listaProducts: $listaProductos');
    return listaProductos;
  }
}
