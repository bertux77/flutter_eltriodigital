import 'package:eltriodigital_flutter/src/environment/environment.dart';
import 'package:eltriodigital_flutter/src/models/response_api.dart';
import 'package:eltriodigital_flutter/src/models/user.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PerfilPageController extends GetxController {
  String url = Environment.API_URL + 'api';
  User user = User.fromJson(GetStorage().read('user') ?? {});
  UsersProvider usersProvider = UsersProvider();
  double wallet = 0.0;
  PerfilPageController() {
    //totalWallet();
    // print('constructor');
  }

  void goToPedidosPage(pedidoId) {
    //print('mandanga!');
    //Get.toNamed("/pedidos");
    Get.toNamed('tienda/pedidos/detalle', arguments: {'pedidoId': pedidoId});
  }

  void totalWallet() async {
    ResponseApi responseApi = await usersProvider.totalWallet();
    if (responseApi.success == true) {
      wallet = responseApi.data;
      print('wallet ${wallet}');
    } else {
      Get.snackbar('ERROR', responseApi.message ?? '');
    }
  }
}
