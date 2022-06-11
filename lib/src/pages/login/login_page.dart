import 'package:eltriodigital_flutter/src/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
   
  LoginController con = Get.put(LoginController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textoNoTienesCuenta(),
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
      height: MediaQuery.of(context).size.height * 0.45,
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
            _textFieldEmail(),
            _textFieldPassword(),
            _botonEnviar(),
            //_botonPrueba()
          ],
        ),
      ),
    );
  }

  Widget _textIngresaInformacion(){
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 50),
      child: const Text('INGRESA ESTA INFORMACIÓN'));
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

  Widget _botonEnviar(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40 ,vertical: 10),
      child: ElevatedButton(
        onPressed: () => con.login(), 
        child: const Text('LOGIN',
          style: TextStyle(color: Colors.white),
          
          ),
        ),
    );
  }

  Widget _botonPrueba(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40 ,vertical: 10),
      child: ElevatedButton(
        onPressed: () => con.prueba(), 
        child: const Text('PRUEBA',
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
    return const Text('Entrar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 5, 24, 56)),);
  }

  Widget _textoNoTienesCuenta()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿No tienes cuenta?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[300],)),
        const SizedBox(width: 7,),
        GestureDetector(
          onTap: () => con.goToRegisterPage(),
          child: const Text('Registrate aquí', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 5, 24, 56)),)),
      ],
    );
  }


}