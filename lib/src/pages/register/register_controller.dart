import 'package:eltriodigital_flutter/src/models/user.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToLogin(){
     Get.toNamed('/login');
  }

  void register() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmpassword = confirmpasswordController.text.trim();
    String name = nameController.text;

    // print('Email ${email}');
    // print('Contraseña ${password}');

    if(isValidForm(email, password, confirmpassword, name)){

      //Creamos el objeto User con los parametros que vienen desde el formulario
      User user = User(
        email: email,
        name: name,
        password: password,
      );
      //Enviamos la señal al provider y esperamos la respuesta
      Response response = await usersProvider.registro(user);

      //print('Respuesta del backend: ${response.body}');
    }
  }

  bool isValidForm(String email, String password, String confirmPassword, String name){

    if(name.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar un nombre');
      return false;
    }

    if(email.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }

    if(!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no valido', 'email no valido');
      return false;
    }

    if(password.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes ingresar la contraseña');
      return false;
    }

    if(confirmPassword.isEmpty){
      Get.snackbar('Formulario no valido', 'Debes confirmar la contraseña ');
      return false;
    }

    if(password != confirmPassword){
      Get.snackbar('Formulario no valido', 'Las contraseñas no coinciden');
      return false;
    }

    
    return true;
  }
}