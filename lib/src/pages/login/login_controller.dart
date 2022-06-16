import 'package:eltriodigital_flutter/src/models/response_api.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void prueba() async {
    Response response = await usersProvider.prueba();
    //print(response.body);
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // print('Email ${email}');
    // print('Contraseña ${password}');

    if (isValidForm(email, password)) {
      ResponseApi responseApi = await usersProvider.login(email, password);
      print('Response Api: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        GetStorage().write('user', responseApi.data);
        goToHomePage();
      } else {
        Get.snackbar('ERROR', responseApi.message ?? '');
      }
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }

  bool isValidForm(String email, String password) {
    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'email no valido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar la contraseña');
      return false;
    }
    return true;
  }
}
