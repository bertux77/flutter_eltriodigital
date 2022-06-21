import 'package:eltriodigital_flutter/src/environment/environment.dart';
import 'package:eltriodigital_flutter/src/models/response_api.dart';
import 'package:eltriodigital_flutter/src/models/user.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PerfilPageController extends GetxController {
  String url = Environment.API_URL + 'api';
  User user = User.fromJson(GetStorage().read('user') ?? {});
  UsersProvider usersProvider = UsersProvider();
  double wallet = 0.0;

  String _scanBarcode = 'Unknown';
  //CONSTRUCTOR
  PerfilPageController() {}

  Future<void> scanBar() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print('Codigo escaneado: $barcodeScanRes');

      try {
        var codigo = int.parse(barcodeScanRes);
        var result = (codigo / 10001 / 24 / 13);
        print('resultado: $result');
        ResponseApi resultado = await usersProvider.obtenerBeneficio(result);

        if (resultado.success == true) {
          goToBeneficioPage(resultado.data);
        } else {
          Get.snackbar('ERROR', resultado.message ?? '',
              icon: const Icon(Icons.dangerous, color: Colors.red),
              snackPosition: SnackPosition.TOP,
              colorText: Colors.red,
              backgroundColor: Colors.white);
        }
      } on FormatException {
        Get.snackbar('ERROR', 'CÓDIGO NO VALIDO',
            icon: const Icon(Icons.dangerous, color: Colors.red),
            snackPosition: SnackPosition.TOP,
            colorText: Colors.red,
            backgroundColor: Colors.white);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  void goToPerfilPedidosPage() {
    Get.toNamed('/perfil/pedidos');
  }

  void goToPerfilShowQrPage() {
    Get.toNamed('/perfil/showqr');
  }

  void goToPerfilInfoPage() {
    Get.toNamed('/perfil/info');
  }

  void goToPerfilEditarPage() {
    Get.toNamed('/perfil/editar');
  }

  void goToBeneficioPage(beneficio) {
    Get.toNamed('/canjeo', arguments: {'beneficio': beneficio});
  }

  void goToPedidosPage(pedidoId) {
    Get.toNamed('tienda/pedidos/detalle', arguments: {'pedidoId': pedidoId});
  }

  void totalWallet() async {
    ResponseApi responseApi = await usersProvider.totalWallet();
    if (responseApi.success == true) {
      wallet = responseApi.data;
    } else {
      Get.snackbar('ERROR', responseApi.message ?? '');
    }
  }
}
