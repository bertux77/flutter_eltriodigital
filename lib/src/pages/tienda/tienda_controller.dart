import 'dart:convert';

import 'package:eltriodigital_flutter/src/models/categoria.dart';
import 'package:get/get.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class TiendaPageController extends GetxController {
  List<Categoria> listaCategorias = [];
  TiendaPageController() {
    getProducts();
  }

  Future getProducts() async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://www.nutricioncanarias.com/",
        consumerKey: "ck_d00e8de97d2957fd5d021380681c3e7d7444b1c1",
        consumerSecret: "cs_71abbf9e1641d1b44ee06c777c8ab202cd97a0b7");

    // Get data using the "products" endpoint

    var products = await wooCommerceAPI.getAsync("products");
    var categories =
        await wooCommerceAPI.getAsync("products/categories") as List;

    // MAPEAMOS RESPUESTA
    listaCategorias =
        categories.map((item) => Categoria.fromJson(item)).toList();

    //print(listaCategorias);
    return products;
  }

  Future getProduct(int idCategory) async {
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://www.nutricioncanarias.com/",
        consumerKey: "ck_d00e8de97d2957fd5d021380681c3e7d7444b1c1",
        consumerSecret: "cs_71abbf9e1641d1b44ee06c777c8ab202cd97a0b7");

    var productos = await wooCommerceAPI
        .getAsync("products?category=${idCategory}&stock_status='instock'");
    // print('mandangax: ${productos}');
    return productos;
  }
}
