import 'package:eltriodigital_flutter/src/models/pedido.dart';
import 'package:eltriodigital_flutter/src/pages/tienda/pedidos/detalle/tienda_pedidos_detalle_controller.dart';
import 'package:eltriodigital_flutter/src/widgets/varios/fecha_formateada.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TiendaPedidosDetallePage extends StatelessWidget {
  TiendaPedidosDetalleController con =
      Get.put(TiendaPedidosDetalleController());
  //final apiController = Get.put(ApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            "Nutrición Canarias",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        //bottomNavigationBar: MyBottomNavigationBar(),
        body: Container(
          child: GetBuilder<TiendaPedidosDetalleController>(
            init: TiendaPedidosDetalleController(),
            builder: (value) => value.isLoading
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tu ticket #${value.pedido.value.id}',
                              style: const TextStyle(fontSize: 36),
                            ),
                            FechaFormateada(
                              fecha: value.pedido.value.createdAt.toString(),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              thickness: 2,
                            ),
                            _listarProductosVendidos(
                                value.pedido.value.productosVendidos),
                            const Divider(
                              thickness: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Subtotal: ${(value.pedido.value.totalVenta! - value.pedido.value.canjeoWallet!)}€',
                              style: const TextStyle(fontSize: 26),
                            ),
                            Text(
                              'Canjeo: ${value.pedido.value.canjeoWallet}€',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Total: ${value.pedido.value.totalVenta}€',
                              style: const TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ));
  }

  Widget _listarProductosVendidos(List<ProductosVendido>? productos) {
    List<Widget> list = [];
    for (var i = 0; i < productos!.length; i++) {
      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productos[i].nombre.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Text('${productos[i].ud.toString()}x'),
                const SizedBox(
                  width: 5,
                ),
                Text('${productos[i].venta?.toStringAsFixed(2)} €'),
              ],
            ),
          ],
        ),
      ));
    }
    return Column(children: list);
  }
}
