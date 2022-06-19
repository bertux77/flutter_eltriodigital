import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/user.dart';

class PerfilInfoController extends GetxController {
  var user = User.fromJson(GetStorage().read('user') ?? {}).obs;

  void goToProfileUpdate() {
    Get.toNamed('/perfil/editar');
  }

  void goToRoles() {
    Get.offNamedUntil('/roles', (route) => false);
  }
}
