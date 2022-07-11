import 'package:eltriodigital_flutter/src/pages/perfil/perfil_page_controller.dart';
import 'package:eltriodigital_flutter/src/providers/users_providers.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/my_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerfilPage extends StatelessWidget {
  PerfilPageController con = Get.put(PerfilPageController());
  UsersProvider usersProvider = UsersProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Tu perfil'),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => con.goToPerfilPedidosWalletPage(),
                child: const _btnGordo(
                  icon: Icons.euro,
                  color1: Color(0xff2F80ED),
                  color2: Color.fromARGB(255, 21, 63, 117),
                  titulo: 'Mi wallet',
                ),
              ),
              GestureDetector(
                onTap: () => con.goToPerfilPedidosOnlinePage(),
                child: const _btnGordo(
                  icon: Icons.shopping_cart_checkout,
                  color1: Color(0xff2F80ED),
                  color2: Color.fromARGB(255, 21, 63, 117),
                  titulo: 'Mis pedidos',
                ),
              ),
              GestureDetector(
                onTap: () => con.scanBar(),
                child: const _btnGordo(
                  icon: Icons.qr_code_2,
                  color1: Color(0xff2F80ED),
                  color2: Color.fromARGB(255, 21, 63, 117),
                  titulo: 'Scan Pedido',
                ),
              ),
              GestureDetector(
                onTap: () => con.goToPerfilShowQrPage(),
                child: const _btnGordo(
                  icon: Icons.qr_code_scanner_outlined,
                  color1: Color(0xff2F80ED),
                  color2: Color.fromARGB(255, 21, 63, 117),
                  titulo: 'Mi QR',
                ),
              ),
              GestureDetector(
                onTap: () => con.goToPerfilEditarPage(),
                child: const _btnGordo(
                  icon: Icons.person,
                  color1: Color(0xff2F80ED),
                  color2: Color.fromARGB(255, 21, 63, 117),
                  titulo: 'Editar perfil',
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

// Widget _botonGordo(){
//   return
// }

class _btnGordo extends StatelessWidget {
  final IconData icon;
  final Color color1;
  final Color color2;
  final String titulo;
  const _btnGordo(
      {Key? key,
      required this.icon,
      required this.color1,
      required this.color2,
      required this.titulo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _BotonGordoBackground(
          color1: color1,
          color2: color2,
          icon: icon,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
              width: 5,
            ),
            const SizedBox(
              width: 20,
            ),
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                titulo,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    decoration: TextDecoration.none),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
          ],
        )
      ],
    );
  }
}

class _BotonGordoBackground extends StatelessWidget {
  final IconData icon;
  final Color color1;
  final Color color2;

  const _BotonGordoBackground({
    Key? key,
    required this.icon,
    required this.color1,
    required this.color2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                icon,
                size: 150,
                color: Colors.white.withOpacity(0.2),
              ),
            )
          ],
        ),
      ),
      width: double.infinity,
      height: 85,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(4, 6),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(15),
          //color: Colors.red,
          gradient: LinearGradient(
            colors: [color1, color2],
          )),
    );
  }
}
