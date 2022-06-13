import 'package:eltriodigital_flutter/src/pages/tienda/pedidos/detalle/tienda_pedidos_detalle_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/appbar/my_appbar.dart';
import 'package:eltriodigital_flutter/src/widgets/bottomNavigationBar/My_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TiendaPedidosDetallePage extends StatelessWidget {
  TiendaPedidosDetalleController con =
      Get.put(TiendaPedidosDetalleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Column(
        children: [
          Text('Tu Ticket'),
          Container(
            width: double.infinity * 0.80,
            height: double.infinity * 0.80,
            color: Theme.of(context).colorScheme.primary,
            child: Container(
              margin: EdgeInsets.all(20),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
