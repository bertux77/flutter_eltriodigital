import 'package:eltriodigital_flutter/src/models/response_api.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:get/get.dart';

class UtilsController extends GetxController {
  UsersProvider usersProvider = UsersProvider();
  Future mandarFuture() async {
    ResponseApi response = await usersProvider.prueba();
    print('responseApi: ${response}');
  }
}
