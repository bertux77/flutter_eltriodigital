import 'package:eltriodigital_flutter/src/pages/tienda/pedidos/tienda_pedidos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TiendaPedidosPage extends StatelessWidget {
  TiendaPedidosController con = Get.put(TiendaPedidosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('TiendaPedidosPage'),
      ),
    );
  }
}
