// ignore_for_file: unnecessary_string_escapes

import 'package:eltriodigital_flutter/src/pages/tienda/pedidos/confirmacion/tienda_pedidos_confirmacion_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/my_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TiendaPedidosConfirmacionPage extends StatelessWidget {
  TiendaPedidosConfirmacionController con = Get.put(TiendaPedidosConfirmacionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Center(
        child: Container(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Text(
                  '¡ENHORABUNEA!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              const Text('Tu compra se ha realizado correctamente'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Text('${con.messageConfirmacion}', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              Text('Nº Pedido: #${con.ventaId}'),
              Center(
                child: Lottie.network(
                    'https://assets9.lottiefiles.com/packages/lf20_qckmbbyi.json',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
