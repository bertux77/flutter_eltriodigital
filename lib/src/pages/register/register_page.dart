import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'register_controller.dart';

class RegisterPage extends StatelessWidget {
   
  RegisterController con = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textoTienesCuenta(),
      ),
      body: Stack(
        children: [
          _fondo(context),
          _cajaFormulario(context),
          Column(
            children: [
              _logoImagen(),
              _textoAppName(),
            ],
          )
        ],
      )
    );
  }
  Widget _cajaFormulario(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      margin: EdgeInsets.only(top:  MediaQuery.of(context).size.height * 0.33,left: 50, right: 50),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 33, 95, 1),
            blurRadius: 15,
            offset: Offset(0,0.75)
            ),
            
          
        ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textIngresaInformacion(),
            _textFieldName(),
            _textFieldEmail(),
            _textFieldPassword(),
            _textFieldConfirmPassword(),
            _botonEnviar()
          ],
        ),
      ),
    );
  }

  Widget _textIngresaInformacion(){
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 30),
      child: const Text('INGRESA ESTA INFORMACIÓN'));
  }

  Widget _textFieldName(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.nameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Nombre',
          prefixIcon: Icon(Icons.person_add)
        ),
      ),
    );
  }

  Widget _textFieldEmail(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: 'Correo electronico',
          prefixIcon: Icon(Icons.email)
        ),
      ),
    );
  }

  Widget _textFieldPassword(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.passwordController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Contraseña',
          prefixIcon: Icon(Icons.lock)
        ),
      ),
    );
  }

  Widget _textFieldConfirmPassword(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: con.confirmpasswordController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: 'Confirmar Contraseña',
          prefixIcon: Icon(Icons.lock)
        ),
      ),
    );
  }

  Widget _botonEnviar(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40 ,vertical: 10),
      child: ElevatedButton(
        onPressed: () => con.register(), 
        child: const Text('REGISTRAR',
          style: TextStyle(color: Colors.white),
          ),
        ),
    );
  }


  Widget _fondo(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.blue[100],
    );
  }
  Widget _logoImagen(){
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/img/logo.gif',
          width: 250,
        ),
      ),
    );
  }

  Widget _textoAppName(){
    return const Text('REGISTRO', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 5, 24, 56)),);
  }

  Widget _textoTienesCuenta()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿Ya tienes cuenta?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[300],)),
        const SizedBox(width: 7,),
        GestureDetector(
          onTap: () => con.goToLogin(),
          child: const Text('Entra aquí', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 5, 24, 56)),)),
      ],
    );
  }
}