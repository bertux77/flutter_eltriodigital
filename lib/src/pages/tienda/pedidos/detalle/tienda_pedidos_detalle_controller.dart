import 'package:eltriodigital_flutter/src/models/pedido.dart';
import 'package:eltriodigital_flutter/src/models/response_api.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:get/get.dart';

class TiendaPedidosDetalleController extends GetxController {
  TiendaPedidosDetalleController() {
    //final pedidoId = Get.arguments['pedidoId'];
    pedidoDetalle();
  }

  //var pedidoId = 0;
  //var numeroFactura = '0'.obs;
  //final numeroFactura = 0.obs;
  var pedido = Pedido().obs;
  bool isLoading = false;
  UsersProvider usersProvider = UsersProvider();

  void pedidoDetalle() async {
    isLoading = true;
    ResponseApi responseApi =
        await usersProvider.pedidoDetalle(Get.arguments['pedidoId']);
    if (responseApi.success == true) {
      //numeroFactura.value = responseApi.data['id'];
      pedido.value = Pedido.fromJson(responseApi.data);

      isLoading = false;
      update();
      //return responseApi;
      //print('Respuestax : ${pedido.toJson()}');
    } else {
      Get.snackbar('ERROR', responseApi.message ?? '');
    }
  }
}
