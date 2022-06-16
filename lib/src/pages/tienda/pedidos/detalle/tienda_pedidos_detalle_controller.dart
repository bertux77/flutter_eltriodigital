import 'package:eltriodigital_flutter/src/models/response_api.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:get/get.dart';

class TiendaPedidosDetalleController extends GetxController {
  var pedidoId = 0;
  var numeroFactura = '0'.obs;
  UsersProvider usersProvider = UsersProvider();
  TiendaPedidosDetalleController() {
    pedidoId = Get.arguments['pedidoId'];
    pedidoDetalle(pedidoId);
  }

 void pedidoDetalle(pedidoId) async{
    ResponseApi responseApi = await usersProvider.pedidoDetalle(pedidoId);
    if (responseApi.success == true) {
      numeroFactura.value = '';
      numeroFactura.value = responseApi.data['id'].toString();
    } else {
      Get.snackbar('ERROR', responseApi.message ?? '');
    }
  }

}
