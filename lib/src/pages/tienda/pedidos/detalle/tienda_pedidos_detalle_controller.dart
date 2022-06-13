import 'package:get/get.dart';

class TiendaPedidosDetalleController extends GetxController {
  int pedidoId = Get.arguments['pedidoId'];
  TiendaPedidosDetalleController() {
    print('recibimos argumentos: ${pedidoId}');
  }
}
