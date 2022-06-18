import 'package:get/get.dart';

class TiendaPedidosCanjeoController extends GetxController {
  final beneficio = Get.arguments['beneficio'];

  Future<int> futuroIncierto() async {
    return await Future.delayed(const Duration(seconds: 2), () => 5);
  }

  void goToPerfilPage() {
    Get.offNamed('/perfil');
  }
}
