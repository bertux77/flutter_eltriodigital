import 'package:eltriodigital_flutter/src/models/producto.dart';
import 'package:get/get.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class TiendaProductoController extends GetxController{
  //Get.arguments['pedidoId']
  int id = Get.arguments['id'];

  TiendaProductoController(){
    obtenerProducto();
  }

  Future<Producto> obtenerProducto() async{
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://www.nutricioncanarias.com/",
        consumerKey: "ck_d00e8de97d2957fd5d021380681c3e7d7444b1c1",
        consumerSecret: "cs_71abbf9e1641d1b44ee06c777c8ab202cd97a0b7");
    //var products = await wooCommerceAPI.getAsync("products");
     var productoResp =
         await wooCommerceAPI.getAsync("products/$id");

    Producto producto = Producto.fromJson(productoResp);
    // MAPEAMOS RESPUESTA
    // listaCategorias =
    //     categories.map((item) => Categoria.fromJson(item)).toList();

    print('Producto Recibido: ${producto.toJson()}');
    return producto;
  }

}