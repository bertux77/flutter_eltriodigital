import 'package:eltriodigital_flutter/src/pages/perfil/info/perfil_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilInfoPage extends StatelessWidget {
  PerfilInfoController con = Get.put(PerfilInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => SingleChildScrollView(
        child: Container(
          //padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.blue[200],
          child: Column(
            children: [
              _imageUser(context),
              _cajaFormulario(context),
              //_backgroundCover(context),
              //_boxForm(context),
              _buttonUpdate(context),
              // Column(
              //   children: [_buttonSignOut(), _buttonRoles()],
              // )
            ],
          ),
        ),
      ),
    ));
  }

  // Widget _fondo(BuildContext context) {
  //   return Container(
  //     width: double.infinity,
  //     height: MediaQuery.of(context).size.height * 0.4,
  //     color: Colors.blue[100],
  //   );
  // }

  Widget _cajaFormulario(BuildContext context) {
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
      child: Column(children: [
        _textYourInfo(),
        _textName(),
        _textEmail(),
        _textDireccion(),
        _textPoblacion(),
        _textCp(),
        _textProvincia(),
        _textPhone(),
      ]),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
      child: const Text(
        'TU INFORMACIÓN DE PERFIL',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(top: 10),
      alignment: Alignment.topCenter,
      child: CircleAvatar(
        backgroundImage: con.user.value.image != null
            ? NetworkImage(con.user.value.image!)
            : const AssetImage('assets/img/user_profile.png') as ImageProvider,
        radius: 50,
        backgroundColor: Colors.white,
      ),
    ));
  }

  Widget _textName() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: ListTile(
        dense: true,
        leading: const Icon(
          Icons.person,
          //color: Colors.white,
        ),
        title: Text(con.user.value.name ?? ''),
        subtitle: const Text('Nombre completo'),
      ),
    );
  }

  Widget _textEmail() {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.email),
      title: Text(con.user.value.email ?? ''),
      subtitle: const Text('Email'),
    );
  }

  Widget _textDireccion() {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.map),
      title: Text(con.user.value.direccion ?? ''),
      subtitle: const Text('Dirección'),
    );
  }

  Widget _textPoblacion() {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.location_city),
      title: Text(con.user.value.poblacion ?? ''),
      subtitle: const Text('Población'),
    );
  }

  Widget _textCp() {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.home_filled),
      title: Text(con.user.value.cp ?? ''),
      subtitle: const Text('Código postal'),
    );
  }

  Widget _textProvincia() {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.import_contacts),
      title: Text(con.user.value.provincia ?? ''),
      subtitle: const Text('Provincia'),
    );
  }

  Widget _textPhone() {
    return ListTile(
      dense: true,
      leading: const Icon(Icons.phone),
      title: Text(con.user.value.telefono ?? ''),
      subtitle: const Text('Télefono'),
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      child: ElevatedButton(
        onPressed: () => con.goToProfileUpdate(),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15)),
        child: const Text(
          'Editar perfil',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
