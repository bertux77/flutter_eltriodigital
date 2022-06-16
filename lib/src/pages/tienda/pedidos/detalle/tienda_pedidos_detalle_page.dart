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
    return Obx(() => Scaffold(
      appBar: MyAppBar(),
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Center(child: Text('Tu Ticket # ${con.numeroFactura.value}', style: TextStyle(fontSize: 30),))),
            ],
          )
      ));
  }
}
