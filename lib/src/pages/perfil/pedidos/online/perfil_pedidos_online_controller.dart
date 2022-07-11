import 'package:eltriodigital_flutter/src/environment/environment.dart';
import 'package:eltriodigital_flutter/src/models/response_api.dart';
import 'package:eltriodigital_flutter/src/models/user.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PerfilPedidosOnlineController extends GetxController {
  String url = Environment.API_URL + 'api';
  User user = User.fromJson(GetStorage().read('user') ?? {});
  UsersProvider usersProvider = UsersProvider();

  // Future listarPedidos() async {
  //   ResponseApi responseApi = await usersProvider.listarPedidos();
  //   if (responseApi.success == true) {
  //     // MAPEAMOS LA RESPUESTA
  //   } else {
  //     Get.snackbar('ERROR', responseApi.message ?? '');
  //   }
  // }

  void goToPerfilInfoPage() {
    Get.toNamed('/perfil/info');
  }

  void goToPerfilPage() {
    Get.toNamed('/perfil');
  }

  void goToBeneficioPage(beneficio) {
    Get.toNamed('/canjeo', arguments: {'beneficio': beneficio});
  }

  void goToPedidosPage(pedidoId) {
    Get.toNamed('tienda/pedidos/detalle', arguments: {'pedidoId': pedidoId});
  }
}
