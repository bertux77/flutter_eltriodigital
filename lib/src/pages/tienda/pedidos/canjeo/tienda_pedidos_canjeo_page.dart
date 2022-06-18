import 'package:eltriodigital_flutter/src/pages/tienda/pedidos/canjeo/tienda_pedidos_canjeo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TiendaPedidosCanjeoPage extends StatelessWidget {
  TiendaPedidosCanjeoController con = Get.put(TiendaPedidosCanjeoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => con.goToPerfilPage(),
          ),
          title: const Text(
            "¡Enhorabuena!",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => con.goToPerfilPage(),
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        body: FutureBuilder(
            future: con.futuroIncierto(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else {
                return Center(
                  child: Stack(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '¡ENHORABUENA!',
                              style: TextStyle(fontSize: 32),
                            ),
                            Text(
                              'Has obtenido ${con.beneficio}€ en tu wallet',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                      Container(
                        child: Lottie.network(
                            'https://assets8.lottiefiles.com/packages/lf20_llqi3lop.json',
                            width: 400,
                            height: 600,
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
