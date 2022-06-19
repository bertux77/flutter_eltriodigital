import 'package:eltriodigital_flutter/src/pages/perfil/editar/perfil_editar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilEditarPage extends StatelessWidget {
  PerfilEditarController con = Get.put(PerfilEditarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Container(
        ///width: double.infinity,
        //height: Theme.of(context).size.height;
        color: Colors.blue[200],
        child: SingleChildScrollView(
          child: Column(
            children: [
              _imageUser(context),
              //_backgroundCover(context),

              _boxForm(context),
              _buttonUpdate(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.topCenter,
        child: GestureDetector(
            onTap: () => con.showAlertDialog(context),
            child: GetBuilder<PerfilEditarController>(
              builder: (value) => CircleAvatar(
                backgroundImage: con.imageFile != null
                    ? FileImage(con.imageFile!)
                    : con.user.image != null
                        ? NetworkImage(con.user.image!)
                        : const AssetImage('assets/img/user_profile.png')
                            as ImageProvider,
                radius: 50,
                backgroundColor: Colors.white,
              ),
            )),
      ),
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.50,
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: const <BoxShadow>[
            BoxShadow(
                //color: Color.fromARGB(255, 37, 50, 73),
                blurRadius: 2,
                offset: Offset(0, 0.75)),
          ]),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldName(),
            _textFieldDireccion(),
            _textFieldPoblacion(),
            _textFieldCp(),
            _textFieldProvincia(),
            _textFieldPhone(),
          ],
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
      child: const Text(
        'EDITAR TU INFORMACIÓN',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Nombre', prefixIcon: Icon(Icons.person_outline)),
      ),
    );
  }

  Widget _textFieldDireccion() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: con.direccionController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Dirección', prefixIcon: Icon(Icons.map)),
      ),
    );
  }

  Widget _textFieldPoblacion() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: TextField(
          controller: con.poblacionController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            hintText: 'Población',
            prefixIcon: Icon(Icons.location_city),
          ),
        ));
  }

  Widget _textFieldCp() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: con.cpController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            hintText: 'Código postal', prefixIcon: Icon(Icons.home_filled)),
      ),
    );
  }

  Widget _textFieldProvincia() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: con.provinciaController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            hintText: 'Provincia', prefixIcon: Icon(Icons.import_contacts)),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: con.telefonoController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
            hintText: 'Télefono', prefixIcon: Icon(Icons.phone)),
      ),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: ElevatedButton(
        onPressed: () => con.updateInfo(context),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text(
          'Actualizar',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
