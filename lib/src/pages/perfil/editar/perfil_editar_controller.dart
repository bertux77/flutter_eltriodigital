import 'dart:io';
import 'package:eltriodigital_flutter/src/models/response_api.dart';
import 'package:eltriodigital_flutter/src/models/user.dart';
import 'package:eltriodigital_flutter/src/pages/perfil/info/perfil_info_controller.dart';

import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../providers/users_providers.dart';

class PerfilEditarController extends GetxController {
  User user = User.fromJson(GetStorage().read('user'));
  //name,direccion,poblacion,cp,provincia,telefono
  TextEditingController nameController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController poblacionController = TextEditingController();
  TextEditingController cpController = TextEditingController();
  TextEditingController provinciaController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  //IMAGE PICKER

  ImagePicker picker = ImagePicker();
  File? imageFile;

  UsersProvider usersProvider = UsersProvider();

  //PerfilInfoController perfilInfoController = Get.find();

  PerfilEditarController() {
    //name,direccion,poblacion,cp,provincia,telefono
    nameController.text = user.name ?? '';
    direccionController.text = user.direccion ?? '';
    poblacionController.text = user.poblacion ?? '';
    cpController.text = user.cp ?? '';
    provinciaController.text = user.provincia ?? '';
    telefonoController.text = user.telefono ?? '';
  }

  void updateInfo(BuildContext context) async {
    String name = nameController.text;
    String direccion = direccionController.text;
    String poblacion = poblacionController.text;
    String cp = cpController.text;
    String provincia = provinciaController.text;
    String telefono = telefonoController.text;

    if (isValidForm(
      name,
      direccion,
      poblacion,
      cp,
      provincia,
      telefono,
    )) {
      //PROGRES DIALOG ABRIMOS
      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Mandanga!');
      //name,direccion,poblacion,cp,provincia,telefono
      User myUser = User(
          id: user.id,
          name: name,
          direccion: direccion,
          poblacion: poblacion,
          cp: cp,
          provincia: provincia,
          telefono: telefono,
          sessionToken: user.sessionToken);

      if (imageFile == null) {
        ResponseApi responseApi =
            await usersProvider.actualizarPerfilSinImagen(myUser);
        Get.snackbar('Proceso terminado', responseApi.message ?? '');
        if (responseApi.success == true) {
          GetStorage().write('user', responseApi.data);
          //PerfilInfoController.user
          // clientProfileInfoController.user.value =
          //     User.fromJson(GetStorage().read('user') ?? {});
        }
      } else {
        print(imageFile);
        // Stream stream = await usersProvider.updateWithImage(myUser, imageFile!);
        // stream.listen((res) {
        //   //PROGRES DIALOG CERRAMOS
        //   //progressDialog.close();

        //   ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
        //   Get.snackbar('Proceso terminado', responseApi.message ?? '');
        //   print('Respuesta del backend: mandanga: ${responseApi.data}');
        //   if (responseApi.success == true) {
        //     GetStorage().write('user', responseApi.data[0]);
        //     clientProfileInfoController.user.value =
        //         User.fromJson(GetStorage().read('user') ?? {});
        //   } else {
        //     Get.snackbar('Registro error', responseApi.message ?? '');
        //   }
        // });
      }

      progressDialog.close();
    }
  }

  void goToHomePage() {
    Get.offNamedUntil('/client/products/list', (route) => false);
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
      },
      child: const Text(
        'GALERÍA',
        style: TextStyle(color: Colors.white),
      ),
    );

    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera);
      },
      child: const Text(
        'CÁMARA',
        style: TextStyle(color: Colors.white),
      ),
    );
    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecciona una opción'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  bool isValidForm(
    //name,direccion,poblacion,cp,provincia,telefono
    String name,
    String direccion,
    String poblacion,
    String cp,
    String provincia,
    String phone,
  ) {
    return true;
    if (name.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu nombre');
      return false;
    }
    if (direccion.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu dirección');
      return false;
    }
    if (poblacion.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu población');
      return false;
    }
    if (cp.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu código postal');
      return false;
    }
    if (provincia.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar tu provincia');
      return false;
    }
    if (phone.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes poner tu télefono');
      return false;
    }
    return true;
  }
}
