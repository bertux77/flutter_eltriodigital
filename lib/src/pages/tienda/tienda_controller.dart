import 'package:get/get.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class TiendaPageController extends GetxController{
  Future getProducts() async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: "https://www.nutricioncanarias.com/",
        consumerKey: "ck_d00e8de97d2957fd5d021380681c3e7d7444b1c1",
        consumerSecret: "cs_71abbf9e1641d1b44ee06c777c8ab202cd97a0b7");

    // Get data using the "products" endpoint
    
    var products = await wooCommerceAPI.getAsync("products?per_page=100");
    return products;
  }
}