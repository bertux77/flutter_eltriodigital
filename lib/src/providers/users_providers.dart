import 'package:eltriodigital_flutter/src/environment/environment.dart';
import 'package:eltriodigital_flutter/src/models/response_api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class UsersProvider extends GetConnect {
  String url = Environment.API_URL + 'api';
  User user = User.fromJson(GetStorage().read('user') ?? {});

  //String url6 =
  // 'https://b4d2-2-141-235-177.eu.ngrok.io/eltriodigital/public/api/prueba';

  Future<Response> prueba() async {
    Response response =
        await get(url, headers: {'Content-type': 'application/json'});
    return response;
  }


  // OBTENER PEDIDO Y PRODUCTOS VENDIDOS SOBRE UN ID
  Future<ResponseApi> pedidoDetalle(pedidoId) async {
    
    Response response = await get('$url/pedidos/$pedidoId', headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${user.sessionToken}'
    });

    if (response.body == null) {
      Get.snackbar('Error', 'No se ha podido ejecutar la petición');
      //return ResponseApi();
    }
    //print('Response body: $url/pedidos/$pedidoId');
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }


  // TOTAL WALLET INDIVIDUAL DE CADA USUARIO
  Future<ResponseApi> totalWallet() async {
    Response response = await get('$url/total-wallet', headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${user.sessionToken}'
    });

    if (response.body == null) {
      Get.snackbar('Error', 'No se ha podido ejecutar la petición');
      //return ResponseApi();
    }
    //print('Respuesta cargar Wallet: ${response.body}');
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  // LISTADO DE OPERACIONES DEL WALLET DE FORMA CRONOLOGICA
  Future<ResponseApi> cargarWallet() async {
    Response response = await get('$url/listar-wallets', headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${user.sessionToken}'
    });

    if (response.body == null) {
      Get.snackbar('Error', 'No se ha podido ejecutar la petición');
      return ResponseApi();
    }
    //print('Respuesta cargar Wallet: ${response.body}');
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    //print(responseApi.toJson());
    return responseApi;
  }

  Future<Response> registro(User user) async {
    Response response = await post('$url/registro', user.toJson(),
        headers: {'Content-type': 'application/json'});

    return response;
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
        '$url/login', {'email': email, 'password': password},
        headers: {'Content-type': 'application/json'});

    if (response.body == null) {
      Get.snackbar('Error', 'No se ha podido ejecutar la petición');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
