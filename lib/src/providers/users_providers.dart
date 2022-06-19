import 'package:eltriodigital_flutter/src/environment/environment.dart';
import 'package:eltriodigital_flutter/src/models/response_api.dart';
import 'package:flutter/material.dart';
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

  // SIN FOTO
  Future<ResponseApi> actualizarPerfilSinImagen(User user) async {
    Response response = await put(
        '${url}/actualizar-perfil-sin-imagen', user.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user.sessionToken}'
        });

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo actualizar la información');
      return ResponseApi();
    }

    if (response.body is String) {
      Get.snackbar('Error', 'No se ha podido actualizar los datos',
          icon: const Icon(Icons.dangerous, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
          backgroundColor: Colors.white);
      return ResponseApi();
    }

    if (response.statusCode == 401) {
      Get.snackbar('Error', 'No estas autorizado');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  // OBTENER PEDIDO Y PRODUCTOS VENDIDOS SOBRE UN ID
  Future<ResponseApi> obtenerBeneficio(pedidoId) async {
    ///canjear-venta/{idVenta}
    Response response = await get('$url/canjear-venta/$pedidoId', headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${user.sessionToken}'
    });

    if (response.body == null) {
      Get.snackbar('Error', 'No se ha podido ejecutar la petición',
          icon: const Icon(Icons.dangerous, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
          backgroundColor: Colors.white);
      //return ResponseApi();
    }
    //print('Response body: $url/pedidos/$pedidoId');
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  // OBTENER PEDIDO Y PRODUCTOS VENDIDOS SOBRE UN ID
  Future<ResponseApi> pedidoDetalle(pedidoId) async {
    Response response = await get('$url/pedidos/$pedidoId', headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${user.sessionToken}'
    });

    if (response.body == null) {
      Get.snackbar('Error', 'No se ha podido ejecutar la petición',
          icon: const Icon(Icons.dangerous, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
          backgroundColor: Colors.white);
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
      Get.snackbar('Error', 'No se ha podido ejecutar la petición',
          icon: const Icon(Icons.dangerous, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
          backgroundColor: Colors.white);
      return ResponseApi();
    }

    if (response.body is String) {
      Get.snackbar('Error', 'No se ha podido actualizar los datos',
          icon: const Icon(Icons.dangerous, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
          backgroundColor: Colors.white);
      return ResponseApi();
    }
    //print('Respuesta cargar Wallet: ${response.body}');
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
    //return ResponseApi();
  }

  // LISTADO DE OPERACIONES DEL WALLET DE FORMA CRONOLOGICA
  Future<ResponseApi> cargarWallet() async {
    Response response = await get('$url/listar-wallets', headers: {
      'Content-type': 'application/json',
      'Authorization': 'Bearer ${user.sessionToken}'
    });

    if (response.body == null) {
      Get.snackbar('Error', 'No se ha podido ejecutar la petición',
          icon: const Icon(Icons.dangerous, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
          backgroundColor: Colors.white);
      return ResponseApi();
    }
    if (response.body is String) {
      Get.snackbar('Error', 'No se ha podido actualizar los datos',
          icon: const Icon(Icons.dangerous, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
          backgroundColor: Colors.white);
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
      Get.snackbar('Error', 'No se ha podido ejecutar la petición',
          icon: const Icon(Icons.dangerous, color: Colors.red),
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
          backgroundColor: Colors.white);
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}
